<?php

declare (strict_types = 1);
namespace App\Model;

/**
 * @property int $id
 * @property string $create_time
 * @property int $agent_id
 * @property string $agent_name
 * @property int $cat
 * @property string $income_amount
 * @property string $profit_order_id
 * @property int $profit_order_shop_id
 * @property int $profit_cat
 * @property string $profit_base_amount
 * @property string $profit_rate
 * @property int $subsidy_shop_id
 * @property string $subsidy_shop_name
 */
class AgUserIncome extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */

    protected $table;

    public $timestamps = false;

    public function __construct($date = '')
    {
        $date = $date ?: date('Ym');
        $this->table = 'ag_user_income_' . $date;
    }

    protected $primaryKey = 'id';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guarded = [];
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = ['id' => 'integer', 'profit_order_id' => 'string', 'agent_id' => 'integer', 'cat' => 'integer', 'profit_order_shop_id' => 'integer', 'profit_cat' => 'integer', 'subsidy_shop_id' => 'integer'];
    //关联表
    public function agent()
    {
        return $this->hasOne(AgUser::class, 'id', 'agent_id');
    }

    //关联表
    public function order()
    {
        return $this->hasOne(Order::class, 'id', 'profit_order_id');
    }
}
