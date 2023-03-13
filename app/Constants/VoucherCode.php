<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class VoucherCode extends AbstractConstants
{
    // 券的来源 
    const SOURCE_SYSTEM = 1;//系统发放
    const SOURCE_SZB = 2;//省赚宝
    // 券的类型
    const INVITE = 1;//自主邀请
    const SYSTEM = 2;//系统分配
    // 券的状态
    const STATE_UNACTIVSTED = 1;//未激活
    const STATE_INVITE = 2;//待邀请
    const STATE_ALLOCATION = 3;//待分配
    const STATE_COMPLTET_ALLOCATION = 4;//已分配
    const STATE_COMPLTET_INVITE = 5;//邀请完成
    const STATE_EXPIRE = 6;//已过期



    public static $messages = [
        self::SOURCE_SYSTEM => '系统发放',
        self::SOURCE_SZB => '省赚宝',
        self::INVITE => '自主邀请',
        self::SYSTEM => '系统分配',
        self::STATE_UNACTIVSTED => '未激活',
        self::STATE_INVITE => '待邀请',
        self::STATE_ALLOCATION => '待分配',
        self::STATE_COMPLTET_ALLOCATION => '已分配',
        self::STATE_COMPLTET_INVITE => '邀请完成',
        self::STATE_EXPIRE => '已过期',
    ];
}
