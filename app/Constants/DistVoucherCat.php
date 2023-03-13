<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class DistVoucherCat extends AbstractConstants
{
    // 券发放类型
    /**
     * @Message("一次发放")
     */
    const ONCE = 1;
    
    /**
     * @Message("多次发放")
     */
    const MANY = 2;
}
