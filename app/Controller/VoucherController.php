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
use App\Model\VoucherLog;
use App\Model\AgUser;
use App\Model\UserShop;
use App\Model\VoucherGiftRecord;
use App\Model\VoucherInvate;
use Hyperf\DbConnection\Db;
use App\Constants\VoucherState;
use App\Constants\VoucherSrc;
use App\Constants\VoucherCat;
use App\Service\CacheConfigService;
use App\Constants\AgentUserShopState;
use App\Exception\HttpRequestException;
use Hyperf\HttpServer\Contract\RequestInterface;

class VoucherController extends AbstractController
{
    /**
     * [grant 增券]
     * @return [type] [description]
     */
    public function grant(RequestInterface $request){

        $remark = $request->input('remark');
        // 用户ID
        $user_id = $request->input('user_id',0);

        // 自推,代推
        $cat = $request->input('cat',['1'=>0,'2'=>0]);

        if (empty(array_filter($cat))) {
            throw new HttpRequestException('发法数量不能为空');
        }

        $AgUser = AgUser::where('id',$user_id)->select('id', 'agent_name','phone')->first();

        if (empty($AgUser)) throw new HttpRequestException('非法操作！');
        
        $voucher_data = [];
        $voucher_logs = [];
        $my = auth()->user();

        // 获取配置
        $validity = CacheConfigService::getKey('validity','Ground') ?? 0;

        foreach ($cat as $type => $num) {

            if($num ==  0) continue;

            $type_message =  VoucherCat::getMessage($type) ?? '未知';
 
            // 券日志
            $voucher_logs[] = [
                'agent_id'=> $user_id,
                'agent_name'=> $AgUser->agent_name . ' ' . $AgUser->phone,
                'oper_cat'=>1,
                'oper_id'=>$my->id,
                'oper_name'=>$my->username,
                'create_time'=> date('Y-m-d H:i:s'),
                'remark'=>$remark,
                'content'=> '发放'.$type_message.$num.'张'
            ];
            // 券数据
            $data = [ 
                'source'=> VoucherSrc::SOURCE_SYSTEM,
                'cat'=> $type,
                'ag_user_id'=> $user_id,
                'voucher_code'=>uniqid(),
                'state'=> VoucherState::STATE_UNACTIVSTED,
                'valid_date'=> date('Y-m-d',strtotime("+{$validity} days")),
                'create_time'=> date('Y-m-d H:i:s')
            ];

            for ($i=0; $i < $num; $i++) {
                $voucher_data[] = array_merge($data,['voucher_code'=>uniqid()]);
            }
        }

        Db::beginTransaction();

        try{

            VoucherLog::insert($voucher_logs);
            Voucher::insert($voucher_data);
            Db::commit();
            return $this->success();
        } catch(\Throwable $ex){
            Db::rollBack();
        }

        return $this->fail('操作失败！');
    }

    /**
     * [deduct 减券]
     * @return [type] [description]
     */
    public function deduct(RequestInterface $request){

        $remark = $request->input('remark');
        // 用户ID
        $user_id = $request->input('user_id',0);

        if (empty(array_filter($request->input('state')))) {
            throw new HttpRequestException('减券数量不能为空');
        }

        $state = array_filter($request->input('state'));

        $AgUser = AgUser::where('id',$user_id)->select('id', 'agent_name','phone')->first();

        if (empty($AgUser)) throw new HttpRequestException('非法操作！');

        // 查询用户券
        $Voucher = Voucher::select(['state',Db::raw('count(`state`) as num,GROUP_CONCAT(`id`) as ids')])
        ->where('ag_user_id',$user_id)
        ->whereNotIn('state', [
            VoucherState::STATE_COMPLTET_ALLOCATION,
            VoucherState::STATE_COMPLTET_INVITE
        ])
        ->orderBy('state')
        ->groupBy('state');

        // 判断券是否存在券
        $state_num = $Voucher->pluck('num','state')->toArray();
        if (empty($state_num)) {
            throw new HttpRequestException('该用户券不满足扣除条件！');
        }

        // 判断券是否满足扣除条件
        foreach ($state_num as $key => $num) {

            if (!array_key_exists($key, $state)) continue;

            if ($state[$key] > 50) {
                throw new HttpRequestException('单个扣除不能超过50张');
            }

            if ($num < $state[$key]) {
                $state_message = VoucherState::getMessage($key) ?? '未知';
                throw new HttpRequestException($state_message.'券不满足扣除条件！');
                break;
            }
        }

        // 获取对应券的ID
        $ids = $Voucher->pluck('ids','state')->toArray();
        $voucher_logs = [];
        $delete_ids = [];
        $my = auth()->user();

        foreach ($state as $key => $num) {
            // 获取对应状态已有的券
            $chunk_ids = array_chunk(explode(',', $ids[$key]), $num);

            // 券扣除日志
            $state_message = VoucherState::getMessage($key) ?? '未知';
            $voucher_logs[] = [
                'agent_id'=> $user_id,
                'agent_name'=> $AgUser->agent_name .' ' . $AgUser->phone,
                'oper_cat'=>1,
                'oper_id'=>$my->id,
                'oper_name'=>$my->username,
                'create_time'=> date('Y-m-d H:i:s'),
                'remark'=>$remark,
                'content'=> '减少'.$state_message.$num.'张;券ID为('.implode(',',$chunk_ids[0]).')'
            ];
            // 券扣除数据
            array_walk_recursive($chunk_ids[0], function($value) use (&$delete_ids) {
                array_push($delete_ids, $value);
            });
        }

        Db::beginTransaction();
        try{
            // 记录日志
            VoucherLog::insert($voucher_logs);
            // 删除券
            Voucher::where('ag_user_id',$user_id)->whereIn('id',$delete_ids)->delete();
            Db::commit();
            return $this->success();
        } catch(\Throwable $ex){
            Db::rollBack();
        }

        return $this->fail('操作失败！');
    }

