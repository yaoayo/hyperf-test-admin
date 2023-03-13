<?php

declare (strict_types = 1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class AgentBillStateCode extends AbstractConstants
{
    /**
     * @Message("未出账")
     */
    const AGENT_BILL_STATE_WCZ = 1;

    /**
     * @Message("待发送")
     */
    const AGENT_BILL_STATE_DFS = 2;

/**
 * @Message("待确认")
 */
    const AGENT_BILL_STATE_DQR = 3;

/**
 * @Message("待打款")
 */
    const AGENT_BILL_STATE_DDK = 4;

/**
 * @Message("打款中")
 */
    const AGENT_BILL_STATE_DKZ = 5;

/**
 * @Message("已打款")
 */
    const AGENT_BILL_STATE_YDK = 6;

/**
 * @Message("驳回")
 */
    const AGENT_BILL_STATE_BH = 7;

/**
 * @Message("三方驳回")
 */
    const AGENT_BILL_STATE_SFBH = 8;

/**
 * @Message("已做废")
 */
    const AGENT_BILL_STATE_YZF = 9;

}
