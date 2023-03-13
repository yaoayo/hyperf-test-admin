<?php

declare (strict_types = 1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class AgentCode extends AbstractConstants
{
    /**
     * 商户来源
     */
    const MCH_JHB = 1;
    const MCH_DY = 2;

    public static $mch = [
        self::MCH_JHB => '聚合邦',
        self::MCH_DY => '省赚宝',
    ];

    /**
     * @Message("美团")
     */
    const PLAT_MT = 1;

    /**
     * @Message("美团PLUS")
     */
    const PLAT_MT_PLUS = 2;

    /**
     * @Message("饿了么")
     */
    const PLAT_ELM = 3;

    /**
     * @Message("饿百")
     */
    const PLAT_EB = 4;

    /**
     * @Message("其他")
     */
    const PLAT_OT = 99;

    public static function getPlat($plat_id)
    {
        if ($plat_id == 11) {
            return self::PLAT_MT_PLUS;
        } elseif ($plat_id == 5) {
            return self::PLAT_EB;
        } else {
            return $plat_id;
        }
    }

}
