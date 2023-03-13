<?php

declare (strict_types = 1);
namespace App\Model;

/**
 * @property int $id
 * @property int $voucher_valid_day
 * @property int $bonus_valid_day
 * @property string $allot_bonus_limit
 * @property string $invate_bonus_limit
 */
class PtConfig extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'pt_config';
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
    protected $casts = ['id' => 'integer'];
}
