<?php

declare (strict_types = 1);
namespace App\Model;

/**
 * @property int $id
 * @property int $bill_id
 * @property int $remit_method
 * @property string $remit_no
 * @property int $remit_state
 * @property string $remit_amount
 * @property string $receive_user
 * @property string $receive_idcard
 * @property string $receive_phone
 * @property string $receive_bank
 * @property int $receive_bank_no
 * @property string $fail_msg
 * @property string $create_time
 */
class AgBillRemitRecord extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'ag_bill_remit_record';
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
    protected $casts = ['id' => 'integer', 'bill_id' => 'integer'];
}
