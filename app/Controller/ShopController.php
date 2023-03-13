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

use App\Constants\AgentIncomeCatCode;
use App\Constants\AgentShopBindType;
use App\Constants\AgentUserShopState;
use App\Constants\SoureCode;
use App\Model\AgUserIncome;
use App\Model\Merchant;
use App\Model\MerchantShop;
use App\Model\ShopDelLog;
use App\Model\UserShop;
use App\Utils\Log;
use Hyperf\DbConnection\Db;
use Hyperf\HttpServer\Contract\RequestInterface;

class ShopController extends AbstractController
{
    /**
     * 获取门店列表
     */
    function list(RequestInterface $request) {
        //按名称、电话、代理商姓名查询
        $name = $request->input('name', '');
        $obj = UserShop::query()
            ->select(['ag_user_shop.id', 'mch_shop.shop_name', 'mch_shop.phone', 'mch_shop.addr', 'ag_user_shop.mch_name', 'ag_user_shop.id as bind_id', 'mch_shop.source',
                'ag_user.agent_name', 'ag_user_shop.bind_type', 'ag_user_shop.create_time', 'ag_user_shop.bonus_income', 'ag_user_shop.state', 'ag_user_shop.bonus_limit'
                , 'ag_user_shop.bonus_start_date', 'ag_user_shop.bonus_valid_date', 'ag_user_shop.bonus_date_limit', 'ag_user.phone as agent_phone', 'ag_user_shop.shop_id'])
            ->leftJoin('mch_shop', 'mch_shop.id', '=', 'ag_user_shop.shop_id')
            ->leftJoin('ag_user', 'ag_user.id', '=', 'ag_user_shop.agent_id');

        //按门店类型查询
        $voucher_code = $request->input('voucher_code', 0);
        if ($voucher_code) {
            $obj->where('ag_user_shop.bind_type', $voucher_code);
        }

        //按门店状态查询
        $state = $request->input('state', 0);
        if ($state) {
            $obj->where('ag_user_shop.state', $state);
        }

        //按门店分配时间查询
        $start_time = $request->input('start_time', '');
        $end_time = $request->input('end_time', '');
        if ($start_time) {
            $obj->where('ag_user_shop.create_time', '>=', $start_time);
        }
        if ($end_time) {
            $obj->where('ag_user_shop.create_time', '<=', $end_time);
        }

        if ($name) {
            $obj->where([[function ($query) use ($name) {
                $query->where('mch_shop.phone', 'like', '%' . $name . '%')
                    ->orWhere('mch_shop.shop_name', 'like', '%' . $name . '%')
                    ->orWhere('ag_user.phone', 'like', '%' . $name . '%')
                    ->orWhere('ag_user.agent_name', 'like', '%' . $name . '%');
            }]]);
        }

        $t_obj = clone $obj;
        $total_income = $t_obj->selectRaw('sum(ag_user_shop.bonus_income + ag_user_shop.subsidy_income) as t')->value('t');
        //收益排序
        $bonus_sort = $request->input('bonus_sort', '');
        if ($bonus_sort) {
            if ($bonus_sort == 1) {
                $obj->orderBy('bonus_income');
            } else {
                $obj->orderBy('bonus_income', 'desc');
            }
        }

        $list = $obj->orderBy('id', 'desc')->paginate((int) $request->input('per_page', $this->per_page));
        foreach ($list->items() as &$val) {
            $val['state'] = AgentUserShopState::getMessage($val['state']);
            $val['source'] = SoureCode::getMessage($val['source']);
            $val['bind_type'] = AgentShopBindType::getMessage($val['bind_type']);
        }
        if ($list) {
            $list = $list->toArray();
            $list['total_income'] = $total_income;
        }
        return $this->success($list);
    }

