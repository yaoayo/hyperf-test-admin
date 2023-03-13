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

use App\Constants\AgentBillStateCode;
use App\Constants\RemitStateCode;
use App\Model\AgBillRemitRecord;
use App\Model\AgUser;
use App\Model\AgUserBank;
use App\Model\AgUserBill;
use App\Model\PtConfig;
use App\Request\BillRequest;
use App\Service\ExcelService;
use App\Service\PayService;
use Hyperf\DbConnection\Db;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\HttpServer\Contract\ResponseInterface;
use Psr\Container\ContainerInterface;
use Psr\Http\Message\ResponseInterface as Psr7ResponseInterface;

class FinanceController extends AbstractController
{

    /**
     * 获取账单列表
     */
    function list(RequestInterface $request) {
        //获取参数
        $name = $request->input('name'); //搜索手机号名称

        $date = $request->input('date'); //搜索账期

        $state = $request->input('state'); //状态

        //检索条件
        $where = [];
        if ($date) {
            $where['bill_period'] = $date;
        }

        if ($state) {
            $where['state'] = $state;
        }

        //排序
        $order = isset($order) ? $order : 'asc';
        $query = AgUserBill::query()->where($where);
        if ($name) {
            $query = $query->whereRaw("((`agent_phone` like '%{$name}%') or (`agent_name` like '%{$name}%'))");
        }
        $list = $query->orderBy('total_income', $order)->paginate((int) $request->input('per_page', $this->per_page));
        //查询税率
        $Config = PtConfig::query()->where('name', 'Taxrate')->first();
        if ($Config) {
            $config = json_decode($Config['contens'], true);
        }
        foreach ($list as &$item) {
            $item['state_name'] = AgentBillStateCode::getMessage($item['state']);
            $agent = AgUser::query()->where(['id' => $item['agent_id'], 'state' => 1])->first();
            $item['agent_state'] = empty($agent) ? 2 : 1;
            if ($item['tax_rate'] <= 0) {
                $item['tax_rate'] = empty($config) ? '6' : $config['taxRateValue'];
                $item['real_income'] = bcsub((string) $item['total_income'], bcdiv(bcmul((string) $item['tax_rate'], (string) $item['total_income'], 2), '100', 2), 2);
            }
            $item['bank_front_img'] = '';
            $item['bank_back_img'] = '';
            $item['id_card_front_img'] = '';
            $item['id_card_back_img'] = '';
            if (!empty($item['receiver_bank_no'])) {
                $bank = AgUserBank::query()->where('agent_id', $item['agent_id'])->first();
                if ($bank) {
                    $item['bank_front_img'] = $bank['bank_front_img'];
                    $item['bank_back_img'] = $bank['bank_back_img'];
                    $item['id_card_front_img'] = $bank['id_card_front_img'];
                    $item['id_card_back_img'] = $bank['id_card_back_img'];
                }
            }

        }
        $list = $list->toArray();
        $list['total__amount'] = AgUserBill::query()->where($where)->sum('total_income');
        if ($name) {
            $list['total__amount'] = AgUserBill::query()->where($where)->whereRaw("((`agent_phone` like '%{$name}%') or (`agent_name` like '%{$name}%'))")->sum('total_income');
        }

        return $this->success($list);
    }
    /**
     * 财务加载
     *
     */
    public function load()
    {

        $list = [
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_WCZ,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_WCZ),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_DFS,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_DFS),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_DQR,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_DQR),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_DDK,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_DDK),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_DKZ,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_DKZ),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_YDK,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_YDK),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_BH,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_BH),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_SFBH,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_SFBH),
            ],
            [
                'id' => AgentBillStateCode::AGENT_BILL_STATE_YZF,
                'name' => AgentBillStateCode::getMessage(AgentBillStateCode::AGENT_BILL_STATE_YZF),
            ],

        ];
        return $this->success($list);
    }
    /**
     * 查询第三方余额
     *
     */
    public function balance()
    {
        $Pay = new PayService('getBalance');
        $res = $Pay->pay(['uid' => $Pay->uuid]);
        return $this->success($res);
    }
    /**
     * 导出
     *
     */
    public function download(RequestInterface $request, ResponseInterface $response): Psr7ResponseInterface
    {
        //获取参数
        $name = $request->input('name'); //搜索手机号名称

        $date = $request->input('date'); //搜索账期

        $state = $request->input('state'); //状态

        //检索条件
        $where = [];
        if ($date) {
            $where['bill_period'] = $date;
        }

        if ($state) {
            $where['state'] = $state;
        }

        //排序
        $order = 'asc';

        $list = AgUserBill::query()->where($where)->orderBy('total_income', $order)->get();
        if ($name) {
            $list = AgUserBill::query()->where($where)->whereRaw("((`agent_phone` like '%{$name}%') or (`agent_name` like '%{$name}%'))")->orderBy('total_income', $order)->get();
        }
        foreach ($list as &$item) {
            $item['state'] = AgentBillStateCode::getMessage($item['state']);
        }
        if (empty($list)) {
            return $this->fail('无数据导出');
        }
        $list = $list->toArray();
        $title = ['账号', '姓名', '身份证', '卡号', '银行名称', '开户行', '预留电话', '金额'];
        $key = ['agent_phone', 'agent_name', 'receiver_idcard', 'receiver_bank_no', 'receiver_bank', 'sub_bank', 'receiver_phone', 'real_income'];

        $excel = new ExcelService();
        $data = $excel->download(date('Ymd'), $list, $key, $title);

        return $response->download(BASE_PATH . '/runtime/excel/' . $data['filename'], $data['filename']);

    }

    /**
     * 发送账单
     *
     */
    public function dispatch(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();
        //检索条件
        $arr = AgUserBill::query()->whereIn('id', $post['id'])->get();

        //查询税率
        $Config = PtConfig::query()->where('name', 'Taxrate')->first();
        if ($Config) {
            $config = json_decode($Config['contens'], true);
        }

        foreach ($arr as $item) {
            if ($item['state'] != AgentBillStateCode::AGENT_BILL_STATE_DFS) {
                continue;
            }
            $AgUserBill = AgUserBill::query()->where('id', $item['id'])->first();
            $AgUserBill->state = AgentBillStateCode::AGENT_BILL_STATE_DQR;
            $AgUserBill->tax_rate = empty($config) ? 6 : $config['taxRateValue'];
            $AgUserBill->real_income = bcsub((string) $AgUserBill->total_income, bcdiv(bcmul((string) $AgUserBill->tax_rate, (string) $AgUserBill->total_income, 2), '100', 2), 2);
            $AgUserBill->save();
        }
        return $this->success();
    }
    /**
     * 驳回
     *
     */
    public function reject(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('mod')->validateResolved();
        $post = $request->all();

        $arr = AgUserBill::query()->where(['id' => $post['id']])->whereIn('state', [AgentBillStateCode::AGENT_BILL_STATE_DDK, AgentBillStateCode::AGENT_BILL_STATE_SFBH])->first();

        if (!$arr) {
            return $this->fail('请选择待打款账单!');
        }

        $arr->state = AgentBillStateCode::AGENT_BILL_STATE_BH;
        $arr->remarks = $post['remarks'];
        $arr->save();
        return $this->success();

    }
    /**
     * 手动打款
     */
    public function hand(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('add')->validateResolved();
        $post = $request->all();
        $id = '';
        // $total_income = 0;
        foreach ($post['data'] as &$item) {
            if (empty($item['bill_id'])) {
                return $this->fail('数据错误！');
            }
            if (empty($item['remit_no'])) {
                return $this->fail('数据错误！');
            }
            if (empty($item['remit_amount'])) {
                return $this->fail('数据错误！');
            }

            if (empty($item['receive_bank'])) {
                return $this->fail('数据错误！');
            }

            if (empty($item['receive_bank_no'])) {
                return $this->fail('数据错误！');
            }

            if (empty($item['receive_user'])) {
                return $this->fail('数据错误！');
            }

            $item['remit_state'] = RemitStateCode::REMIT_STATE_DKCG;
            $item['remit_method'] = 2;
            $item['create_time'] = empty($item['create_time']) ? date('Y-m-d H:i:s') : $item['create_time'];
            $id = $item['bill_id'];
            // $total_income = bcadd((string) $total_income, (string) $item['remit_amount'], 2);
            unset($item['key']);
        }
        //查询账单
        $AgUserBill = AgUserBill::query()->where('id', $id)->first();
        if (empty($AgUserBill)) {
            return $this->fail('账单不存在！');
        }
        // if ($total_income > $AgUserBill['real_income']) {
        //     return $this->fail('打款金额错误！');
        // }
        //查询代理商
        $AgUser = AgUser::query()->where('id', $AgUserBill['agent_id'])->first();
        if (empty($AgUser)) {
            return $this->fail('代理商不存在！');
        }
        Db::beginTransaction();
        try {
            $AgUser->settle_income = bcadd((string) $AgUser->settle_income, (string) $AgUserBill->total_income, 2);
            $AgUser->save();
            AgUserBill::query()->where('id', $id)->update(['state' => AgentBillStateCode::AGENT_BILL_STATE_YDK]);
            AgBillRemitRecord::insert($post['data']);
            Db::commit();
            return $this->success();
        } catch (\Throwable $ex) {
            Db::rollBack();
            return $this->fail('操作失败！');
        }
    }
    /**
     * 打款记录
     */
    public function notes(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();
        $arr = AgBillRemitRecord::query()->where('bill_id', $post['id'])->orderBy('id', 'desc')->get();
        foreach ($arr as &$item) {
            $item['remit_state'] = RemitStateCode::getMessage($item['remit_state']);
        }
        return $this->success($arr);
    }

    /**
     * 线上打款
     *
     */
    public function online(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();
        //检索条件
        $where = [];
        $where[] = ['state', '=', AgentBillStateCode::AGENT_BILL_STATE_DDK];
        $arr = AgUserBill::query()->where($where)->whereIn('id', $post['id'])->get();
        if (!$arr) {
            return $this->fail('数据不存在！');
        }
        $pay = new PayService('submitGrantDetail');
        //打款数据
        $array = [
            'uid' => $pay->uuid,
            'notify_url' => env('URL_NOTIFY') . '/admin/notify',
            'distributionlist' => [],
        ];

        foreach ($arr as $item) {
            $array['distributionlist'] = [];
            if ($item['real_income'] < 0) {
                continue;
            }
            //查询代理商
            $AgUser = AgUser::query()->where(['id' => $item['agent_id'], 'state' => 1])->first();
            if (!$AgUser) {
                // AgUserBill::query()->where('id', $item['id'])->update(['remarks' => '代理商账号被禁用或删除', 'state' => AgentBillStateCode::AGENT_BILL_STATE_BH]);
                continue;
            }
            if ($item['state'] != AgentBillStateCode::AGENT_BILL_STATE_DDK) {
                continue;
            }

            $order_no = 'JHB' . time() . mt_rand(100, 999);
            $array['distributionlist'][] = [
                'natchno' => $order_no,
                'outerInstNatchno' => $order_no,
                'idtypename' => 1,
                'idcard' => $item['receiver_idcard'],
                'mobile' => $item['receiver_phone'],
                'ccyCode' => 'OTHERBANK',
                'tranAmount' => $item['real_income'],
                'inBankName' => $item[''],
                'inAcctNo' => $item['receiver_bank_no'],
                'inAcctName' => $item['receiver_user'],
                'cardType' => 'DC',
                'cardAttribute' => 'C',
            ];
            $arr = [
                'bill_id' => $item['id'],
                'remit_method' => 2,
                'remit_no' => $order_no,
                'remit_state' => RemitStateCode::REMIT_STATE_DKZ,
                'remit_amount' => $item['real_income'],
                'receive_user' => $item['receiver_user'],
                'receive_idcard' => $item['receiver_idcard'],
                'receive_phone' => $item['receiver_phone'],
                'receive_bank' => $item['receiver_bank'],
                'receive_bank_no' => $item['receiver_bank_no'],
                'create_time' => date('Y-m-d H:i:s'),
            ];
            //查询订单
            $AgUserBill = AgUserBill::query()->where('id', $item['id'])->first();
            $data = $pay->pay($array);
            if ($data['message'] !== 'SUCCESS') {
                $arr['fail_msg'] = $data['message'];
                $arr['remit_state'] = RemitStateCode::REMIT_STATE_DKSB;
                $AgUserBill->remarks = $data['message'];
                $AgUserBill->state = AgentBillStateCode::AGENT_BILL_STATE_SFBH;
            } else {
                $AgUserBill->state = AgentBillStateCode::AGENT_BILL_STATE_DKZ;
            }

            Db::beginTransaction();
            try {
                //修改数据
                $AgUserBill->save();
                AgBillRemitRecord::insert($arr);
                Db::commit();
            } catch (\Throwable $ex) {
                Db::rollBack();
            }

        }
        return $this->success();
    }
    /**
     * 重新打款
     *
     */
    public function again(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();

        //检索条件
        $where = [];
        $where[] = ['id', '=', $post['id']];
        $item = AgUserBill::query()->where($where)->first();
        if (!$item) {
            return $this->fail('数据不存在');
        }
        $pay = new PayService('submitGrantDetail');
        //打款数据
        $array = [
            'uid' => $pay->uuid,
            'notify_url' => env('URL_NOTIFY') . '/admin/notify',
            'distributionlist' => [],
        ];
        if ($item['real_income'] < 0) {
            return $this->fail('打款金额错误！');
        }
        //查询代理商
        $AgUser = AgUser::query()->where(['id' => $item['agent_id'], 'state' => 1])->first();
        if (!$AgUser) {
            return $this->fail('代理商账号被禁用或删除');
        }
        if ($item['state'] != AgentBillStateCode::AGENT_BILL_STATE_SFBH) {
            return $this->fail('数据不能操作！');
        }

        $order_no = 'JHB' . time() . mt_rand(100, 999);
        $array['distributionlist'][] = [
            'natchno' => $order_no,
            'outerInstNatchno' => $order_no,
            'idtypename' => 1,
            'idcard' => $item['receiver_idcard'],
            'mobile' => $item['receiver_phone'],
            'ccyCode' => 'OTHERBANK',
            'tranAmount' => $item['real_income'],
            'inBankName' => $item['receiver_user'],
            'inAcctNo' => $item['receiver_bank_no'],
            'inAcctName' => $item['receiver_user'],
            'cardType' => 'DC',
            'cardAttribute' => 'C',
        ];
        $arr = [
            'bill_id' => $item['id'],
            'remit_method' => 2,
            'remit_no' => $order_no,
            'remit_state' => RemitStateCode::REMIT_STATE_DKZ,
            'remit_amount' => $item['real_income'],
            'receive_user' => $item['receiver_user'],
            'receive_idcard' => $item['receiver_idcard'],
            'receive_phone' => $item['receiver_phone'],
            'receive_bank' => $item['receiver_bank'],
            'receive_bank_no' => $item['receiver_bank_no'],
            'create_time' => date('Y-m-d H:i:s'),
        ];
        //查询订单
        $AgUserBill = AgUserBill::query()->where('id', $item['id'])->first();
        $data = $pay->pay($array);
        if ($data['message'] !== 'SUCCESS') {
            $arr['fail_msg'] = $data['message'];
            $arr['remit_state'] = RemitStateCode::REMIT_STATE_DKSB;
            $AgUserBill->remarks = $data['message'];
            $AgUserBill->state = AgentBillStateCode::AGENT_BILL_STATE_SFBH;
        } else {
            $AgUserBill->state = AgentBillStateCode::AGENT_BILL_STATE_DKZ;
        }

        Db::beginTransaction();
        try {
            //修改数据
            $AgUserBill->save();
            AgBillRemitRecord::insert($arr);
            Db::commit();
        } catch (\Throwable $ex) {
            Db::rollBack();
        }
        return $this->success();
    }
    /**
     * 作废
     *
     */

    public function cancel(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();

        //检索条件
        $where = [];
        $where[] = ['id', '=', $post['id']];
        $item = AgUserBill::query()->where($where)->first();
        if (!$item) {
            return $this->fail('数据不存在');
        }
        if ($item['state'] != AgentBillStateCode::AGENT_BILL_STATE_DFS) {
            return $this->fail('数据不能操作！');
        }
        $item->state = AgentBillStateCode::AGENT_BILL_STATE_YZF;
        $item->save();
        return $this->success();
    }
    /**
     * 恢复
     *
     */

    public function resume(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(BillRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();

        //检索条件
        $where = [];
        $where[] = ['id', '=', $post['id']];
        $item = AgUserBill::query()->where($where)->first();
        if (!$item) {
            return $this->fail('数据不存在');
        }
        if ($item['state'] != AgentBillStateCode::AGENT_BILL_STATE_YZF) {
            return $this->fail('数据不能操作！');
        }
        $item->state = AgentBillStateCode::AGENT_BILL_STATE_DFS;
        $item->save();
        return $this->success();
    }

    /**
     *第三方支付回调
     *
     */
    public function notify(RequestInterface $request)
    {
        $jsonxml = $request->all();
        $data = [];
        if (isset($jsonxml['requestBody'])) {
            $data = json_decode(decrypt($jsonxml['requestBody']), true);
        }
        $myfile = fopen("pay.txt", "a");
        fwrite($myfile, "\n");
        fwrite($myfile, json_encode($data));
        if ($data) {
            //查询打款记录
            $AgBillRemitRecord = AgBillRemitRecord::query()->where(['remit_no' => $data['outer_trade_no']])->first();
            if (!$AgBillRemitRecord) {
                return 'success';
            }
            //查询账单
            $AgUserBill = AgUserBill::query()->where(['id' => $AgBillRemitRecord['bill_id']])->first();
            //查询代理商
            $AgUser = AgUser::query()->where('id', $AgUserBill['agent_id'])->first();

            if ($data['send_status'] == 11 && $data['withdrawal_status'] == 'TRADE_FINISHED') {
                Db::beginTransaction();
                try {
                    $AgBillRemitRecord->remit_state = RemitStateCode::REMIT_STATE_DKCG;
                    $AgBillRemitRecord->create_time = $data['gmt_close'];
                    $AgBillRemitRecord->fail_msg = $data['send_msg'];
                    $AgBillRemitRecord->save();
                    $AgUserBill->state = AgentBillStateCode::AGENT_BILL_STATE_YDK;
                    $AgUserBill->remarks = $data['send_msg'];
                    $AgUserBill->save();
                    $AgUser->settle_income = bcadd($AgUser->settle_income, $AgUserBill->total_income, 2);
                    $AgUser->save();
                    Db::commit();
                    return 'success';
                } catch (\Throwable $ex) {
                    Db::rollBack();
                    return 'false';
                }
            } else {
                Db::beginTransaction();
                try {
                    $AgBillRemitRecord->remit_state = RemitStateCode::REMIT_STATE_DKSB;
                    $AgBillRemitRecord->create_time = $data['gmt_close'];
                    $AgBillRemitRecord->fail_msg = $data['send_msg'] . '-' . $data['error_msg'];
                    $AgBillRemitRecord->save();
                    $AgUserBill->state = AgentBillStateCode::AGENT_BILL_STATE_SFBH;
                    $AgUserBill->remarks = $data['send_msg'] . '-' . $data['error_msg'];
                    $AgUserBill->save();
                    Db::commit();
                    return 'success';
                } catch (\Throwable $ex) {
                    Db::rollBack();
                    return 'false';

                }
            }
        }
        return 'success';
    }

}
