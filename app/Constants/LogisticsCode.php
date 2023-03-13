<?php

declare(strict_types=1);
/**
 * This file is part of Hyperf.
 *
 * @link     https://www.hyperf.io
 * @document https://hyperf.wiki
 * @contact  group@hyperf.io
 * @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
 */
namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
class LogisticsCode extends AbstractConstants
{
    /**
     * @Message("顺丰")
     */
    const LOGISTICS_SHUNFENG = 1;

    /**
     * @Message("达达")
     */
    const LOGISTICS_DADA = 2;

    /**
     * @Message("闪送")
     */
    const LOGISTICS_SHANSONG = 3;

    /**
     * @Message("蜂鸟")
     */
    const LOGISTICS_FENGNIAO = 4;

    /**
     * @Message("UU")
     */
    const LOGISTICS_UU = 5;

    /**
     * @Message("美团跑腿")
     */
    const LOGISTICS_MTPT = 6;

    /**
     * @Message("美团LS")
     */
    const LOGISTICS_MTLS = 7;

    /**
     * @Message("聚合配送")
     */
    const LOGISTICS_JUHE = 8;

    public static function getLogistics ($logistics_id) {
        if ($logistics_id < 110) {
            return $logistics_id - 99;
        } elseif ($logistics_id >= 130) {
            return self::LOGISTICS_JUHE;
        } else {
            return self::LOGISTICS_MTLS;
        }
    }


}
