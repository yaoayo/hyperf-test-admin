<?php

declare (strict_types = 1);
/**
 * This file is part of Hyperf.
 *
 * @link     https://www.hyperf.io
 * @document https://hyperf.wiki
 * @contact  group@hyperf.io
 * @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
 */

namespace App\Controller;

use App\Constants\AgentShopBindType;
use App\Constants\AgentUserShopState;
use App\Constants\VoucherCat;
use App\Constants\VoucherState;
use App\Exception\HttpRequestException;
use App\Model\IncomeOperationLog;
use App\Model\MerchantShop;
use App\Model\UserShop;
use App\Model\Voucher;
use App\Model\VoucherBindLog;
use Hyperf\DbConnection\Db;
use App\Service\CacheConfigService;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\Validation\Contract\ValidatorFactoryInterface;

class BindController extends AbstractController
{

    protected $validationFactory;

    public function __construct(ValidatorFactoryInterface $validationFactory)
    {
        $this->validationFactory = $validationFactory;
    }
    /**
     * [needBind 可分配店铺数量]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function needBind(RequestInterface $request)
    {
        $total = MerchantShop::whereNotExists(function ($query) {
                $query->select(Db::raw(1))
                        ->from('ag_user_shop')
                        ->whereRaw("`mch_shop`.`id` = ag_user_shop.shop_id AND `ag_user_shop`.`state` = 1 AND `ag_user_shop`.`deleted` IS NULL ");
            })->whereRaw("`mch_shop`.`state` = 1 and `mch_shop`.`mch_id` > 0 ")
            ->count();
        return $this->success(['total' => $total]);
    }
    /**
     * [allocation 券绑定店铺、商户、代理商]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function allocation(RequestInterface $request)
    {

        $voucher_ids = $request->input('voucher_id', []);

        if (!is_array($voucher_ids)) {
            throw new HttpRequestException('券ID字段必须是数组');
        }
        if (empty($voucher_ids)) {
            throw new HttpRequestException('券ID不能为空！');
        }

        // 查询用户 代推、待分配的券
        $Voucher = Voucher::leftJoin('ag_user', 'ag_user_voucher.ag_user_id', '=', 'ag_user.id')
            ->where('ag_user_voucher.state', VoucherState::STATE_ALLOCATION)
            ->where('ag_user_voucher.cat', VoucherCat::SYSTEM)
            ->whereIn('ag_user_voucher.id', $voucher_ids);

        $select_count = count($voucher_ids);
        $voucher_count = $Voucher->count();
        if ( $voucher_count == 0 || $select_count > $voucher_count) {
            throw new HttpRequestException('该券的数据状态不满足操作！');
        }

        // 查询可用店铺
        $MerchantShop = MerchantShop::leftJoin('mch_merchant', 'mch_shop.mch_id', '=', 'mch_merchant.id')
            ->selectRaw('`mch_shop`.`id`,`mch_shop`.`shop_name`,`mch_shop`.`phone`,`mch_shop`.`mch_id`,`mch_merchant`.`mch_name`')
            ->whereNotExists(function ($query) {
                $query->select(Db::raw(1))
                        ->from('ag_user_shop')
                        ->whereRaw("`mch_shop`.`id` = ag_user_shop.shop_id AND `ag_user_shop`.`state` = 1 AND `ag_user_shop`.`deleted` IS NULL ");
            })
            ->whereRaw("`mch_shop`.`state` = 1 and `mch_shop`.`mch_id` > 0 ")
            ->limit($select_count);

        // 可以店铺统计
        $MerchantShopCount = $MerchantShop->count();

        if (empty($MerchantShopCount)) {
            throw new HttpRequestException('没有可分配的店铺！');
        }

        if (count($voucher_ids) > $MerchantShopCount) {
            throw new HttpRequestException('店铺数量不满足分配！');
        }

        // 店铺数据
        $MerchantShopData = $MerchantShop->get()->toArray();

        // 券数据
        $VoucherData = $Voucher->selectRaw('`ag_user_voucher`.*,`ag_user`.`agent_name`,`ag_user`.`phone`')->get()->toArray();

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

        // 获取授权账户信息
        $myid = auth()->user()->id;
        $myname = auth()->user()->username;
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
                'bind_type' => AgentShopBindType::ALLOCATION,
                'create_time' => $create_time,
            ];
            $bind_log[] = [
                'oper_id' => $myid,
                'oper_name' => $myname,
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

            // 绑定店铺 记录绑定日志 更新绑定的券
            if (UserShop::insert($create_data) && VoucherBindLog::insert($bind_log) && Voucher::whereIn('id', $update_voucher_ids)->update([
                'state' => VoucherState::STATE_COMPLTET_ALLOCATION,
                'invite_allot_time' => $create_time,
            ])) {
                Db::commit();
                return $this->success();
            }
            Db::rollBack();
        } catch (\Throwable $ex) {
            Db::rollBack();
        }
        return $this->fail('操作失败！');
    }
    /**
     * [list 绑定日志列表]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    function list(RequestInterface $request) {

        // 店铺ID
        $shop_id = $request->input('shop_id', 0);

        //开始时间查找
        $start_time = $request->input('start_time');

        //结束时间查找
        $end_time = $request->input('end_time');
        // 搜索
        $search = $request->input('search');
        $where = [];
        if (!empty($start_time) && !empty($end_time)) {
            if (strtotime($start_time) >= strtotime($end_time)) {
                throw new HttpRequestException('开始时间不能大于结束时间！');
            }
        }
        if (!empty($shop_id)) {
            $where['shop_id'] = $shop_id;
        }

        $VoucherBindLog = VoucherBindLog::where($where);
        if (!empty($search)) {
            $VoucherBindLog = $VoucherBindLog->whereRaw("((`shop_name` like '%{$search}%') or (`agent_name` like '%{$search}%') or (`agent_phone` like '%{$search}%') or (`shop_phone` like '%{$search}%'))");
        }

        // 时间范围查询
        if (!empty($start_time) && !empty($end_time)) {
            $VoucherBindLog = $VoucherBindLog->whereBetween('create_time', [$start_time, $end_time]);
        }

        return $this->success($VoucherBindLog->orderBy('create_time', 'desc')->paginate((int) $request->input('per_page', $this->per_page)));
    }
    /**
     * [info 绑定详情]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function info(RequestInterface $request)
    {
        $voucher_id = $request->input('voucher_id', 0);
        $info = UserShop::where('voucher_id', $voucher_id)->with(['agent', 'merchant', 'shop'])->first();
        return $this->success($info);
    }

    /**
     * [updateIncome 修改收益配置]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function updateIncome(RequestInterface $request)
    {

        $validator = $this->validationFactory->make(
            $request->all(),
            [
                'id' => 'required|numeric|gt:0',
                'bonus_start_date' => 'required_if:bonus_date_limit,1|date|before:bonus_valid_date',
                'bonus_valid_date' => 'required_if:bonus_date_limit,1|date|after:bonus_start_date',
                'bonus_date_limit' => 'required|boolean',
                'bonus_limit' => 'present|numeric|gt:0',
            ]
        );

        if ($validator->fails()) {
            $errors = $validator->errors();
            throw new HttpRequestException($errors->first());
        }
        $post = $validator->getData();
        $UserShop = UserShop::where('id', $post['id'])->first();
        if (empty($UserShop)) {
            throw new HttpRequestException('未找到操作记录');
        }

        $old_valid_date = $UserShop->bonus_start_date . '~' . $UserShop->bonus_valid_date;
        if ($UserShop->bonus_date_limit == 0) {
            $old_valid_date = '永久';
        }

        $new_valid_date = $post['bonus_start_date'] . '~' . $post['bonus_valid_date'];
        if (isset($post['bonus_date_limit']) && $post['bonus_date_limit'] == 0) {
            $new_valid_date = '永久';
        }
        $my = auth()->user();
        $OperationLog = [
            'oper_id' => $my->id,
            'oper_name' => $my->username,
            'shop_id' => $UserShop->shop_id,
            'bind_id' => $post['id'],
            'old_valid_date' => $old_valid_date,
            'new_valid_date' => $new_valid_date,
            'old_bonus_limit' => $UserShop->bonus_limit,
            'new_bonus_limit' => $post['bonus_limit'],
            'content' => '操作ID为' . $post['id'],
            'create_time' => date('Y-m-d H:i:s'),
        ];

        Db::beginTransaction();
        try {

            if ($UserShop->update($post) && IncomeOperationLog::insert($OperationLog)) {
                Db::commit();
                return $this->success();
            }

            Db::rollBack();
            return $this->fail('操作失败！');

        } catch (\Throwable $ex) {
            Db::rollBack();
        }

        return $this->fail('操作失败！');
    }
    /**
     * [updateIncomelog 修改收益配置日志列表]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function updateIncomelog(RequestInterface $request)
    {

        // 店铺ID
        $shop_id = $request->input('shop_id', 0);
        // 绑定ID
        $bind_id = $request->input('bind_id', 0);
        //开始时间查找
        $start_time = $request->input('start_time');
        //结束时间查找
        $end_time = $request->input('end_time');
        // 搜索
        $search = $request->input('search');
        $where = [];
        if (!empty($start_time) && !empty($end_time)) {
            if (strtotime($start_time) >= strtotime($end_time)) {
                throw new HttpRequestException('开始时间不能大于结束时间！');
            }
        }
        if (!empty($shop_id)) {
            $where['shop_id'] = $shop_id;
        }
        if (!empty($bind_id)) {
            $where['bind_id'] = $bind_id;
        }
        $IncomeOperationLog = IncomeOperationLog::where($where);
        if (!empty($search)) {
            $IncomeOperationLog = $IncomeOperationLog->where('oper_name', 'like', '%' . $search . '%');
        }

        // 时间范围查询
        if (!empty($start_time) && !empty($end_time)) {
            $IncomeOperationLog = $IncomeOperationLog->whereBetween('create_time', [$start_time, $end_time]);
        }

        return $this->success($IncomeOperationLog->orderBy('create_time', 'desc')->paginate((int) $request->input('per_page', $this->per_page)));
    }

}
