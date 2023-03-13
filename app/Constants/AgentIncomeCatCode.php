<?php

declare (strict_types = 1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class AgentIncomeCatCode extends AbstractConstants
{
    /**
     * @Message("系统补贴")
     */
    const AGEVNT_INCOME_CAT_XTBT = 1;
    /**
     * @Message("订单补贴")
     */
    const AGEVNT_INCOME_CAT_DDBT = 2;

    /**
     * @Message("订单分润")
     */
    const AGEVNT_INCOME_CAT_DDFR = 3;

    /**
     * @Message("门店补贴")
     */
    const AGEVNT_INCOME_CAT_SHOP = 4;

}
