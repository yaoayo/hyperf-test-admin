<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;
use Hyperf\Database\Model\SoftDeletes;


class UserShop extends Model
{

    use SoftDeletes;

    public $timestamps = false;

    const DELETED_AT = 'deleted';

    protected $table = 'ag_user_shop';

    protected $primaryKey = 'id';

    protected $fillable = [
        'agent_id',
        'agent_name',
        'mch_id',
        'mch_name',
        'shop_id',
        'shop_name',
        'voucher_id',
        'bonus_valid_date',
        'bonus_limit',
        'state',
        'create_time',
        'invalid_time',
        'complete_time',
        'bonus_income',
        'subsidy_income',
        'total_order',
        'bind_type',
        'bonus_date_limit',
        'bonus_start_date'
    ];

    public function agent()
    {
        return $this->belongsTo(AgUser::class, 'agent_id', 'id');
    }
    public function voucher()
    {
        return $this->belongsTo(Voucher::class, 'voucher_id', 'id');
    }
    public function merchant()
    {
        return $this->belongsTo(Merchant::class, 'mch_id', 'id');
    }
    public function shop()
    {
        return $this->belongsTo(MerchantShop::class, 'shop_id', 'id');
    }
}
