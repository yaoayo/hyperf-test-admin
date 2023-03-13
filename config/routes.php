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
use App\Middleware\AuthMiddleware;
use App\Middleware\JwtMiddleware;
use Hyperf\HttpServer\Router\Router;

Router::addRoute(['GET', 'POST', 'HEAD'], '/', 'App\Controller\IndexController@index');

Router::get('/favicon.ico', function () {
    return '';
});

/*************************路由最后一层命名***********************/
// 列表 => list
// 添加 => add
// 删除 => del
// 添加或修改 => save
// 详情 => detail
/**************************************************************/

// 后台管理
Router::addGroup('/admin/', function () {

    // 后台用户登录
    Router::post('login', [\App\Controller\UserController::class, 'login']);
    // 获取验证码
    Router::get('captcha', [\App\Controller\UserController::class, 'verifyCode']);

    Router::post('notify', [\App\Controller\FinanceController::class, 'notify']);

    // 未激活已经过期券的状态维护
    Router::get('voucher-expire', [\App\Controller\VoucherExpireController::class, 'run']);

    // 用户管理模块
    Router::addGroup('user/', function () {
        // 获取用户详情
        Router::get('info', [\App\Controller\UserController::class, 'info']);
        // 添加、修改用户
        Router::post('save', [\App\Controller\UserController::class, 'save']);
        Router::post('add', [\App\Controller\UserController::class, 'add']);
        // 删除用户
        Router::post('del', [\App\Controller\UserController::class, 'delete']);
        //获取后台用户列表
        Router::get('list', [\App\Controller\UserController::class, 'list']);
        // 用户详情(用于修改用户)
        Router::get('detail', [\App\Controller\UserController::class, 'detail']);
        // 退出登录
        Router::get('login-out', [\App\Controller\UserController::class, 'loginOut']);

    }, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]);

    // 角色管理模块
    Router::addGroup('role/', function () {
        // 角色列表
        Router::get('list', [\App\Controller\RoleController::class, 'role']);
        //角色添加、修改
        Router::post('save', [\App\Controller\RoleController::class, 'save']);
        Router::post('add', [\App\Controller\RoleController::class, 'add']);
        // 角色删除
        Router::post('del', [\App\Controller\RoleController::class, 'delete']);
        // 获取角色详情
        Router::get('detail', [\App\Controller\RoleController::class, 'detail']);

    }, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]);

    //菜单管理模块
    Router::addGroup('menu/', function () {
        // 后台菜单修改
        Router::post('save', [\App\Controller\MenuController::class, 'save']);
        // 后台菜单添加
        Router::post('add', [\App\Controller\MenuController::class, 'add']);
        // 获取菜单列表
        Router::get('list', [\App\Controller\MenuController::class, 'list']);
        // 菜单详情
        Router::get('detail', [\App\Controller\MenuController::class, 'info']);
        //删除菜单
        Router::post('del', [\App\Controller\MenuController::class, 'delete']);
    }, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]);

    //字典管理模块
    Router::addGroup('dic/', function () {
        // 后台字典修改
        Router::post('save', [\App\Controller\DictionariesController::class, 'dicSave']);
        // 后台字典添加
        Router::post('add', [\App\Controller\DictionariesController::class, 'dicAdd']);
        // 获取字典列表、详情
        Router::get('list', [\App\Controller\DictionariesController::class, 'list']);
        // 字典详情
        Router::get('detail', [\App\Controller\DictionariesController::class, 'info']);
        //删除字典
        Router::post('del', [\App\Controller\DictionariesController::class, 'delete']);

        // 后台字典元素修改
        Router::post('entry-save', [\App\Controller\DictionariesController::class, 'entrySave']);
        // 后台字典元素添加
        Router::post('entry-add', [\App\Controller\DictionariesController::class, 'entryAdd']);
        // 获取字典元素列表、详情
        Router::get('entry-list', [\App\Controller\DictionariesController::class, 'entryList']);
        // 字典元素详情
        Router::get('entry-detail', [\App\Controller\DictionariesController::class, 'detail']);
        //根据key 查询所有字典
        Router::get('entry-key', [\App\Controller\DictionariesController::class, 'getDetailByValue']);
        //删除元素字典
        Router::post('entry-del', [\App\Controller\DictionariesController::class, 'del']);
    }, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]);

    //代理商管理模块
    Router::addGroup('agent/', function () {
        // 获取代理商列表
        Router::get('list', [\App\Controller\AgentController::class, 'list']);
        //代理商邀请详情
        Router::get('agent-list', [\App\Controller\AgentController::class, 'agentList']);
        // 代理商添加
        Router::post('add', [\App\Controller\AgentController::class, 'add']);
        // 代理商修改
        Router::post('save', [\App\Controller\AgentController::class, 'save']);
        // 代理商修改
        Router::get('mod', [\App\Controller\AgentController::class, 'mod']);
        // 代理商启用-禁用
        Router::get('state', [\App\Controller\AgentController::class, 'state']);
        // 代理商删除
        Router::get('del', [\App\Controller\AgentController::class, 'del']);
        // 代理商加载
        Router::get('load', [\App\Controller\AgentController::class, 'load']);
        // 补贴记录
        Router::post('log', [\App\Controller\AgentController::class, 'log']);
        //代理商详情 -基本信息
        Router::post('detail', [\App\Controller\AgentController::class, 'detail']);
        //代理商详情 -订单统计
        Router::post('detail_order', [\App\Controller\AgentController::class, 'detailOrder']);
    }, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]);
    // 券管理模块
    Router::addGroup('voucher/', function () {
        //增券
        Router::post('grant', [\App\Controller\VoucherController::class, 'grant']);
        // 减券
        Router::post('deduct', [\App\Controller\VoucherController::class, 'deduct']);
        // 列表
        Router::post('list', [\App\Controller\VoucherController::class, 'list']);
        // 赠送记录
        Router::get('give-list', [\App\Controller\VoucherController::class, 'giveList']);
        // 邀请记录列表
        Router::get('invate-list', [\App\Controller\VoucherController::class, 'invate']);
        // 邀请记录用户详情
        Router::get('invate-info', [\App\Controller\VoucherController::class, 'invateInfo']);
        // 券增减日志列表
        Router::get('voucher-log', [\App\Controller\VoucherController::class, 'voucherLog']);
        // 券切换
        Router::get('switch', [\App\Controller\VoucherController::class, 'voucherSwitch']);
        // 券状态统计
        Router::get('count', [\App\Controller\VoucherController::class, 'count']);
        // 可绑定店铺统计
        Router::get('need-bind', [\App\Controller\BindController::class, 'needBind']);
        // 绑定店铺
        Router::post('allocation', [\App\Controller\BindController::class, 'allocation']);
        // 绑定日志列表
        Router::get('bind-log', [\App\Controller\BindController::class, 'list']);
        // 绑定详情
        Router::get('bind-info', [\App\Controller\BindController::class, 'info']);
        // 修改绑定配置
        Router::post('bind-update', [\App\Controller\BindController::class, 'updateIncome']);
        // 绑定配置操作日志
        Router::get('income-log', [\App\Controller\BindController::class, 'updateIncomelog']);
        // 券状态、店铺和券关系状态统计
        Router::get('voucher-shop-count', [\App\Controller\VoucherController::class, 'voucherShopCount']);
        // 自动发放券任务规则列表
        Router::get('rule-list', [\App\Controller\VoucherAutoDeliveryController::class, 'list']);
        // 创建自动发放任务规则
        Router::post('rule-create', [\App\Controller\VoucherAutoDeliveryController::class, 'create']);

    }, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]);

    // 系统配置模块
    Router::addGroup('config/', function () {
        //获取系统配置
        Router::get('list', [\App\Controller\ConfigController::class, 'list']);
        //系统配置新增和修改
        Router::post('save', [\App\Controller\ConfigController::class, 'add']);
        //系统配置日志
        Router::post('log', [\App\Controller\ConfigLogController::class, 'list']);

    }, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]);

    // 代理商门店
    Router::addGroup('shop/', function () {
        //代理商门店列表
        Router::get('list', [\App\Controller\ShopController::class, 'list']);
        //门店池列表
        Router::get('shop-list', [\App\Controller\ShopController::class, 'shopList']);
        //详情
        Router::get('detail', [\App\Controller\ShopController::class, 'detail']);
        //代理商删除门店
        Router::post('del', [\App\Controller\ShopController::class, 'del']);
        //删除门店池
        Router::post('del-shop', [\App\Controller\ShopController::class, 'delShop']);
        Router::get('del-list', [\App\Controller\ShopController::class, 'delList']);
        //门店补贴日志
        Router::post('log', [\App\Controller\ShopController::class, 'log']);
        //门店详情-补贴记录
        Router::post('detaillog', [\App\Controller\ShopController::class, 'detailLog']);

    });
    // 财务管理
    Router::addGroup('finance/', function () {
        //列表
        Router::get('list', [\App\Controller\FinanceController::class, 'list']);
        //加载
        Router::get('load', [\App\Controller\FinanceController::class, 'load']);
        //三方余额查询
        Router::get('balance', [\App\Controller\FinanceController::class, 'balance']);
        //导出
        Router::get('download', [\App\Controller\FinanceController::class, 'download']);
        //发送账单
        Router::post('dispatch', [\App\Controller\FinanceController::class, 'dispatch']);
        //手动打款
        Router::post('hand', [\App\Controller\FinanceController::class, 'hand']);
        //打款记录
        Router::get('notes', [\App\Controller\FinanceController::class, 'notes']);
        //线上打款
        Router::post('online', [\App\Controller\FinanceController::class, 'online']);
        //驳回
        Router::post('reject', [\App\Controller\FinanceController::class, 'reject']);
        //重新打款
        Router::post('again', [\App\Controller\FinanceController::class, 'again']);
        //作废
        Router::post('cancel', [\App\Controller\FinanceController::class, 'cancel']);
        //恢复
        Router::post('resume', [\App\Controller\FinanceController::class, 'resume']);
    });

    // 订单列表
    Router::addGroup('order/', function () {
        //列表
        Router::get('list', [\App\Controller\OrderController::class, 'list']);

    });
    //, ['middleware' => [JwtMiddleware::class, AuthMiddleware::class]]

});
