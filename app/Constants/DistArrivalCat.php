<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class DistArrivalCat extends AbstractConstants
{
    // 券到账类型
    /**
     * @Message("立即到账")
     */
    const IMMEDIATELY = 1;
    /**
     * @Message("隔天到账")
     */
    const LATER = 2;
}
