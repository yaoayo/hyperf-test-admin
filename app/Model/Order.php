<?php

declare (strict_types = 1);

namespace App\Model;

use Hyperf\Database\Model\SoftDeletes;
use Hyperf\DbConnection\Model\Model;

class Order extends Model
{

    use SoftDeletes;

    public $timestamps = false;

    const DELETED_AT = 'deleted';

    protected $table;

    protected $primaryKey = 'id';

    public function __construct($date = '')
    {
        $date = $date ?: date('Ym');
        $this->table = 'mch_logistics_order_' . $date;
    }
    protected $casts = ['id' => 'string'];

}
