<?php

declare(strict_types=1);

namespace App\Middleware;

use Hyperf\Di\Annotation\Inject;
use HyperfExt\Jwt\Exceptions\TokenExpiredException;
use HyperfExt\Jwt\JwtFactory;
use Psr\Container\ContainerInterface;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\RequestHandlerInterface;
use App\Exception\HttpRequestException;

class JwtMiddleware implements MiddlewareInterface
{
    /**
     * @var ContainerInterface
     */
    protected $container;
    
    private $jwtFactory;

    public function __construct(ContainerInterface $container, JwtFactory $jwtFactory)
    {
        $this->container = $container;
        $this->jwtFactory = $jwtFactory;
    }

    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        $jwt = $this->jwtFactory->make();

        try {
            $jwt->checkOrFail();
        } catch (\Exception $exception) {
            if (! $exception instanceof TokenExpiredException) {
                throw new HttpRequestException($exception->getMessage(),401);
            }
            //  尝试自动刷新 token
            try {
                $token = $jwt->getToken();

                // 刷新token
                $new_token = $jwt->getManager()->refresh($token);

                // 解析token载荷信息
                $payload = $jwt->getManager()->decode($token, false, true);

                // 旧token加入黑名单
                $jwt->getManager()->getBlacklist()->add($payload);

                // 一次性登录，保证此次请求畅通
                auth($payload->get('guard') ?? config('auth.default.guard'))
                    ->onceUsingId($payload->get('sub'));

                return $handler->handle($request)->withHeader('authorization', 'bearer ' . $new_token);
            } catch (\Exception $exception) {
                //    Token 验证失败
                throw new HttpRequestException($exception->getMessage(),401);

            }
        }

        
        return $handler->handle($request);
    }
}