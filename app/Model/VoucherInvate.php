<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;
use Hyperf\Database\Model\SoftDeletes;

class VoucherInvate extends Model
{
    use SoftDeletes;

    const DELETED_AT = 'deleted';

    public $timestamps = false;

    protected $table = 'ag_voucher_invate';

    protected $primaryKey = 'id';

   
    public function agent()
    {
        return $this->belongsTo(AgUser::class, 'agent_id', 'id');
    }

    // 券
    public function voucher()
    {
        return $this->belongsTo(Voucher::class, 'voucher_id', 'id');
    }

    public function merchant()
    {
        return $this->belongsTo(Merchant::class, 'mch_id', 'id')->with('shop');
    }

    public function shop()
    {
        return $this->hasMany(MerchantShop::class, 'mch_id', 'mch_id');
    }
}
