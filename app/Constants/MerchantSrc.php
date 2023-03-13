<?php

declare (strict_types = 1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class MerchantSrc extends AbstractConstants
{

    /**
     * @Message("聚合邦")
     */
    const MCH_JHB = 1;

    /**
     * @Message("省赚宝")
     */
    const MCH_DY = 2;
}
