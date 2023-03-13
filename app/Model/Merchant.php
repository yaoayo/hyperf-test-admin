<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;

class Merchant extends Model
{
    public $timestamps = false;

    protected $table = 'mch_merchant';

    protected $primaryKey = 'id';


    public function shop()
    {
        return $this->hasMany(MerchantShop::class, 'mch_id', 'id');
    }
}
