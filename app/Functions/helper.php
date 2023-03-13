<?php
declare (strict_types = 1);

use App\Model\PtConfigLog;
use App\Service\PayService;

if (!function_exists("get_rand_str")) {
    /**
     * [get_rand_str 生成随机串]
     * @param  integer $len    [需要生成长度]
     * @param  string  $format [需要按照指定格式进行生成]
     * @return [string]        [随机串]
     */
    function get_rand_str($len = 6, $format = 'ALL')
    {
        switch ($format) {
            case 'ALL':
            case 1:
                $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                break;
            case 'CHAR':
            case 2:
                $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
                break;
            case 'NUMBER':
            case 3:
                $chars = '123456789';
                break;
            default:
                $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                break;
        }$str = "";
        while (strlen($str) < $len) {
            $str .= substr($chars, (mt_rand() % strlen($chars)), 1);
        }

        return $str;
    }
}

if (!function_exists("get_is_mobile")) {
    /**
     * [get_is_mobile 验证手机格式]
     * @param  [string] $mobile [手机号码]
     * @return [boolean]        [true or false]
     */
    function get_is_mobile($mobile)
    {
        return preg_match('/1[3456789]{1}\d{9}$/', $mobile);
    }
}

if (!function_exists("get_is_email")) {
    /**
     * [get_is_email 验证邮箱格式]
     * @param  [string] $email [邮箱号]
     * @return [boolean]        [true or false]
     */
    function get_is_email($email)
    {
        return preg_match('/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/', $email);
    }
}

if (!function_exists("get_unix_time")) {
    /**
     * [get_unix_time 获取毫秒时间戳]
     * @return [type] [description]
     */
    function get_unix_time()
    {
        list($s1, $s2) = explode(' ', microtime());
        return (float) sprintf('%.0f', (floatval($s1) + floatval($s2)) * 1000);
    }
}

if (!function_exists("bd09_to_gcj02")) {

    /**
     * [bd09_to_gcj02 百度转火星]
     * @param  float|null $bd_lat [description]
     * @param  float|null $bd_lon [description]
     * @return [type]              [description]
     */
    function bd09_to_gcj02(float $bd_lat = 0.0, float $bd_lon = 0.0)
    {
        $pi = '3.1415926535897932384626';
        $x = $bd_lon - 0.0065;
        $y = $bd_lat - 0.006;
        $z = sqrt($x * $x + $y * $y) - 0.00002 * sin($y * $pi);

        $theta = atan2($y, $x) - 0.000003 * cos($x * $pi);
        $gg_lon = $z * cos($theta);
        $gg_lat = $z * sin($theta);
        return [
            'lon' => $gg_lon,
            'lat' => $gg_lat,
        ];
    }
}

if (!function_exists('auth')) {
    /**
     * Auth认证辅助方法
     * @param string|null $guard
     * @return \HyperfExt\Auth\Contracts\GuardInterface|\HyperfExt\Auth\Contracts\StatefulGuardInterface|\HyperfExt\Auth\Contracts\StatelessGuardInterface
     */
    function auth(string $guard = null)
    {
        if (is_null($guard)) {
            $guard = config('auth.default.guard');
        }

        return make(\HyperfExt\Auth\Contracts\AuthManagerInterface::class)->guard($guard);
    }
}

