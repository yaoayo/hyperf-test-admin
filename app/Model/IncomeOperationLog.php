<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;

class IncomeOperationLog extends Model
{


    public $timestamps = false;

    protected $table = 'ag_income_operation_log';

    protected $primaryKey = 'id';

    protected $fillable = [
        'oper_id',
        'oper_name',
        'old_valid_date',
        'new_valid_date',
        'old_bonus_limit',
        'new_bonus_limit',
        'content',
        'create_time',
    ];
}