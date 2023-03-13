<?php

declare(strict_types=1);

namespace App\Exception\Handler;

use Hyperf\ExceptionHandler\ExceptionHandler;
use Hyperf\HttpMessage\Stream\SwooleStream;
use Psr\Http\Message\ResponseInterface;
use App\Exception\HttpRequestException;
use Throwable;

class HttpRequestExceptionHandler extends ExceptionHandler
{
    public function handle(Throwable $throwable, ResponseInterface $response)
    {
        if ($throwable instanceof HttpRequestException) {
            $data = json_encode([
                'code' => ($throwable->getCode() == 0) ? 201 : $throwable->getCode(),
                'msg' => $throwable->getMessage(),
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