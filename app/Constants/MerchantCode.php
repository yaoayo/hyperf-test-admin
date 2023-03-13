<?php

declare (strict_types = 1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class MerchantCode extends AbstractConstants
{

    /*代理商门店关系状态*/
    // 1   未达标，门店产生的收益尚未达到设置的上限值，且有效期也尚未达到
    const AGENT_USER_SHOP_HAS_NOTQUALIFIED = 1;
    // 2   已失效，门店被商户删除、或者是代理商系统删除
    const AGENT_USER_SHOP_HAS_FAILURE = 2;
    // 3   已过期，门店设置的分成有效期比分润上限值先到，为已过期
    const AGENT_USER_SHOP_HAS_EXPIRE = 3;
    // 4   已达标，达到分润上限值，注意：若有效期和上限值恰好同时达到，门店状态为已达标
    const AGENT_USER_SHOP_HAS_STANDARDS = 4;

    /*商户的来源*/
    const SOURCE_SYSTEM = 1; //聚合帮
    const SOURCE_DY = 2; //省赚宝

    /*门店绑定方式*/
    const SHOP_BIND_ALLOCATION = 1; //手动分配
    const SHOP_BIND_INVITE = 2; //自主邀请
    const SHOP_BIND_AUTO = 3; //自动分配

    public static $messages = [
        self::AGENT_USER_SHOP_HAS_NOTQUALIFIED => '未达标',
        self::AGENT_USER_SHOP_HAS_FAILURE => '已失效',
        self::AGENT_USER_SHOP_HAS_EXPIRE => '已过期',
        self::AGENT_USER_SHOP_HAS_STANDARDS => '已达标',
        self::SOURCE_SYSTEM => '聚合帮',
        self::SOURCE_DY => '省赚宝',
        self::SHOP_BIND_ALLOCATION => '手动分配',
        self::SHOP_BIND_INVITE => '自主邀请',
        self::SHOP_BIND_AUTO => '自动分配',
    ];
}
