<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class VoucherSrc extends AbstractConstants
{
    // 券来源
    /**
     * @Message("系统发放")
     */
    const SOURCE_SYSTEM = 1;
    
    /**
     * @Message("省赚宝")
     */
    const SOURCE_SZB = 2;
    /**
     * @Message("系统自动发放")
     */
    const SOURCE_AUTO = 3;
}
