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

use App\Model\Role;
use Hyperf\DbConnection\Db;
use Hyperf\HttpServer\Contract\RequestInterface;

class RoleController extends AbstractController
{
    /**
     * 获取用户角色列表
     */
    public function role()
    {
        $list = Role::query()->get();
        return $this->success($list);
    }

    /**
     * 获取用户角色详情
     */
    public function detail(RequestInterface $request)
    {
        $id = $request->input('id', 0);
        $Role = Role::find($id);
        $Role['ids'] = Db::table('pt_role_res')->where(['role_id' => $id])->pluck('res_id');
        return $this->success($Role);
    }

    /**
     * 新建(修改)角色
     */
    public function save(RequestInterface $request)
    {
        $id = $request->input('id', 0);
        $post = $request->post();
        $ids = $post['ids'];
        unset($post['ids']);
        Role::where(['id' => $id])->update($post);
        Db::table('pt_role_res')->where(['role_id' => $id])->delete();
        foreach ($ids as $v) {
            $arr_value = [
                'role_id' => $id,
                'res_id' => $v,
            ];
            $arr[] = $arr_value;
        }
        Db::table('pt_role_res')->insert($arr);

        return $this->success();
    }

    /**
     * 新建角色
     */
    public function add(RequestInterface $request)
    {
        $post = $request->post();
        $ids = $request->input('ids', []);
        unset($post['ids']);
        $insertGetId = Role::insertGetId($post);
        $arr = [];
        foreach ($ids as $v) {
            $arr_value = [
                'role_id' => $insertGetId,
                'res_id' => $v,
            ];
            $arr[] = $arr_value;
        }
        Db::table('pt_role_res')->insert($arr);

        return $this->success();
    }

    /**
     * 删除角色
     */
    public function delete(RequestInterface $request)
    {
        $id = $request->input('id', []);
        $list = Role::whereIn('id', $id)->delete();
        if ($list) {
            Db::table('pt_role_res')->whereIn('role_id', $id)->delete();
        }
        return $this->success();
    }
}
