<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class AgDistVoucherTaskCode extends AbstractConstants
{
    // 券的状态
    /**
     * @Message("待运行")
     */
    const WAIT = 1;
        /**
     * @Message("运行中")
     */
    const IN_SERVICE = 2;
    /**
     * @Message("已运行")
     */
    const EXECUTED = 3;
    /**
     * @Message("运行失败")
     */
    const ERROR = 4;
        /**
     * @Message("运行终止")
     */
    const STOP = 5;
}
