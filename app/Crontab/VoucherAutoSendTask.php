<?php

namespace App\Crontab;

use App\Model\AgUser;
use App\Model\Voucher;
use App\Model\VoucherLog;
use Hyperf\DbConnection\Db;
use App\Constants\VoucherSrc;
use App\Constants\VoucherCat;
use App\Model\AgDistVoucherTask;
use App\Constants\VoucherState;
use App\Service\CacheConfigService;
use App\Constants\AgDistVoucherTaskCode;

class VoucherAutoSendTask
{
    public function execute()
    {
        if (CacheConfigService::getKey('VoucherAutoSendTask','CrontabTask') == true) {

            $run_state = AgDistVoucherTaskCode::WAIT;
            $expect_run_date = date('Y-m-d');
            $AgDistVoucherTask = AgDistVoucherTask::whereRaw("`run_state` = {$run_state} and `expect_run_date` <= '{$expect_run_date}'");
            if ($AgDistVoucherTask->count() > 0 ) {

                foreach ($AgDistVoucherTask->limit(5)->get() as $task) {
                    try {
                        if ($this->grant($task->voucher_cat,$task->dist_num,$task->agent_id,$task->activate_date_limit,$task->rule_id)) {
                            $task->update(['run_state'=>AgDistVoucherTaskCode::EXECUTED]);
                        }
                    } catch (\Exception $e) {
                        $task->update([
                            'run_state'=>AgDistVoucherTaskCode::ERROR,
                            'run_fail_msg'=>$e->getMessage()
                        ]);
                    }
                }
            }
        }
    }

    /**
     * [grant description]
     * @param  integer $cat            [券类型 1自推 2代推]
     * @param  integer $num            [券数量]
     * @param  integer $user_id        [代理商ID]
     * @param  string  $activated_time [券激活时间]
     * @param  integer $source_id      [自动发券对应任务ID]
     * @return [type]                  [description]
     */
    public function grant($cat = 0,$num=0,$user_id = 0,$activated_time='',$source_id = 0){

        // 获取配置
        $validity = CacheConfigService::getKey('validity','Ground') ?? 0;

        // 代理商
        $AgUser = AgUser::where(['id'=>$user_id,'state'=>1])->select('id', 'agent_name','phone')->first();
        if (empty($AgUser)) throw new \Exception("未找到代理商或代理商已被禁用"); 
        
        $type_message =  VoucherCat::getMessage($cat) ?? '未知';

        $voucher_data = [];
        $voucher_logs = [];
        // 券日志
        $voucher_logs[] = [
            'agent_id'=> $user_id,
            'agent_name'=> $AgUser->agent_name . ' ' . $AgUser->phone,
            'oper_cat'=>3,
            'oper_id'=>0,
            'oper_name'=>'系统定时任务发放',
            'create_time'=> date('Y-m-d H:i:s'),
            'remark'=>'系统定时任务发放',
            'content'=> '发放'.$type_message.$num.'张'
        ];
        // 券数据
        $data = [ 
            'source'=> VoucherSrc::SOURCE_SYSTEM,
            'cat'=> $cat,
            'source_id'=> $source_id,
            'ag_user_id'=> $user_id,
            'voucher_code'=>uniqid(),
            'state'=> VoucherState::STATE_UNACTIVSTED,
            'activate_date_limit'=>$activated_time,
            'valid_date'=> date('Y-m-d',strtotime("+{$validity} days")),
            'create_time'=> date('Y-m-d H:i:s')
        ];

        for ($i=0; $i < $num; $i++) {
            $voucher_data[] = array_merge($data,['voucher_code'=>uniqid()]);
        }
        
        Db::beginTransaction();

        try{
            if(VoucherLog::insert($voucher_logs)  && Voucher::insert($voucher_data)){
                Db::commit();
                return true;
            }
            Db::rollBack();
        } catch(\Throwable $ex){
            Db::rollBack();
        }
        return false;
    }

    public function isEnable(): bool
    {
        return true;
    }
}
