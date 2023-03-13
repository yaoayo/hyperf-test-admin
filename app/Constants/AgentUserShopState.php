<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;
use Hyperf\Constants\Annotation\Constants;

/**
 * @Constants
 */
#[Constants]
class AgentUserShopState extends AbstractConstants
{
    /*代理商门店关系状态*/
   
    /**
     * @Message("未达标")
     */
    const NOTQUALIFIED=1; //门店产生的收益尚未达到设置的上限值，且有效期也尚未达到
    /**
     * @Message("已失效")
     */
    const FAILURE=2;//门店被商户删除、或者是代理商系统删除
    /**
     * @Message("已过期")
     */
    const EXPIRE =3;//门店设置的分成有效期比分润上限值先到，为已过期
    /**
     * @Message("已达标")
     */
    const STANDARDS =4;//达到分润上限值，注意：若有效期和上限值恰好同时达到，门店状态为已达标
}
