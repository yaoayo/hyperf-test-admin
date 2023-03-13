<?php

declare (strict_types = 1);
namespace App\Model;

/**
 * @property int $id
 * @property string $front_val
 * @property string $behind_val
 * @property string $create_time
 * @property string $user_name
 */
class PtConfigLog extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'pt_config_log';
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
