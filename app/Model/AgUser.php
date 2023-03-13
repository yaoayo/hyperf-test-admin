<?php

declare (strict_types = 1);
namespace App\Model;

use Hyperf\Database\Model\SoftDeletes;

/**
 * @property int $id
 * @property string $agent_name
 * @property string $phone
 * @property string $password
 * @property int $source
 * @property string $create_time
 * @property int $state
 * @property string $cumulative_income
 * @property string $settle_income
 * @property string $deleted
 */
class AgUser extends Model
{
    use SoftDeletes;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'ag_user';
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
    protected $casts = ['id' => 'integer', 'source' => 'integer', 'state' => 'integer'];
}
