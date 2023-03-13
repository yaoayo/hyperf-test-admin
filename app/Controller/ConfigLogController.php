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

use App\Model\PtConfigLog;
use App\Request\ConfigRequest;
use Psr\Container\ContainerInterface;

class ConfigLogController extends AbstractController
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
        //检索条件
        $where = [];
        $where[] = ['name', '=', $post['name']];

        if (isset($post['user_name'])) {
            $where[] = ['user_name', '=', $post['user_name']];
        }
        $query = PtConfigLog::query()->where($where);
        if (isset($post['date'])) {
            $query = $query->whereBetween('create_time', [date('Y-m-d', strtotime($post['date'][0])), date('Y-m-d', strtotime('+1day', strtotime($post['date'][1])))]);
        }
        $list = $query->orderBy('create_time', 'desc')->paginate((int) $request->input('per_page', $this->per_page));
        foreach ($list as &$item) {
            $item['behind_val'] = empty($item['behind_val']) ? [] : json_decode($item['behind_val'], true);
            $item['front_val'] = empty($item['front_val']) ? [] : json_decode($item['front_val'], true);

        }
        return $this->success($list);
    }

}
