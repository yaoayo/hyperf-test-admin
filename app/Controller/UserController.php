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

use App\Exception\HttpRequestException;
use App\Model\Resource;
use App\Model\User;
use App\Request\LoginRequest;
use App\Request\UserRequest;
use App\Utils\Cache;
use Hyperf\DbConnection\Db;
use Hyperf\HttpServer\Contract\RequestInterface;

class UserController extends AbstractController
{

    /**
     * [verifyCode 获取图形验证码]
     * @return [type] [description]
     */
    public function verifyCode()
    {
        $config = new \EasySwoole\VerifyCode\Conf();
        $code = new \EasySwoole\VerifyCode\VerifyCode($config);
        //系统验证码
        $result = $code->DrawCode();

        $uuid = get_rand_str(32) . uniqid();
        Cache::getInstance()->set($uuid, $result->getImageCode(), 120);

        return $this->success([
            'image' => $result->getImageBase64(),
            'uuid' => $uuid,
            'code' => $result->getImageCode(),
        ]);
    }
    /**
     * [loginOut 用户退出登录]
     * @return [type]                [description]
     */
    public function loginOut()
    {
        auth()->logout();
        return $this->success();
    }

    /**
     * [login 用户登录]
     * @param LoginRequest $request [description]
     * @return [type]                [description]
     */
    public function login(LoginRequest $request)
    {

        // 参数验证
        $data = $request->validated();

        // 获取缓存验证码
        $uuid_value = Cache::get($data['uuid']);

        if (empty($uuid_value)) {
            throw new HttpRequestException('验证码不正确或已过期!');
        }

        // 验证用户输入的验证码
        if (strcasecmp($uuid_value, $data['captcha']) != 0) {
            throw new HttpRequestException('输入的验证码不正确!');
        }

        $User = User::with(['roles', 'menus'])->where('username', $data['username'])->first();

        if (empty($User)) {
            throw new HttpRequestException('用户未找到！');
        }

        // 验证用户输入的密码
        if (!password_verify($data['password'], $User['password'])) {
            throw new HttpRequestException('用户不存在或密码错误！');
        }

        if ($User['status'] == 0) {
            throw new HttpRequestException('该用户已被禁用！');
        }

        // 清除验证码
        Cache::delete($data['uuid']);

        $routes = [];
        foreach ($User->menus->toArray() as $role) {
            foreach ($role['resource'] as $menus) {
                $routes[] = $menus;
            }
        }
        // 缓存用户权限
        Cache::getInstance()->set('menus' . '_' . $User['id'], $routes, 3600);

        // 返回
        return $this->success(['token' => auth()->login($User)]);
    }

    /**
     * [info 用户详情]
     * @return [type] [description]
     */
    public function info()
    {

        $User = User::with(['roles', 'menus'])->where('id', auth()->id())->first();

        if (empty($User)) {
            throw new HttpRequestException('该用户不存在或已被禁用！');
        }

        $User = $User->toArray();

        if ($User['super_admin'] == 1) {
            $routes = Resource::query()->get()->toArray();
        } else {
            $routes = [];
            foreach ($User['menus'] as $key => $value) {
                foreach ($value['resource'] as $k => $v) {
                    $routes[] = $v;
                }
            }
        }

        // 获取权限树形列表
        $User['menus'] = getTreeMenus($routes);

        return $this->success($User);
    }

    /**
     * 获取用户列表
     */
    function list(RequestInterface $request) {

        $list = User::where(['status' => 1])->paginate((int)$request->input('per_page',$this->per_page));
        return $this->success($list);
    }

    /**
     * (修改)用户
     */
    public function save(UserRequest $request)
    {
        $post = $request->validated();
        $id = $request->input('id', 0);
        $role_ids = $request->input('role_ids', []);
        if (isset($post['role_ids'])) {
            unset($post['role_ids']);
        }

        if (!empty($post['password']) && $post['password'] !== $post['confirm_password']) {
            throw new HttpRequestException('两次密码输入不一致');
        }
        unset($post['confirm_password']);
        $arr = [];
        if (empty($post['password'])) {
            unset($post['password']);
        }else{
            $post['password'] = password_hash($post['password'], PASSWORD_DEFAULT);
        }

        User::where(['id' => $id])->update($post);
        if (!empty($role_ids)) {
            Db::table('pt_user_role')->where(['user_id' => $id])->delete();
            foreach ($role_ids as $v) {
                $arr_value = [
                    'user_id' => $id,
                    'role_id' => $v,
                ];
                $arr[] = $arr_value;
            }
        }
        if (!empty($arr)) {
            Db::table('pt_user_role')->insert($arr);
        }
        return $this->success();
    }

    /**
     * (新增)用户
     */
    public function add(UserRequest $request)
    {
        $post = $request->validated();
        $role_ids = $request->input('role_ids', []);
        if (isset($post['role_ids'])) {
            unset($post['role_ids']);
        }

        if (!empty($post['password']) && $post['password'] !== $post['confirm_password']) {
            throw new HttpRequestException('两次密码输入不一致');
        }
        unset($post['confirm_password']);
        $arr = [];
        if (empty($post['password'])) {
            throw new HttpRequestException('密码必传');
        }

        $post['password'] = password_hash($post['password'], PASSWORD_DEFAULT);
        $post['creator'] = auth()->user()->username;
        $insertGetId = User::insertGetId($post);
        if (!empty($role_ids)) {
            foreach ($role_ids as $v) {
                $arr_value = [
                    'user_id' => $insertGetId,
                    'role_id' => $v,
                ];
                $arr[] = $arr_value;
            }
        }
        if (!empty($arr)) {
            Db::table('pt_user_role')->insert($arr);
        }
        return $this->success();
    }

    /**
     * 删除用户
     */
    public function delete(RequestInterface $request)
    {
        //多个请传数组
        $id = $request->input('id', []);
        $list = User::whereIn('id', $id)->delete();
        if ($list) {
            Db::table('pt_user_role')->whereIn('user_id', $id)->delete();
        }
        return $this->success();
    }

    /**
     * 获取用户详情
     */
    public function detail(RequestInterface $request)
    {
        //多个请传数组
        $id = $request->input('id', 0);
        $user = User::where(['id' => $id])->first();
        if (empty($user)) {
            throw new HttpRequestException('数据不存在');
        }
        $list = $user->toArray();
        $list['role_ids'] = Db::table('pt_user_role')->where(['user_id' => $id])->pluck('role_id');
        return $this->success($list);
    }
}
