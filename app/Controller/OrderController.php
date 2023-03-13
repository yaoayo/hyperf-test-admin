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

use App\Constants\AgentCode;
use App\Constants\AgentShopBindType;
use App\Constants\AgentUserShopState;
use App\Constants\LogisticsCode;
use App\Constants\VoucherCat;
use App\Model\AgUserIncome;
use App\Model\MerchantShop;
use App\Model\Order;
use Hyperf\DbConnection\Db;
use Hyperf\HttpServer\Contract\RequestInterface;

class OrderController extends AbstractController
{
    /**
     * 获取订单列表
     */
    function list(RequestInterface $request) {
        $date = date('Ym');

        //时间 只能查当月和上一个月
        $start_time = $request->input('start_time', '');
        $end_time = $request->input('end_time', '');
        if ($start_time || $end_time) {
            if ($end_time < $start_time) {
                return $this->fail('开始时间不能小于结束时间');
            }
            if (date('m', strtotime($start_time)) < date('m', strtotime('-1 month'))) {
                return $this->fail('只能查当月和上月');
            }

            if (date('m', strtotime($start_time)) != date('m', strtotime($end_time))) {
                return $this->fail('查询不能跨月');
            }
            $date = date('Ym', strtotime($start_time ?: $end_time));
        }
        $obj =  (new Order($date))->query();

        //根据代理商名称查询
        $name = $request->input('name', '');
        if ($name) {
            $obj->where('agent_name', 'like', '%'.$name.'%')
            ->orWhere('agent_phone', 'like', '%'.$name.'%');
        }
        //按订单时间查询
        $start_time = $request->input('start_time', '');
        $end_time = $request->input('end_time', '');
        if ($start_time) {
            $obj->where('order_time', '>=', $start_time);
        }
        if ($end_time) {
            $obj->where('order_time', '<=', $end_time);
        }
        $obj_static = clone $obj;
        $static = $obj_static->select([Db::raw("count(1) as total"), Db::raw('sum(agent_subsidy) as agent_subsidy'),
            Db::raw('sum(agent_income) as agent_income')])->first();

        $list = $obj->orderBy('order_time', 'desc')->paginate((int)$request->input('per_page',$this->per_page));
        $agent_income = new AgUserIncome($date);
        foreach ($list->items() as &$val) {
            $val['order_plat'] = AgentCode::getMessage($val['order_plat']);
            $val['logistics_plat'] = LogisticsCode::getMessage($val['logistics_plat']);
            $val['income_amount'] = $val['agent_income'];
        }
        if ($list) {
            $list = $list->toArray();
            $list['static_total'] = $static;
        }
        return $this->success($list);
    }



}
