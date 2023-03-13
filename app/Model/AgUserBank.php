<?php

declare (strict_types = 1);
namespace App\Model;

use Hyperf\Database\Model\SoftDeletes;

/**
 * @property int $id
 * @property int $agent_id
 * @property string $holder_name
 * @property string $reserve_phone
 * @property string $bank_no
 * @property string $bank_cat
 * @property string $sub_bank
 * @property string $bank_front_img
 * @property string $bank_back_img
 * @property string $ic_card
 * @property string $id_card_front_img
 * @property string $id_card_back_img
 * @property int $verify_code
 * @property int $deleted
 */
class AgUserBank extends Model
{
    use SoftDeletes;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'ag_user_bank';

    public $timestamps = false;

    const DELETED_AT = 'deleted';

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
    protected $casts = ['id' => 'integer', 'agent_id' => 'integer', 'verify_code' => 'integer', 'deleted' => 'integer'];
}
