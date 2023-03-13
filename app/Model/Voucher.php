<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;
use Hyperf\Database\Model\SoftDeletes;


class Voucher extends Model
{

    use SoftDeletes;

    public $timestamps = false;

    const DELETED_AT = 'deleted';

    protected $table = 'ag_user_voucher';

    protected $primaryKey = 'id';

    protected $fillable = [
        'source',
        'source_id',
        'cat',
        'ag_user_id',
        'state',
        'voucher_code',
        'valid_date',
        'activated_time',
        'invite_allot_time',
        'activate_date_limit',
        'create_time',
        'update_time'
    ];
    
    public function agent()
    {
        return $this->belongsTo(AgUser::class, 'ag_user_id', 'id');
    }
    
}
