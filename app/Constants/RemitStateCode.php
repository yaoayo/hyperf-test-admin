<?php

declare (strict_types = 1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class RemitStateCode extends AbstractConstants
{
    /**
     * @Message("打款中")
     */
    const REMIT_STATE_DKZ = 1;

    /**
     * @Message("打款成功")
     */
    const REMIT_STATE_DKCG = 2;

    /**
     * @Message("打款失败")
     */
    const REMIT_STATE_DKSB = 3;

}
