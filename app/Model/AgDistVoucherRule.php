<?php

declare (strict_types=1);
namespace App\Model;

/**
 * @property int $id 
 * @property int $agent_id 
 * @property string $remark 
 * @property int $voucher_cat 
 * @property int $dist_num 
 * @property int $dist_cat 
 * @property int $dist_arrival_cat 
 * @property int $dist_batch 
 * @property int $dist_interval 
 * @property int $activate_batch 
 * @property int $activate_interval 
 * @property string $create_time 
 * @property int $creator_id 
 * @property string $creator_name 
 * @property string $deleted 
 */
use Hyperf\Database\Model\SoftDeletes;

class AgDistVoucherRule extends Model
{
    use SoftDeletes;

    const DELETED_AT = 'deleted';

    public $timestamps = false;

    protected $primaryKey = 'id';

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'ag_dist_voucher_rule';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [];
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = ['id' => 'integer', 'agent_id' => 'integer', 'voucher_cat' => 'integer', 'dist_num' => 'integer', 'dist_cat' => 'integer', 'dist_arrival_cat' => 'integer', 'dist_batch' => 'integer', 'dist_interval' => 'integer', 'activate_batch' => 'integer', 'activate_interval' => 'integer', 'creator_id' => 'integer'];


}