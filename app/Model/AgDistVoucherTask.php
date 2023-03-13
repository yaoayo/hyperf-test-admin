<?php

declare (strict_types=1);
namespace App\Model;

/**
 * @property int $id 
 * @property int $rule_id 
 * @property string $create_time 
 * @property int $agent_id 
 * @property int $voucher_cat 
 * @property int $dist_num 
 * @property string $activate_date_limit 
 * @property string $expect_run_date 
 * @property int $run_state 
 * @property string $run_fail_msg 
 * @property string $run_time 
 */
class AgDistVoucherTask extends Model
{

    public $timestamps = false;

    protected $primaryKey = 'id';

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'ag_dist_voucher_task';
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = ['id' => 'integer', 'rule_id' => 'integer', 'agent_id' => 'integer','voucher_cat'=>'integer', 'dist_num' => 'integer', 'run_state' => 'integer'];
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['rule_id','create_time','agent_id','voucher_cat','dist_num','activate_date_limit','expect_run_date','run_state','run_fail_msg','run_time'];
}