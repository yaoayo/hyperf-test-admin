<?php

namespace App\Crontab;

use App\Constants\VoucherState;
use App\Service\CacheConfigService;
use App\Constants\AgentShopBindType;
use App\Constants\AgentUserShopState;
use App\Constants\VoucherCat;
use App\Model\MerchantShop;
use App\Model\UserShop;
use App\Model\Voucher;
use App\Model\VoucherBindLog;
use Hyperf\DbConnection\Db;

class VoucherAutoBindShopTask
{
    public function execute()
    {
        // 是否开启自动绑定店铺定时任务
        if (CacheConfigService::getKey('VoucherAutoBindShopTask','CrontabTask') == true) {
            // 系统是否开启自动绑定店铺
            if (CacheConfigService::getKey('state','AutoStoreSet') == true) {
               if ($this->bind()) return true;
            }
        }
        return false;
    }

    public function isEnable(): bool
    {
        return true;
    }

    /**
     * [bind 券绑定店铺、商户、代理商]
     * @return [type]                    [description]
     */
    public function bind()
    {
        // 获取券激活后多少天开始绑定店铺
        $activate_day = CacheConfigService::getKey('activateDay','AutoStoreSet') ?? 7;
        // 查询用户 代推、待分配的券
        $Voucher = Voucher::leftJoin('ag_user', 'ag_user_voucher.ag_user_id', '=', 'ag_user.id')
            ->where([
                'ag_user_voucher.state'=>VoucherState::STATE_ALLOCATION,
                'ag_user_voucher.cat'=>VoucherCat::SYSTEM
            ])
            ->selectRaw('`ag_user_voucher`.*,`ag_user`.`agent_name`,`ag_user`.`phone`,datediff(now(),`ag_user_voucher`.`activated_time`) as day_num')
            ->whereRaw('datediff(now(),`ag_user_voucher`.`activated_time`) >= '.$activate_day);

        if ($Voucher->count() <= 0) return false;
        
        // 查询可用店铺
        $MerchantShop = MerchantShop::leftJoin('mch_merchant', 'mch_shop.mch_id', '=', 'mch_merchant.id')
            ->selectRaw('`mch_shop`.`id`,`mch_shop`.`shop_name`,`mch_shop`.`phone`,`mch_shop`.`mch_id`,`mch_merchant`.`mch_name`')
            ->whereNotExists(function ($query) {
                $query->select(Db::raw(1))
                        ->from('ag_user_shop')
                        ->whereRaw("`mch_shop`.`id` = ag_user_shop.shop_id AND `ag_user_shop`.`state` = 1 AND `ag_user_shop`.`deleted` IS NULL ");
            })
            ->whereRaw("`mch_shop`.`state` = 1 and `mch_shop`.`mch_id` > 0 ");

        if ($MerchantShop->count() <= 0) return false;

        // 店铺数据
        $MerchantShopData = $MerchantShop->limit(20)->get()->toArray();

        // 券数据
        $VoucherData = $Voucher->limit(count($MerchantShopData))->orderBy('day_num','desc')->get()->toArray();

        // 获取配置
        // 1代表有效天数 2 永久
        $store_type = CacheConfigService::getKey('type','Store') ?? 1;
        // 分成有效期天数
        $store_day = CacheConfigService::getKey('day','Store') ?? 0;
        //代推分成上限
        $store_system = CacheConfigService::getKey('systemDeploy','Store') ?? 0;
        //自推分成上限
        $store_autonomy = CacheConfigService::getKey('autonomyDeploy','Store') ?? 0;

        $create_data = [];
        $update_voucher_ids = [];
        $bind_log = [];
        $create_time = date('Y-m-d H:i:s');

        foreach ($VoucherData as $key => $voucher) {
            $create_data[] = [
                'agent_id' => $voucher['ag_user_id'],
                'agent_name' => $voucher['agent_name'],
                'mch_id' => $MerchantShopData[$key]['mch_id'],
                'mch_name' => $MerchantShopData[$key]['mch_name'],
                'shop_id' => $MerchantShopData[$key]['id'],
                'shop_name' => $MerchantShopData[$key]['shop_name'],
                'voucher_id' => $voucher['id'],
                'bonus_date_limit'=>$store_type,
                'bonus_start_date' => date('Y-m-d', strtotime("+1 days")),
                'bonus_valid_date' => date('Y-m-d', strtotime("+{$store_day} days")),
                'bonus_limit' => ($voucher['cat'] == VoucherCat::INVITE) ? $store_autonomy : $store_system,
                'state' => AgentUserShopState::NOTQUALIFIED,
                'bind_type' => AgentShopBindType::AUTO,
                'create_time' => $create_time,
            ];
            $bind_log[] = [
                'oper_id' => 0,
                'oper_name' => '系统自动绑定',
                'agent_id' => $voucher['ag_user_id'],
                'agent_name' => $voucher['agent_name'],
                'agent_phone' => $voucher['phone'],
                'shop_id' => $MerchantShopData[$key]['id'],
                'shop_name' => $MerchantShopData[$key]['shop_name'],
                'shop_phone' => $MerchantShopData[$key]['phone'],
                'voucher_id' => $voucher['id'],
                'create_time' => $create_time,
            ];
        }

        $update_voucher_ids = array_column($create_data, 'voucher_id');

        Db::beginTransaction();
        try {
            // 绑定店铺 and 记录绑定日志 and 更新绑定的券
            if (UserShop::insert($create_data) && VoucherBindLog::insert($bind_log) && Voucher::whereIn('id', $update_voucher_ids)->update([
                'state' => VoucherState::STATE_COMPLTET_ALLOCATION,
                'invite_allot_time' => date('Y-m-d H:i:s'),
            ])) {
                Db::commit();
                return true;
            }
            Db::rollBack();
        } catch (\Throwable $ex) {
            Db::rollBack();
        }
        return false;
    }
}
