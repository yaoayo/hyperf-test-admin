<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class VoucherCat extends AbstractConstants
{
    // 券类型
    /**
     * @Message("自推")
     */
    const INVITE = 1;
    
    /**
     * @Message("代推")
     */
    const SYSTEM = 2;
}
