<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class SystemCode extends AbstractConstants
{
    /**
     * @Message("服务器出错了！")
     */
    const SERVER_ERROR = 500;
    /**
     * @Message("授权失败！")
     */
    const UNAUTH = 401;
    /**
     * @Message("参数验证失败！")
     */
    const PARAMETER_VALIDATION_ERROR = 400;

    /**
     * @Message("操作成功！")
     */
    const OPT_SUCCESS= 200;

    /**
     * @Message("操作失败！")
     */
    const OPT_ERROR= 201;
}
