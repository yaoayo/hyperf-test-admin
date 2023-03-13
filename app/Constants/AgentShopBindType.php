<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class AgentShopBindType extends AbstractConstants
{
    // 门店代理商绑定方式
    /**
     * @Message("系统分配")
     */
    const ALLOCATION=1;
    /**
     * @Message("自主邀请")
     */
    const INVITE=2;
    /**
     * @Message("自动分配")
     */
    const AUTO=3;
}