    public function del(RequestInterface $request)
    {
        $id = (int) $request->input('id', 0);
        $mark = $request->input('content', '');
        $shop = UserShop::query()->find($id);
        Db::beginTransaction();
        if ($shop) {
            $shop->state = AgentUserShopState::FAILURE;
            $shop->invalid_time = date('Y-m-d H:i:s');
            if ($shop->save()) {
                $del = [
                    'type' => 1,
                    'oper_id' => auth()->user()->id ?? 0,
                    'oper_name' => auth()->user()->real_name ?? '',
                    'oper_phone' => auth()->user()->mobile ?? '',
                    'agent_id' => $shop->agent_id ?? 0,
                    'bonus_income' => $shop->bonus_income ?? 0,
                    'mch_name' => $shop->mch_name ?? '',
                    'agent_name' => $shop->agent_name ?? '',
                    'agent_phone' => '',
                    'shop_id' => $shop->shop_id ?? 0,
                    'shop_name' => $shop->shop_name ?? '',
                    'content' => $mark,
                    'create_time' => date('Y-m-d H:i:s'),
                ];
                ShopDelLog::create($del);
                Db::commit();
                return $this->success();
            }
            Db::rollBack();
        }
        return $this->fail('删除失败');
    }

    //获取门店删除日志
    public function delList(RequestInterface $request)
    {
        $type = $request->input('type', 1);
        $obj = ShopDelLog::query()->where('type', $type);
        //按关键字搜索
        $title = $request->input('title', '');
        if ($title) {
            $obj->where([[function ($query) use ($title) {
                $query->where('agent_name', 'like', '%' . $title . '%')
                    ->orWhere('oper_name', 'like', '%' . $title . '%');
            }]]);
        }

        //按门店删除时间查询
        $start_time = $request->input('start_time', '');
        $end_time = $request->input('end_time', '');
        if ($start_time) {
            $obj->where('create_time', '>=', $start_time);
        }
        if ($end_time) {
            $obj->where('create_time', '<=', $end_time);
        }
        $bonus_income = $obj->sum('bonus_income');
        $list = $obj->orderBy('id', 'desc')->paginate((int) $request->input('per_page', $this->per_page));
        if ($list) {
            $list = $list->toArray();
            $list['bonus_income'] = $bonus_income;
        }
        return $this->success($list);
    }

    /**
     * 门店补贴记录
     */
    public function log(RequestInterface $request)
    {
        //获取参数
        $name = $request->input('name'); //搜索类容

        $shopname = $request->input('shopname'); //搜索类容

        $date = $request->input('date'); //搜索时间

        //检索条件
        $where = [];
        $where[] = ['cat', '=', AgentIncomeCatCode::AGEVNT_INCOME_CAT_SHOP];
        if ($shopname) {
            $where[] = ['subsidy_shop_name', '=', $shopname];
        }
        $time = $date ? date('Ym', strtotime($date[0])) : date('Ym');
        $query = new AgUserIncome($time);
        $table = 'ag_user_income_' . $time;
        $query = $query->leftJoin('ag_user', 'ag_user.id', '=', $table . '.agent_id');
        $query = $query->where($where);
        if ($name) {
            $query = $query->where('ag_user.phone', 'like', '%' . $name . '%')
                ->orWhere($table . '.agent_name', 'like', '%' . $name . '%');
        }
        if ($date) {
            $query = $query->whereBetween($table . '.create_time', [date('Y-m-d 00:00:00', strtotime($date[0])), date('Y-m-d 00:00:00', strtotime('+1day', strtotime($date[1])))]);
        }

        $total_amount = $query->where($where)->selectRaw($table . '.*,ag_user.phone')->sum('income_amount') ?? 0;

        $list = $query->selectRaw($table . '.*,ag_user.phone')->orderBy($table . '.id', 'desc')->paginate((int) $request->input('per_page', $this->per_page));

        $list = $list->toArray();

        $list['total_amount'] = $total_amount;

        return $this->success($list);
    }

    //获取门店详情接口
    public function detail(RequestInterface $request)
    {

        $id = $request->input('id');
        $data = UserShop::where('ag_user_shop.id', $id)
            ->leftJoin('mch_shop', 'mch_shop.id', '=', 'ag_user_shop.shop_id')
            ->selectRaw('ag_user_shop.*,mch_shop.avg_order_num,mch_shop.mch_id,mch_shop.shop_name,mch_shop.source,mch_shop.source_shop_id,mch_shop.addr,mch_shop.phone,mch_shop.all_order_num')
            ->first();
        if ($data) {
            $data->state = AgentUserShopState::getMessage($data->state);
            $data->bind_type = AgentShopBindType::getMessage($data->bind_type);
        }

        return $this->success($data);
    }

