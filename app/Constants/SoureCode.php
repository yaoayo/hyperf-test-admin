<?php

declare (strict_types = 1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class SoureCode extends AbstractConstants
{
    // 券来源
    /**
     * @Message("聚合邦")
     */
    const SOURCE_JHB = 1;

    /**
     * @Message("省赚宝")
     */
    const SOURCE_DY = 2;
}
