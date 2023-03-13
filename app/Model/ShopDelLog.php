<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;

class ShopDelLog extends Model
{

    public $timestamps = false;

    protected $table = 'ag_shop_del_log';

    protected $primaryKey = 'id';

    protected $fillable = [
        'type',
        'oper_id',
        'oper_name',
        'oper_phone',
        'bonus_income',
        'agent_id',
        'agent_name',
        'mch_name',
        'agent_phone',
        'shop_id',
        'shop_name',
        'content',
        'create_time',
    ];
}