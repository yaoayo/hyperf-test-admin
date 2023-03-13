<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;

class VoucherBindLog extends Model
{

    public $timestamps = false;

    protected $table = 'ag_voucher_bind_log';

    protected $primaryKey = 'id';

    protected $fillable = [
        'oper_id',
        'oper_name',
        'agent_id',
        'agent_name',
        'agent_phone',
        'shop_id',
        'shop_name',
        'shop_phone',
        'voucher_id',
        'content',
        'create_time',
    ];
}