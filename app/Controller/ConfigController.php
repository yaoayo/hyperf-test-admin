<?php

declare (strict_types = 1);
/**
 * This file is part of Hyperf.
 *
 * @link     https://www.hyperf.io
 * @document https://hyperf.wiki
 * @contact  group@hyperf.io
 * @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
 */

namespace App\Controller;

use App\Model\PtConfig;
use App\Request\ConfigRequest;
use Psr\Container\ContainerInterface;
use App\Utils\Cache;

class ConfigController extends AbstractController
{
    public function __construct()
    {
        parent::__construct();
    }
    /**
     * 获取系统配置
     */
    function list(ContainerInterface $container) {
        //验证数据
        $request = $container->get(ConfigRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();

        $list = PtConfig::query()->where('name', $post['name'])->first();
        if ($list) {
            $list['contens'] = json_decode($list['contens'], true);
        }
        return $this->success($list);
    }

    /**
     * 系统配置添加/修改
     *
     */

    public function add(ConfigRequest $request, ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(ConfigRequest::class);
        $request->scene('add')->validateResolved();
        $post = $request->all();

        $list = PtConfig::query()->where('name', $post['name'])->first();
        if ($list) {
            PtConfig::query()->where('id', $list['id'])->update($post);
            getLog(auth()->user()->real_name, $list, $post, $post['name']);

            // 需要缓存的KEY
            if (in_array($post['name'], ['AutoStoreSet','CrontabTask','Store','Ground'])) {
                foreach (json_decode($post['contens']) as $key => $value) {
                    Cache::set($post['name'].':'.$key,$value);
                }
            }
        } else {
            //添加数据
            PtConfig::create($post);
            getLog(auth()->user()->real_name, [], $post, $post['name']);
        }

        return $this->success();
    }

}
