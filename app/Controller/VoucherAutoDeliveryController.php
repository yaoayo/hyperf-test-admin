<?php

declare(strict_types=1);
/**
 * This file is part of Hyperf.
 *
 * @link     https://www.hyperf.io
 * @document https://hyperf.wiki
 * @contact  group@hyperf.io
 * @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
 */

namespace App\Controller;

use App\Model\Voucher;
use App\Model\AgDistVoucherRule;
use App\Model\AgDistVoucherTask;
use App\Constants\VoucherState;
use App\Constants\VoucherSrc;
use App\Constants\VoucherCat;
use App\Constants\DistVoucherCat;
use App\Constants\DistArrivalCat;
use Hyperf\DbConnection\Db;
use App\Exception\HttpRequestException;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\Validation\Contract\ValidatorFactoryInterface;

class VoucherAutoDeliveryController extends AbstractController
{
    protected  $validationFactory;

    public function __construct(ValidatorFactoryInterface $validationFactory)
    {
        $this->validationFactory = $validationFactory;
    }

   /**
   * [list 自动发放券任务规则列表]
   * @param  RequestInterface $request [description]
   * @return [type]                    [description]
   */
   public function list(RequestInterface $request){
               
        //开始时间查找
        $start_time = $request->input('start_time');
        //结束时间查找
        $end_time = $request->input('end_time');
        // 搜索
        $search = $request->input('search');

        $VoucherRule = AgDistVoucherRule::leftJoin('ag_user', 'ag_user.id', '=', 'ag_dist_voucher_rule.agent_id');
        if (!empty($search)) {
            $VoucherRule = $VoucherRule->where('ag_dist_voucher_rule.creator_name', 'like', '%' . $search . '%')
            ->orWhere('ag_user.agent_name', 'like', '%' . $search . '%')->orWhere('ag_user.phone', 'like', '%' . $search . '%');
        }

        // 时间范围查询
        if (!empty($start_time) && !empty($end_time) && strtotime($start_time) >= strtotime($end_time) ) {
            $VoucherRule = $VoucherRule->whereBetween('ag_dist_voucher_rule.create_time', [$start_time, $end_time]);
        }

        return $this->success($VoucherRule->selectRaw('ag_dist_voucher_rule.*,ag_user.phone as agent_phone,ag_user.agent_name')->orderBy('ag_dist_voucher_rule.create_time','desc')->paginate((int)$request->input('per_page',$this->per_page)));
   }

  /**
   * [create 创建自动发放任务规则]
   * @param  RequestInterface $request [description]
   * @return [type]                    [description]
   */
   public function create(RequestInterface $request){

        $validator = $this->validationFactory->make(
            $request->all(),
            [
                'agent_id' => 'required|numeric|gt:0',
                'remark' => 'present|string|max:100',
                'voucher_cat' => 'required|numeric|between:1,2',
                'dist_num' => 'required|numeric|gt:0',
                'dist_cat' => 'required|numeric|between:1,2',
                'dist_arrival_cat' => 'required|numeric|between:1,2',
                'dist_batch' => 'required_if:dist_cat,2|present|numeric|gt:0',
                'dist_interval' => 'required_if:dist_cat,2|present|numeric|gt:0',
                'activate_batch' => 'required_if:dist_cat,1|present|numeric|gt:0',
                'activate_interval' => 'required_if:dist_cat,1|present|numeric|gt:0',
            ]
        );

        if ($validator->fails()) {
            $errors = $validator->errors();
            throw new HttpRequestException($errors->first());
        }
        $post = $validator->getData();

        $my = auth()->user();
        $insert_field = [
            'agent_id'=>0,
            'remark'=>0,
            'voucher_cat'=>0,
            'dist_num'=>0,
            'dist_cat'=>0,
            'dist_arrival_cat'=>0,
            'dist_batch'=>0,
            'dist_interval'=>0,
            'activate_batch'=>0,
            'activate_interval'=>0,
            'create_time'=>date('Y-m-d H:i:s'),
            'creator_id'=>$my->id,
            'creator_name'=>$my->username
        ];
        $insert_data = array_merge($insert_field,$post);
        $voucher_task = [];

        $expect_run_date = ($post['dist_arrival_cat'] == DistArrivalCat::IMMEDIATELY ) ? date("Y-m-d H:i:s",strtotime('+5 minutes')) : date("Y-m-d 00:00:00",strtotime('+1 days'));

        // 一次发放
        if ($post['dist_cat'] == DistVoucherCat::ONCE && $post['activate_batch'] > 0 && $post['activate_interval'] > 0) {

            if ($post['dist_num'] < $post['activate_batch']) throw new HttpRequestException('发券数量必须大于激活批次');
            
            // 求余
            $m = $post['dist_num'] % $post['activate_batch'];
            // 每批次券发放数量
            $num = ($post['dist_num'] - $m) / $post['activate_batch'];
            // 可激活时间
            $activate_date = $expect_run_date;

            for ($i=1; $i <= $post['activate_batch']; $i++) {

                if($i > 1){
                    $activate_date = date("Y-m-d 00:00:00",strtotime("+{$post['activate_interval']} days",strtotime($activate_date)));
                }
                if($i == $post['activate_batch']) $num += $m; 
                

                $voucher_task[] = [
                    'rule_id'=>0,
                    'create_time'=>date('Y-m-d H:i:s'),
                    'agent_id'=>$post['agent_id'],
                    'dist_num'=>$num,
                    'activate_date_limit'=>$activate_date,
                    'expect_run_date'=>$expect_run_date,
                    'run_state'=>1
                ];
            }
        }

        // 多次发放
        if ($post['dist_cat'] == DistVoucherCat::MANY && $post['dist_interval'] > 0 && $post['dist_batch'] > 0) {

            if ($post['dist_num'] < $post['dist_batch']) throw new HttpRequestException('发券数量必须大于发券次数');

            // 求余
            $m = $post['dist_num'] % $post['dist_batch'];
            // 每批次券发放数量
            $num = ($post['dist_num'] - $m) / $post['dist_batch'];
            // 可激活时间
            $activate_date = $expect_run_date;

            for ($i=1; $i <= $post['dist_batch']; $i++) {

                if($i > 1){
                    $activate_date = date("Y-m-d 00:00:00",strtotime("+{$post['dist_interval']} days",strtotime($activate_date)));
                }
                if($i == $post['dist_batch']) $num += $m; 

                $voucher_task[] = [
                    'rule_id'=>0,
                    'create_time'=>date('Y-m-d H:i:s'),
                    'agent_id'=>$post['agent_id'],
                    'dist_num'=>$num,
                    'activate_date_limit'=>$activate_date,
                    'expect_run_date'=>$activate_date,
                    'run_state'=>1
                ];
            }
        }

        if (empty($voucher_task)) {
            throw new HttpRequestException('数据结构错误！');
        }

        Db::beginTransaction();
        try{

            $rule_id = AgDistVoucherRule::insertGetId($insert_data);
            foreach ($voucher_task as $key => $value) {
                $voucher_task[$key]['rule_id'] = $rule_id;
                $voucher_task[$key]['voucher_cat'] = $insert_data['voucher_cat'];
            }
            AgDistVoucherTask::insert($voucher_task);
            Db::commit();
            return $this->success();
        } catch(\Throwable $ex){
            Db::rollBack();
        }

        return $this->fail('操作失败！');
   }

}