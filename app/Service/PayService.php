<?php
// +----------------------------------------------------------------------
// | DPAPI [DOPAIK API FRAMEWORK]
// +----------------------------------------------------------------------
// | Copyright (c) 2016~2021 http://www.dopaik.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: HUJUN <306616415@qq.com>
// +----------------------------------------------------------------------

namespace App\Service;

use App\Utils\Cache;

/**
 * 支付服务

 * @version 1.1.3
 */
class PayService
{
    //apiUrl:https://xlapi.51xinlong.com/ws-test/rute?service={接口名称}）
    private $apiUrl = 'https://xlapi.51xinlong.com/openapi?service=';
    //获取网关Token URL:https://xlapi.51xinlong.com/ws-test/auth/openapi?appid=xxx&secret=xxx
    private $tokenUrl = 'https://xlapi.51xinlong.com/jwt/auth/openapi';
    // APPKEY
    private $appid = '446711077613436928';
    //appSecret
    public $secret = 'xdQkjapZp2CwBdfz';
    //uuid 唯一标识 UUID
    public $uuid = '446684024143048704'; //'446274043151753216';
    //companyid 集团id
    private $companyid = '445615421787906048'; //'446274017688129536';
    //account
    private $account = '2088420008944252'; //'120402343481';
    //mainAccount 主体账户（必须传）
    private $mainAccount = '2088510805746295'; //'323331000007777';
    // 认证TOKEN
    protected $access_token = null;
    //接口名称
    protected $name = null;
    //回调地址
    // public $url = 'https: //agent-test.juhebangshou.com/adminapi/';

    public function __construct($name = '')
    {
        $this->name = $name;
        $access_token = Cache::get('pay:access_token');
        if (empty($access_token)) {
            $access_token = $this->accessToken();
        }
        $this->access_token = $access_token;
    }
    /**
     * 请求访问
     * $data 请求数据
     * $name 接口名称
     * @return string
     */
    public function pay($data)
    {
        $url = $this->apiUrl . $this->name;
        $param = array_merge($this->config(), ['requestBody' => $this->getEncryptionData($data)]);
        $header = [
            "Authorization:" . "Bearer " . $this->access_token,
            "traceID:" . uniqid(),
            "companyid:" . $this->companyid,
            "mainAccount:" . $this->mainAccount,
        ];
        $response = curl_post($url, $param, ['header' => $header]);
        return $response;
    }

    /**
     * 获取加密数据
     * @param array $params
     * @return string
     */
    protected function getEncryptionData(array $params): string
    {
        $requestBody = $params;
        $key = $this->secret;
        $body = json_encode($requestBody);
        $l = strlen($key);
        if ($l < 16) {
            $key = str_repeat($key, ceil(16 / $l));
        }

        if ($m = strlen($body) % 16) {
            $body .= str_repeat("\x00", 16 - $m);
        }

        return base64_encode(openssl_encrypt($body, "AES-128-CBC", $key, OPENSSL_RAW_DATA | OPENSSL_NO_PADDING, $key));
    }

    /**
     * 公共参数
     */
    protected function config()
    {
        $arr = [
            'timestamp' => time() * 1000,
            'appKey' => $this->appid,
            'version' => ' V1.1.0',
            'appSecret' => $this->secret,
        ];
        $arr['signature'] = $this->sign($arr);
        unset($arr['appSecret']);
        return $arr;
    }

    /**
     * 获取签名
     * @param array $params
     * @return string
     */
    protected function sign(array $params): string
    {
        ksort($params, SORT_NATURAL | SORT_FLAG_CASE); //排序不区分大小写
        $str = '';
        foreach ($params as $k => $v) {
            if ($k == 'signature' || $k == 'requestBody') {
                continue;
            }

            $str .= $k . $v;
        }
        $str = 'key' . $str . 'secret';
        // 对该字符串进行 SHA1 运算,得到一个十六进制的数
        $encodeStr = strtoupper(sha1($str));
        return $encodeStr;
    }

    /**
     * 获取网关Token
     */
    public function accessToken()
    {
        $param = [
            'appid' => $this->appid,
            'secret' => $this->secret,
        ];
        $response = curl_get($this->tokenUrl, $param);
        if ($response['access_token']) {
            Cache::getInstance()->set('pay:access_token', $response['access_token'], $response['expires_in']);
        }
        return $response['access_token'];
    }
}
