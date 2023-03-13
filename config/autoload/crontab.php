<?php

declare (strict_types = 1);
/**
 * This file is part of Hyperf.
 *
 * @link     https://www.hyperf.io
 * @document https://hyperf.wiki
 * @contact  group@hyperf.io
 * @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
 */
use Hyperf\Crontab\Crontab;
use App\Crontab\VoucherAutoBindShopTask;
use App\Crontab\VoucherAutoSendTask;
use App\Crontab\VoucherExpireTask;

return [
    'enable' => true,
    'crontab' => [
        
        (new Crontab())->setName('VoucherAutoBindShop')
        ->setRule('* * * * *')
        ->setCallback([VoucherAutoBindShopTask::class, 'execute'])
        ->setEnable(true)
        ->setMemo('自动绑定店铺'),

        (new Crontab())->setName('VoucherAutoSend')
        ->setRule('* * * * *')
        ->setCallback([VoucherAutoSendTask::class, 'execute'])
        ->setEnable(true)
        ->setMemo('自动发券'),

        (new Crontab())->setName('VoucherExpire')
        ->setRule('* * * * *')
        ->setCallback([VoucherExpireTask::class, 'execute'])
        ->setEnable(true)
        ->setMemo('券过期'),
    ],
];
