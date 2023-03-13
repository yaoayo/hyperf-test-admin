<?php

declare(strict_types=1);

namespace App\Exception\Handler;

use Hyperf\ExceptionHandler\ExceptionHandler;
use Hyperf\HttpMessage\Stream\SwooleStream;
use Hyperf\Validation\ValidationException;
use Psr\Http\Message\ResponseInterface;
use Throwable;

/**
 * 自定义表单验证异常处理器.
 *
 * Class FromValidateExceptionHandler
 */
class FromValidateExceptionHandler extends ExceptionHandler
{
    public function handle(Throwable $throwable, ResponseInterface $response)
    {
        if ($throwable instanceof ValidationException) {
            $data = json_encode([
                'code' => 400,
                'msg' => $throwable->validator->errors()->first(),
                'data' => [],
            ]);
            $this->stopPropagation();
            return $response->withStatus(200)->withBody(new SwooleStream($data));
        }
        return $response;
    }
    // 异常处理器处理该异常
    public function isValid(Throwable $throwable): bool
    {
        return true;
    }
}