<?php

namespace App\Service;

use App\Constants\SystemCode;
use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Contract\ResponseInterface;

/**
 * API请求返回服务类
 *
 * Class ResponseService
 *
 * @package App\Service
 */
class ResponseService
{
    /**
     * @var int
     */
    private $http_code = 200;

    /**
     * http头部信息
     *
     * @var string[]
     */
    private $http_headers = [];

    /**
     * @var int
     */
    private $business_code = 200;

    /**
     * 业务返回消息
     *
     * @var string
     */
    private $business_msg = 'success';

    /**
     * @Inject
     * @var ResponseInterface
     */
    private $response;

    /**
     * 设置http状态码
     *
     * @param int $code
     *
     * @return $this
     */
    public function setHttpCode(int $code = 200): self
    {
        $this->http_code = $code;

        return $this;
    }

    /**
     * 设置http头部信息
     *
     * @param string $name
     * @param mixed  $value
     *
     * @return $this
     */
    public function setHttpHeader(string $name = null, $value): self
    {
        if (!empty($name)) {
            $this->http_headers[$name] = (string) $value;
        }
        return $this;
    }

    /**
     * 成功数据返回
     *
     * @param mixed $data           返回数据
     * @param int   $business_code  业务返回码
     *
     * @return ResponseInterface|\Psr\Http\Message\ResponseInterface
     */
    public function success($data = [], int $business_code = 200)
    {
        $this->business_code = $business_code;
        $this->business_msg = SystemCode::getMessage($business_code);
        return $this->response($data);
    }

    /**
     * 失败返回
     *
     * @param string $error_msg      错误信息
     * @param mixed  $data           返回数据
     * @param int    $business_code  错误业务码
     *
     * @return ResponseInterface|\Psr\Http\Message\ResponseInterface
     */
    public function fail(string $error_msg = '', $data = null, int $business_code = 201)
    {
        $this->business_code = $business_code;
        $this->business_msg = empty($error_msg) ? SystemCode::getMessage($business_code) : $error_msg;
        return $this->response($data);
    }

    /**
     * 返回数据
     *
     * @param $data
     *
     * @return ResponseInterface|\Psr\Http\Message\ResponseInterface
     */
    private function response($data)
    {
        $this->response = $this->response->json($this->normalizeData($data))->withStatus($this->http_code);

        if (!empty($this->http_headers)) {
            foreach ($this->http_headers as $name => $value) {
                $this->response = $this->response->withHeader($name, $value);
            }
        }

        return $this->response;
    }

    /**
     * 标准化返回数据格式
     *
     * @param mixed $data  业务返回数据
     *
     * @return array
     */
    private function normalizeData($data): array
    {
        return [
            'code' => $this->business_code,
            'data' => $data,
            'msg' => $this->business_msg,
        ];
    }
}
