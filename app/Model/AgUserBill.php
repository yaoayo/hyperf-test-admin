<?php

declare (strict_types = 1);
namespace App\Model;

/**
 * @property int $id
 * @property string $create_time
 * @property int $agent_id
 * @property string $agent_name
 * @property string $agent_phone
 * @property string $bill_period
 * @property string $profit_income
 * @property string $subsidy_income
 * @property string $total_income
 * @property string $tax_rate
 * @property int $real_income
 * @property int $state
 * @property string $receiver_user
 * @property string $receiver_phone
 * @property string $receiver_idcard
 * @property string $receiver_bank
 * @property string $receiver_bank_no
 */
class AgUserBill extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'ag_user_bill';
    public $timestamps = false;

    protected $primaryKey = 'id';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guarded = [];
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = ['id' => 'integer', 'agent_id' => 'integer'];
}
