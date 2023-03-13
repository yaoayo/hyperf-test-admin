<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class VoucherState extends AbstractConstants
{
    // 券的状态
    /**
     * @Message("未激活")
     */
    const STATE_UNACTIVSTED = 1;
        /**
     * @Message("待邀请")
     */
    const STATE_INVITE = 2;
    /**
     * @Message("待分配")
     */
    const STATE_ALLOCATION = 3;
    /**
     * @Message("已分配")
     */
    const STATE_COMPLTET_ALLOCATION = 4;
        /**
     * @Message("邀请完成")
     */
    const STATE_COMPLTET_INVITE = 5;
    /**
     * @Message("已过期")
     */
    const STATE_EXPIRE = 6;
}
