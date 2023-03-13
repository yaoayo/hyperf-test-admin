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
namespace App\Controller;
use App\Model\User;
use App\Model\Role;
use App\Model\PtConfig;
use App\Model\Voucher;
use App\Constants\VoucherState;
use App\Constants\VoucherCat;
use App\Model\Resource;
use App\Resource\User as UserResource;
use App\Resource\UserCollection;



class IndexController extends AbstractController
{
    public function index()
    {
            // 查询用户 代推、待分配的券

        // $shop_income = PtConfig::where('name','Store')->value('contens');
        // $user = $this->request->input('user', 'Hyperf');
        // $method = $this->request->getMethod();
        return [
            // 'method' => $method,
            // 'message' => "Hello {$user}.",
            'env'=>env('APP_ENV'),
            // 'shop_income'=>json_decode($shop_income,true),
        ];
    }
}
