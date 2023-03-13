<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;
use Hyperf\Database\Model\SoftDeletes;

class MerchantShop extends Model
{
    public $timestamps = false;

    protected $table = 'mch_shop';

    protected $primaryKey = 'id';

    protected $fillable = ['mch_id', 'shop_name'];

    
}
