<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\DbConnection\Model\Model;
use Hyperf\Database\Model\SoftDeletes;

class VoucherGiftRecord extends Model
{
    use SoftDeletes;

    const DELETED_AT = 'deleted';
    
    public $timestamps = false;

    protected $table = 'ag_voucher_gift_record';

    protected $primaryKey = 'id';

    // 增出
    public function from_agent()
    {
        return $this->belongsTo(AgUser::class, 'from_agent_id', 'id');
    }
    // 增入
    public function to_agent()
    {
        return $this->belongsTo(AgUser::class, 'to_agent_id', 'id');
    }
    // 券
    public function voucher()
    {
        return $this->belongsTo(Voucher::class, 'voucher_id', 'id');
    }
}
