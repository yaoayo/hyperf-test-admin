<?php

declare(strict_types=1);

namespace App\Middleware;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use App\Exception\HttpRequestException;
use App\Utils\Cache;

class AuthMiddleware implements MiddlewareInterface
{
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $url = $request->getUri();
        $parse = parse_url((string)$url,PHP_URL_PATH);
        
        // 判断是否是超级管理员
        if (auth()->user()->super_admin == 1) {
            return $handler->handle($request);
        }
        // 白名单接口
        if (in_array($parse, ['/admin/user/info','/admin/user/login-out'])) {
            return $handler->handle($request);
        }

        $menus = Cache::get('menus_'.auth()->id());
        if (empty($menus)){
            throw new HttpRequestException('请重新登录！');
        }

        $routes = [];
        foreach ($menus as $v) {
            if (!empty($v)) {
                foreach (explode(':',$v['permissions']) as  $perm) {
                    $routes[] = $perm;
                }
            }
        }
        if (!in_array($parse, $routes)) {
            throw new HttpRequestException('该操作未授权！',401);
        }
        
        return $handler->handle($request);
    }
}