    /**
     * [list 券列表]
     * @return [type] [description]
     */
    public function list(RequestInterface $request)
    {
        $state = $request->input('state');//券的状态
        $cat = $request->input('cat');//券的类型
        $source = $request->input('source');//券的来源
        $search = $request->input('search');//代理商名称 
        $ag_user_id = $request->input('ag_user_id',0);//代理商ID


        $activated_start_time = $request->input('start_time');//激活开始时间查找
        $activated_end_time = $request->input('end_time');//激活结束时间查找

        if (!empty($activated_start_time) && !empty($activated_end_time) ) {
            if (strtotime($activated_start_time) >= strtotime($activated_end_time)) {
                throw new HttpRequestException('开始时间不能大于结束时间！');
            }
        }

        //激活时间排序 
        $order_by = [];
        foreach ($request->input('order_by',[]) as $value) {
            if (!empty($value['field']) && !empty($value['value'])) {
                $order_by[] = "ag_user_voucher.{$value['field']} {$value['value']} ";
            }
        }

        $where = [];
        foreach (array_filter(array_intersect_key($request->all(),['cat'=>0,'source'=>0,'state'=>0,'ag_user_id'=>0])) as $key => $value) {
            $where['ag_user_voucher.'.$key] = $value;
        }

        // 条件查询
        $Voucher = Voucher::where($where);

        // 激活时间范围查询
        if (!empty($activated_start_time) && !empty($activated_end_time) ) {
            $Voucher = $Voucher->whereBetween('ag_user_voucher.activated_time', [$activated_start_time, $activated_end_time]);
        }

        // 排序
        if (!empty($order_by)) {
            $Voucher = $Voucher->orderByRaw(implode(',', $order_by));
        }

        // 关联代理商
        $Voucher->join('ag_user', function ($join) {
            $join->on('ag_user.id', '=', 'ag_user_voucher.ag_user_id');
        });

        // 搜索代理商
        if (!empty($search)) {
            $Voucher = $Voucher->whereRaw("((ag_user.agent_name like '%{$search}%') or (ag_user.phone like '%{$search}%'))");
        }
        return $this->success($Voucher->select('ag_user_voucher.*','ag_user.agent_name','ag_user.phone')->paginate((int)$request->input('per_page',$this->per_page)));
    }

    /**
     * [giveList 赠送记录列表]
     * @return [type] [description]
     */
    public function giveList(RequestInterface $request)
    {
        // 赠送人
        $to_agent_id = $request->input('to_agent_id');

        // 被赠人
        $from_agent_id = $request->input('from_agent_id');

        //开始时间查找
        $start_time = $request->input('start_time');

        //结束时间查找
        $end_time = $request->input('end_time');

        if (!empty($start_time) && !empty($end_time) ) {
            if (strtotime($start_time) >= strtotime($end_time)) {
                throw new HttpRequestException('开始时间不能大于结束时间！');
            }
        }

        $where = [];
        if (!empty($to_agent_id)) {
            $where['to_agent_id']=$to_agent_id;
        }

        if (!empty($from_agent_id)) {
            $where['from_agent_id']=$from_agent_id;
        }

        $GiftRecord = VoucherGiftRecord::where($where);

        // 时间范围查询
        if (!empty($start_time) && !empty($end_time) ) {
            $GiftRecord = $GiftRecord->whereBetween('create_time', [$start_time, $end_time]);
        }

        return $this->success($GiftRecord->orderBy('create_time','desc')->paginate((int)$request->input('per_page',$this->per_page)));
    }

