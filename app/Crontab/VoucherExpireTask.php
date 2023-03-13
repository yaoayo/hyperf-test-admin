<?php

namespace App\Crontab;

use App\Model\Voucher;
use App\Constants\VoucherState;
use App\Service\CacheConfigService;

class VoucherExpireTask
{
    public function execute()
    {
        if (CacheConfigService::getKey('VoucherExpireTask','CrontabTask') == true) {
            $state = VoucherState::STATE_UNACTIVSTED;
            $valid_date = date('Y-m-d');
            $Voucher = Voucher::whereRaw("`state` = {$state} and `valid_date` <= '{$valid_date}'");
            if ($Voucher->count() > 0 && $Voucher->update(["state"=>VoucherState::STATE_EXPIRE])) {
                return true;
            }
        }
        
        return false;
    }

    public function isEnable(): bool
    {
        return true;
    }
}
