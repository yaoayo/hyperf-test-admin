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

use App\Service\ResponseService;
use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\HttpServer\Contract\ResponseInterface;
use Psr\Container\ContainerInterface;
use Hyperf\Contract\StdoutLoggerInterface;
/**
 * Class AbstractController
 * @method ResponseService setHttpCode(int $code = 200)
 * @method ResponseService setHttpHeader(string $name, $value)
 * @method success(mixed $data, int $business_code = 100000)
 * @method fail(string $error_msg = 'fail', mixed $data = null, int $business_code = 999999)
 * @package App\Controller
 */
abstract class AbstractController
{
    #[Inject]
    protected ContainerInterface $container;

    #[Inject]
    protected RequestInterface $request;

    #[Inject]
    protected ResponseInterface $response;

    #[Inject]
    protected StdoutLoggerInterface $logger;
    
    // 默认分页大小
    protected  $per_page = 10;

    /**
     * @param $name
     * @param $arguments
     *
     * @return mixed
     */
    public function __call($name, $arguments)
    {
        if (method_exists(ResponseService::class, $name)) {
            return make(ResponseService::class)->{$name}(...$arguments);
        }
    }
}
