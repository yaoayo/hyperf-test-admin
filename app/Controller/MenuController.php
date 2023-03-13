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
use App\Model\Resource;
use App\Model\User;
use App\Request\ResourceRequest;
use App\Request\UserRequest;
use Hyperf\DbConnection\Db;
use Hyperf\HttpServer\Contract\RequestInterface;

class MenuController extends AbstractController
{
    /**
     * 获取菜单列表
     */
    public function list() {
        $routes = Resource::where(['status' => 1])->orderBy('sort_no')->get()->toArray();
//        $list = Resource::where(['status' => 1, 'pid' => 0])->orderBy('sort_no')->paginate(10);
//        var_dump($list->items);
        $list= getTreeMenus($routes);
        return $this->success($list);
    }

    /**
     * [add 新增菜单]
     * @param ResourceRequest $request [description]
     */
    public function add(ResourceRequest $request) {

        $post = $request->validated();
        if (Resource::insert($post)) {
            return $this->success();
        }
        return $this->fail('操作失败');
    }

    /**
     * [save 菜单修改]
     * @param  ResourceRequest $request [description]
     * @return [type]                   [description]
     */
    public function save(ResourceRequest $request) {

        $post = $request->validated();
        if (Resource::where(['id' => $request->input('id', 0)])->update($post)) {
            return $this->success();
        }

        return $this->fail('操作失败');
    }

    /**
     * 删除菜单
     */
    public function delete(RequestInterface $request) {
        //多个请传数组
        (array)$id = $request->input('id', []);
        $list = Resource::whereIn('id', $id)->delete();
        return $this->success($list);
    }

    /**
     * 获取菜单详情
     */
    public function info(RequestInterface $request) {
        //多个请传数组
        $id = $request->input('id', 0);
        $list = Resource::where(['id' => $id])->first();
        return $this->success($list);
    }
}