    /**
     * [invate 邀请记录]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function invate(RequestInterface $request){
        $agent_id = $request->input('agent_id',0);

        //开始时间查找
        $start_time = $request->input('start_time');
        //结束时间查找
        $end_time = $request->input('end_time');
        $where = [];
        if (!empty($start_time) && !empty($end_time) ) {
            if (strtotime($start_time) >= strtotime($end_time)) {
                throw new HttpRequestException('开始时间不能大于结束时间！');
            }
        }

        if(!empty($agent_id)){
            $where['agent_id'] = $agent_id;
        }

        $VoucherInvate = VoucherInvate::where($where);
        // 时间范围查询
        if (!empty($start_time) && !empty($end_time) ) {
            $VoucherInvate = $VoucherInvate->whereBetween('create_time', [$start_time, $end_time]);
        }
        return $this->success($VoucherInvate->with(['agent','merchant'])->orderBy('create_time','desc')->paginate((int)$request->input('per_page',$this->per_page)));
    }
    /**
     * [invateInfo 邀请详情]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function invateInfo(RequestInterface $request){
        $agent_id = $request->input('agent_id',0);
        return $this->success(VoucherInvate::where('agent_id',$agent_id)->with(['agent','merchant'])->first());
    }

    /**
     * [count 券统计]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function count(RequestInterface $request){
        $user_id = $request->input('user_id',0);

        $Voucher = Voucher::select(['state',Db::raw('count(`state`) as num')])
                            ->where('ag_user_id',$user_id)
                            ->orderBy('state')
                            ->groupBy('state')
                            ->get();

        return $this->success($Voucher);
    }

    /**
     * [voucherLog 券增减日志列表]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function voucherLog(RequestInterface $request){
        
        //开始时间查找
        $start_time = $request->input('start_time');
        //结束时间查找
        $end_time = $request->input('end_time');
        // 搜索
        $search = $request->input('search');
        $where = [];
        if (!empty($start_time) && !empty($end_time) ) {
            if (strtotime($start_time) >= strtotime($end_time)) {
                throw new HttpRequestException('开始时间不能大于结束时间！');
            }
        }
        $VoucherLog = VoucherLog::where($where);
        if (!empty($search)) {
            $VoucherLog = $VoucherLog->whereRaw("((oper_name like '%{$search}%') or (agent_name like '%{$search}%'))");
        }

        // 时间范围查询
        if (!empty($start_time) && !empty($end_time) ) {
            $VoucherLog = $VoucherLog->whereBetween('create_time', [$start_time, $end_time]);
        }

        return $this->success($VoucherLog->orderBy('create_time','desc')->paginate((int)$request->input('per_page',$this->per_page)));
    }
    /**
     * [voucherSwitch 券切换]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function voucherSwitch(RequestInterface $request){

        $id = $request->input('id');
        $Voucher = Voucher::where('id',$id)->whereIn('state',[VoucherState::STATE_UNACTIVSTED,VoucherState::STATE_INVITE,VoucherState::STATE_ALLOCATION])->first();
        if (empty($Voucher)) throw new HttpRequestException('未找到或不满足切换条件!');
        
        $AgUser = AgUser::where('id',$Voucher->ag_user_id)->select('id', 'agent_name')->first();
        if (empty($AgUser)) throw new HttpRequestException('未找到该券的代理商信息!');

        $cat = ($Voucher->cat == VoucherCat::INVITE) ? VoucherCat::SYSTEM : VoucherCat::INVITE;
        $content = "ID:{$id} 券类型由".VoucherCat::getMessage($Voucher->cat).'切换为 '.VoucherCat::getMessage($cat);

        $state = VoucherState::STATE_UNACTIVSTED;
        switch ($Voucher->state) {
            case VoucherState::STATE_INVITE:
                $state = VoucherState::STATE_ALLOCATION;
                $content.= " 券状态由".VoucherState::getMessage($Voucher->state).'切换为 '.VoucherState::getMessage($state);
                break;
            case VoucherState::STATE_ALLOCATION:
                $state = VoucherState::STATE_INVITE;
                $content.= " 券状态由".VoucherState::getMessage($Voucher->state).'切换为 '.VoucherState::getMessage($state);
                break;
        }

        $my = auth()->user();
        $voucher_logs[] = [
            'agent_id'=> $AgUser->id,
            'agent_name'=> $AgUser->agent_name,
            'oper_cat'=>1,
            'oper_id'=>$my->id,
            'oper_name'=>$my->username,
            'create_time'=> date('Y-m-d H:i:s'),
            'content'=> $content,
        ];

        Db::beginTransaction();

        try{
            $Voucher->cat = $cat;
            $Voucher->state = $state;
            if ($Voucher->save() && VoucherLog::insert($voucher_logs)) {
                Db::commit();
                return $this->success();
            }
            Db::rollBack();
        } catch(\Throwable $ex){
            Db::rollBack();
        }

        return $this->fail('操作失败！');
    }


    
    /**
     * [voucherShopCount 券状态、店铺券绑定状态统计]
     * @param  RequestInterface $request [description]
     * @return [type]                    [description]
     */
    public function voucherShopCount(RequestInterface $request){

        $user_id = $request->input('agent_id',0);
        $operator = '=';
        if (empty($user_id)) $operator = '>';
        
        // 券状态
        $state = Voucher::select(['state',Db::raw('count(`state`) as num')])
                            ->where('ag_user_id',$operator,$user_id)
                            ->orderBy('state')
                            ->groupBy('state')
                            ->pluck('num','state')->toArray();
        // 券类型
        $cat = Voucher::select(['cat',Db::raw('count(`cat`) as num')])
                            ->where('ag_user_id',$operator,$user_id)
                            ->where('state',VoucherState::STATE_UNACTIVSTED)
                            ->orderBy('cat')
                            ->groupBy('cat')
                            ->pluck('num','cat')->toArray();
        // 店铺和券绑定关系状态
        $shop = UserShop::select(['state',Db::raw('count(`state`) as num')])
                            ->where('agent_id',$operator,$user_id)
                            ->orderBy('state')
                            ->groupBy('state')
                            ->pluck('num','state')->toArray();

        $shop_total = UserShop::where('agent_id',$operator,$user_id)->count();
        $voucher_total = Voucher::where('ag_user_id',$operator,$user_id)->count();
        $data = [
            'state'=>[
                [
                    'state'=>0,
                    'name'=>'全部',
                    'num'=>$voucher_total,
                ],
                [
                    'state'=>VoucherState::STATE_UNACTIVSTED,
                    'name'=>VoucherState::getMessage(VoucherState::STATE_UNACTIVSTED),
                    'num'=>0,
                ],
                [
                    'state'=>VoucherState::STATE_INVITE,
                    'name'=>VoucherState::getMessage(VoucherState::STATE_INVITE),
                    'num'=>0,
                ],
                [
                    'state'=>VoucherState::STATE_ALLOCATION,
                    'name'=>VoucherState::getMessage(VoucherState::STATE_ALLOCATION),
                    'num'=>0,
                ],
                [
                    'state'=>VoucherState::STATE_COMPLTET_ALLOCATION,
                    'name'=>VoucherState::getMessage(VoucherState::STATE_COMPLTET_ALLOCATION),
                    'num'=>0,
                ],
                [
                    'state'=>VoucherState::STATE_COMPLTET_INVITE,
                    'name'=>VoucherState::getMessage(VoucherState::STATE_COMPLTET_INVITE),
                    'num'=>0,
                ],
                [
                    'state'=>VoucherState::STATE_EXPIRE,
                    'name'=>VoucherState::getMessage(VoucherState::STATE_EXPIRE),
                    'num'=>0,
                ],
            ],
            'cat'=>[
                [
                    'cat'=>VoucherCat::INVITE,
                    'name'=>VoucherCat::getMessage(VoucherCat::INVITE),
                    'num'=>0,
                ],
                [
                    'cat'=>VoucherCat::SYSTEM,
                    'name'=>VoucherCat::getMessage(VoucherCat::SYSTEM),
                    'num'=>0,
                ],
            ],
            'shop'=>[
                [
                    'state'=>0,
                    'name'=>'全部',
                    'num'=>$shop_total,
                ],
                [
                    'state'=>AgentUserShopState::NOTQUALIFIED,
                    'name'=>AgentUserShopState::getMessage(AgentUserShopState::NOTQUALIFIED),
                    'num'=>0,
                ],
                [
                    'state'=>AgentUserShopState::FAILURE,
                    'name'=>AgentUserShopState::getMessage(AgentUserShopState::FAILURE),
                    'num'=>0,
                ],
                [
                    'state'=>AgentUserShopState::EXPIRE,
                    'name'=>AgentUserShopState::getMessage(AgentUserShopState::EXPIRE),
                    'num'=>0,
                ],
                [
                    'state'=>AgentUserShopState::STANDARDS,
                    'name'=>AgentUserShopState::getMessage(AgentUserShopState::STANDARDS),
                    'num'=>0,
                ]
            ]
        ];

        foreach ($data['shop'] as $key => $value) {
            if (array_key_exists($value['state'], $shop)) {
                $data['shop'][$key]['num']  = $shop[$value['state']];
            }
        }

        foreach ($data['state'] as $k => $v) {
            if (array_key_exists($v['state'], $state)) {
                $data['state'][$k]['num']  = $state[$v['state']];
            }
        }

        foreach ($data['cat'] as $ke => $va) {
            if (array_key_exists($va['cat'], $cat)) {
                $data['cat'][$ke]['num'] = $cat[$va['cat']];
            }
        }
        return $this->success($data);
    }
}