    /**
     * 门店详情-补贴记录
     */
    public function detailLog(RequestInterface $request)
    {
        $shop_id = $request->input('shop_id'); //门店id
        if (!$shop_id) {
            return $this->fail('门店id必填');
        }

        $date = $request->input('date'); //搜索时间

        //查询门店
        $Shop = UserShop::query()->where('id', $shop_id)->first();
        //检索条件
        $where = [];
        $where[] = ['cat', '=', AgentIncomeCatCode::AGEVNT_INCOME_CAT_SHOP];
        $where[] = ['subsidy_shop_id', '=', $Shop['shop_id']];
        $where[] = ['agent_id', '=', $Shop['agent_id']];

        $time = $date ? date('Ym', strtotime($date[0])) : date('Ym');
        $query = new AgUserIncome($time);
        $query = $query->where($where);
        if ($date) {
            $query = $query->whereBetween('create_time', [date('Y-m-d 00:00:00', strtotime($date[0])), date('Y-m-d 00:00:00', strtotime('+1day', strtotime($date[1])))]);
        }

        $list = $query->paginate((int) $request->input('per_page', $this->per_page));

        return $this->success($list);
    }

    /**
     * @param RequestInterface $request
     * 门店池子 记录
     */
    public function shopList(RequestInterface $request)
    {
        $obj = MerchantShop::query();
        $name = $request->input('name', '');
        if ($name) {
            $obj->where('phone', 'like', '%' . $name . '%')
                ->orWhere('shop_name', 'like', '%' . $name . '%');
        }

        //按门店来源查询
        $voucher_code = $request->input('source', 0);
        if ($voucher_code) {
            $obj->where('source', $voucher_code);
        }

        //按门店状态查询
        $state = $request->input('state', 0);
        if ($state) {
            $obj->where('state', $state);
        }

        //累计订单排序
        $all_order_num = $request->input('all_order_num', '');
        if ($all_order_num) {
            if ($all_order_num == 1) {
                $obj->orderBy('all_order_num');
            } else {
                $obj->orderBy('all_order_num', 'desc');
            }
        }

        //7日订单量排序
        $avg_order_num = $request->input('avg_order_num', '');
        if ($avg_order_num) {
            if ($avg_order_num == 1) {
                $obj->orderBy('avg_order_num');
            } else {
                $obj->orderBy('avg_order_num', 'desc');
            }
        }

        $list = $obj->orderBy('id', 'desc')->paginate((int) $request->input('per_page', $this->per_page));
        foreach ($list->items() as &$val) {
            $val['state'] = $val['state'] == 1 ? '正常' : '失效';
            $val['source'] = SoureCode::getMessage($val['source']);
            $val['mch_id'] = Merchant::where('id', $val['mch_id'])->value('mch_name');
        }

        return $this->success($list);
    }

    //删除门店池子
    public function delShop(RequestInterface $request)
    {
        $id = (int) $request->input('id', 0);
        $mark = $request->input('content', '');
        $shop = MerchantShop::query()->find($id);
        if ($shop) {
            if ($shop->state == AgentUserShopState::FAILURE) {
                return $this->fail('门店状态已失效');
            }
            Db::beginTransaction();
            $shop->state = AgentUserShopState::FAILURE;
            if ($shop->save()) {
                UserShop::where(['shop_id' => $id, 'mch_id' => $shop->mch_id ?? 0, 'state' => AgentUserShopState::NOTQUALIFIED])->update(['state' => AgentUserShopState::FAILURE]);
                $del = [
                    'type' => 2,
                    'oper_id' => auth()->user()->id ?? 0,
                    'oper_name' => auth()->user()->real_name ?? '',
                    'oper_phone' => auth()->user()->mobile ?? '',
                    'mch_name' => Merchant::where('id', $shop->mch_id)->value('mch_name'),
                    'shop_id' => $shop->id ?? 0,
                    'shop_name' => $shop->shop_name ?? '',
                    'content' => $mark,
                    'create_time' => date('Y-m-d H:i:s'),
                ];
                ShopDelLog::create($del);
                Db::commit();
                return $this->success();
            }
            Db::rollBack();
        }
        return $this->fail('删除失败');
    }

}