if (!function_exists('getTreeMenus')) {
    /**
     * [getTreeMenus 获取树形菜单列表]
     * @param  [array]  $data [description]
     * @param  integer $pId  [description]
     * @return [array]       [description]
     */
    function getTreeMenus($data, $pId = 0)
    {
        $tree = [];
        foreach ($data as $k => $v) {
            if ($v['pid'] == $pId) {
                $res = getTreeMenus($data, $v['id']);
                if (!empty($res)) {
                    $v['children'] = $res;
                }

                $tree[] = $v;
                unset($data[$k]);
            }
        }
        return $tree;
    }
}
if (!function_exists('getLog')) {
    /**
     * [getLog 写入日志]
     * @return [array]       [description]
     */

    function getLog($user = '', $data = [], $list = [], $name = '')
    {
        $arr = [
            'name' => $name,
            'front_val' => json_encode($data, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE),
            'behind_val' => json_encode($list, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE),
            'user_name' => $user,
            'create_time' => date('Y-m-d H:i:s'),
        ];
        PtConfigLog::create($arr);
    }

    if (!function_exists('curl_post')) {
        /**
         * curl_post
         * @param string        $url        地址
         * @param array|string  $param      参数
         * @param string        $config     更多配置 [header|format]
         * @return string       响应内容
         */
        function curl_post($url = '', $param = [], $config = [])
        {
            $header = isset($config['header']) ? $config['header'] : ['User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:56.0) Gecko/20100101 Firefox/56.0']; //默认请求头
            $format = isset($config['format']) ? $config['format'] : 'JSON'; //输出格式

            $ch = curl_init(); //初始化
            curl_setopt($ch, CURLOPT_URL, $url); //请求URL
            curl_setopt($ch, CURLOPT_HEADER, false); //是否响应头信息
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header); //请求头信息
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); //不直接输出结果
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST"); //请求方法
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); //验证对等证书
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2); //验证主机
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $param);

            //SSL配置
            if (isset($config['ssl'])) {
                foreach ($config['ssl'] as $key => $value) {
                    curl_setopt($ch, constant('CURLOPT_' . $key), $value);
                }
            }

            //请求资源内容
            $response = curl_exec($ch);

            //获取请求错误信息
            $error = curl_error($ch);
            //释放对象
            curl_close($ch);
            if ('JSON' == $format) {
                return json_decode($response, true);
            } else {
                return $response;
            }
        }
    }
    if (!function_exists('curl_get')) {
        /**
         * curl_get
         * @param string  $url        地址
         * @param array   $param      参数
         * @param string  $config     更多配置 [header|format]
         * @return string|array             响应内容
         */
        function curl_get($url = '', $param = [], $config = [])
        {
            //拆分锚数据
            if (strpos($url, '#') > 0) {
                list($url, $anchor) = explode('#', $url);
            }

            //地址组合处理
            if (strpos($url, '?') === false) {
                $url = $url . '?' . http_build_query($param);
            } else {
                $url = $url . '&' . http_build_query($param);
            }

            //附加锚信息
            if (isset($anchor)) {
                $url = $url . '#' . $anchor;
            }

            $header = isset($config['header']) ? $config['header'] : ['User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:56.0) Gecko/20100101 Firefox/56.0']; //默认请求头
            $format = isset($config['format']) ? $config['format'] : 'JSON'; //输出格式

            $ch = curl_init(); //初始化
            curl_setopt($ch, CURLOPT_URL, $url); //请求URL
            curl_setopt($ch, CURLOPT_HEADER, false); //是否响应头信息
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header); //请求头信息
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); //不直接输出结果
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET'); //请求方法
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); //验证对等证书
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2); //验证主机

            //SSL配置
            if (isset($config['ssl'])) {
                foreach ($config['ssl'] as $key => $value) {
                    curl_setopt($ch, constant('CURLOPT_' . $key), $value);
                }
            }

            //请求资源内容
            $response = curl_exec($ch);

            //获取请求错误信息
            $error = curl_error($ch);

            //释放对象
            curl_close($ch);

            if ('JSON' == $format) {
                return json_decode($response, true);
            } else {
                return $response;
            }
        }
    }
    if (!function_exists('decrypt')) {
        /**
         * [decrypt 第三方支付解密]
         * @return [array]       [description]
         */

        function decrypt($requestBody)
        {
            $pay = new PayService();
            $appSecret = $pay->secret; // 秘钥
            $data = openssl_decrypt($requestBody, 'AES-128-CBC', $appSecret, OPENSSL_ZERO_PADDING, $appSecret) ?? false;
            if ($data === false) {
                return '';
            }
            return str_replace("\x00", '', $data);
        }
    }
}
