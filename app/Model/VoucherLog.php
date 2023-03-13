<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;

class VoucherLog extends Model
{


    public $timestamps = false;

    protected $table = 'ag_voucher_log';

    protected $primaryKey = 'id';

    protected $fillable = [
        'oper_id',
        'oper_name',
        'oper_cat',
        'agent_id',
        'agent_name',
        'remark',
        'content',
        'create_time',
    ];
}
