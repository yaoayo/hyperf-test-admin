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

use _PHPStan_b8e553790\Nette\Neon\Exception;
use App\Constants\AgentCode;
use App\Constants\AgentIncomeCatCode;
use App\Constants\LogisticsCode;
use App\Constants\MerchantSrc;
use App\Exception\HttpRequestException;
use App\Model\AgUser;
use App\Model\AgUserIncome;
use App\Model\MerchantShop;
use App\Model\VoucherInvate;
use App\Request\AgentRequest;
use App\Utils\Cache;
use App\Utils\Log;
use Hyperf\HttpServer\Contract\RequestInterface;
use Psr\Container\ContainerInterface;

class AgentController extends AbstractController
{
    public function __construct()
    {
        parent::__construct();
    }
    /**
     * 获取代理商列表
     */
    function list(RequestInterface $request) {
        //获取参数
        $name = $request->input('name'); //搜索类容

        $state = $request->input('state'); //搜索状态

        $date = $request->input('date'); //搜索时间

        $source = $request->input('source'); //注册方式

        $order = $request->input('order'); //排序

        //检索条件
        $where = [];
        if ($state) {
            $where[] = ['state', '=', $state];
        }

        if ($source) {
            $where[] = ['source', '=', $source];
        }

        $query = AgUser::where($where);

        if ($date) {
            $query = $query->whereBetween('create_time', [date('Y-m-d', strtotime($date[0])), date('Y-m-d', strtotime('+1day', strtotime($date[1])))]);
        }

        //排序
        $nameList = empty($order) ? 'id' : 'cumulative_income';

        $orders = empty($order) ? 'desc' : $order;

        if ($name) {
            $query = $query->whereRaw("((`phone` like '%{$name}%') or (`agent_name` like '%{$name}%'))");
        }
        $list = $query->orderBy($nameList, $orders)->paginate((int) $request->input('per_page', $this->per_page));
        foreach ($list as &$item) {
            $item['code'] = MerchantSrc::getMessage($item['source']);

        }

        return $this->success($list);
    }
    /**
     * 代理商加载
     *
     */

    public function load()
    {

        $list = [
            'source' => [
                [
                    'id' => MerchantSrc::MCH_JHB,
                    'name' => MerchantSrc::getMessage(MerchantSrc::MCH_JHB),
                ],
                [
                    'id' => MerchantSrc::MCH_DY,
                    'name' => MerchantSrc::getMessage(MerchantSrc::MCH_DY),
                ],
            ],
            'state' => [['id' => 1, 'name' => '启用'], ['id' => 2, 'name' => '禁用']],
            'order' => [['id' => 'asc', 'name' => '升序'], ['id' => 'desc', 'name' => '倒序']],
        ];
        // foreach (AgentCode::$messages as $k => $v) {
        //     $list['source'][] = ['id' => $k, 'name' => $v];
        // }
        return $this->success($list);
    }
    /**
     * 代理商添加
     *
     */

    public function add(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(AgentRequest::class);
        $request->scene('add')->validateResolved();
        $post = $request->all();

        if (!get_is_mobile($post['phone'])) {
            throw new HttpRequestException('手机号错误');
        }

        $data = AgUser::query()->where('phone', $post['phone'])->first();

        if ($data) {
            throw new HttpRequestException('账号已存在');
        }

        //截取密码
        $post['password'] = password_hash(substr($post['phone'], -6), PASSWORD_DEFAULT);
        //获取时间
        $post['create_time'] = date('Y-m-d H:i:s');
        $post['agent_name'] = trim($post['agent_name']);

        $post['source'] = MerchantSrc::MCH_JHB;

        //添加数据
        AgUser::insert($post);

        return $this->success();
    }
    /**
     * 代理商修改
     */
    public function save(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(AgentRequest::class);
        $request->scene('mod')->validateResolved();
        $post = $request->all();

        if (!get_is_mobile($post['phone'])) {
            throw new HttpRequestException('手机号错误');
        }

        $data = AgUser::query()->where('id', $post['id'])->first();
        if (!$data) {
            throw new HttpRequestException('数据不存在');
        }
        $list = AgUser::query()->where([['id', '<>', $post['id']], ['phone', '=', $post['phone']]])->first();
        if ($list) {
            throw new HttpRequestException('账号已存在');
        }
        $post['agent_name'] = trim($post['agent_name']);
        //处理数据
        if ($post['state'] == 2) {
            Cache::getInstance()->set('AgentUserOut' . $post['id'], $post['id']);
        } else {
            // 清除缓存
            Cache::delete('AgentUserOut' . $post['id']);

        }

        //修改数据
        AgUser::query()->where('id', $post['id'])->update($post);

        return $this->success();
    }
    /**
     * 代理商重置密码
     */
    public function mod(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(AgentRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();

        $data = AgUser::query()->where('id', $post['id'])->first();
        if (!$data) {
            throw new HttpRequestException('数据不存在');
        }
        //截取密码
        $data->password = password_hash(substr($data['phone'], -6), PASSWORD_DEFAULT);
        //修改数据
        $data->save();

        return $this->success();
    }
    /**
     * 代理商启用-禁用
     */
    public function state(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(AgentRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();

        $data = AgUser::query()->where('id', $post['id'])->first();
        if (!$data) {
            throw new HttpRequestException('数据不存在');
        }
        //处理数据
        if ($data->state == 1) {
            Cache::set('AgentUserOut' . $post['id'], $post['id']);
            $data->state = 2;
        } else {
            // 清除缓存
            Cache::delete('AgentUserOut' . $post['id']);
            $data->state = 1;
        }
        //修改数据
        $data->save();

        return $this->success($data);
    }

    /**
     * 删除用户
     */
    public function del(ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(AgentRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();
        $data = AgUser::query()->where('id', $post['id'])->first();
        if (!$data) {
            throw new HttpRequestException('数据不存在');
        }
        $data->deleted = date('Y-m-d H:i:s');

        $data->save();

        return $this->success();
    }

    /**
     * 补贴记录
     */
    public function log(RequestInterface $request)
    {
        //获取参数
        $name = $request->input('name'); //搜索类容

        $date = $request->input('date'); //搜索时间

        //检索条件
        $where = [];
        $where[] = ['cat', '=', AgentIncomeCatCode::AGEVNT_INCOME_CAT_XTBT];
        $time = $date ? date('Ym', strtotime($date[0])) : date('Ym');
        $query = new AgUserIncome($time);
        $table = 'ag_user_income_' . $time;
        $query = $query->leftJoin('ag_user', 'ag_user.id', '=', $table . '.agent_id');
        $query = $query->where($where);
        if ($name) {
            $query = $query->where('ag_user.phone', 'like', '%' . $name . '%')
                ->orWhere($table . '.agent_name', 'like', '%' . $name . '%');
        }
        if ($date) {
            $query = $query->whereBetween($table . '.create_time', [date('Y-m-d 00:00:00', strtotime($date[0])), date('Y-m-d 00:00:00', strtotime('+1day', strtotime($date[1])))]);
        }
        $total_amount = $query->where($where)->selectRaw($table . '.*,ag_user.phone')->sum('income_amount') ?? 0;

        $list = $query->selectRaw($table . '.*,ag_user.phone')->orderBy($table . '.id', 'desc')->paginate((int) $request->input('per_page', $this->per_page));

        $list = $list->toArray();

        $list['total_amount'] = $total_amount;

        return $this->success($list);
    }
    /**
     * 代理商详情 -基本信息
     */
    public function detail(RequestInterface $request, ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(AgentRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();
        $arr = [];
        $data = AgUser::query()->where('id', $post['id'])->first();
        $arr['name'] = $data['name'];
        $arr['phone'] = $data['phone'];
        $arr['source'] = MerchantSrc::getMessage($data['source']);
        $arr['create_time'] = $data['create_time'];
        $arr['cumulative_income'] = $data['cumulative_income'];
        $arr['settle_income'] = $data['settle_income'];
        $arr['balance'] = bcsub($data['cumulative_income'], $data['settle_income'], 2);
        $arr['manage_income'] = 0;
        $arr['distribution_income'] = $data['cumulative_income'];
        $arr['shop_income'] = AgUserIncome::query()->where(['agent_id' => $post['id'], 'cat' => AgentIncomeCatCode::AGEVNT_INCOME_CAT_SHOP])->sum('income_amount') ?? 0;
        $arr['agent_income'] = AgUserIncome::query()->where(['agent_id' => $post['id'], 'cat' => AgentIncomeCatCode::AGEVNT_INCOME_CAT_XTBT])->sum('income_amount') ?? 0;
        return $this->success($arr);
    }

    /**
     * 代理商详情 -订单统计
     */
    public function detailOrder(RequestInterface $request, ContainerInterface $container)
    {
        //验证数据
        $request = $container->get(AgentRequest::class);
        $request->scene('get')->validateResolved();
        $post = $request->all();

        //获取参数
        $name = $request->input('name'); //搜索类容
        $date = $request->input('date'); //搜索时间
        //条件
        $where = [];

        $where[] = ['agent_id', '=', $post['id']];
        $where[] = ['cat', '=', AgentIncomeCatCode::AGEVNT_INCOME_CAT_DDFR];

        if ($name) {
            $where[] = ['subsidy_shop_name', '=', $name];
        }
        $time = $date ? date('Ym', strtotime($date[0])) : date('Ym');
        $query = new AgUserIncome($time);
        $query = $query->with('order')->where($where);
        if ($date) {
            $query = $query->whereBetween('create_time', [date('Y-m-d 00:00:00', strtotime($date[0])), date('Y-m-d 00:00:00', strtotime('+1day', strtotime($date[1])))]);
        }
        $list = $query->paginate((int) $request->input('per_page', $this->per_page));
        foreach ($list as &$item) {
            $item['order']['order_plat'] = AgentCode::getMessage($item['order']['order_plat']);
            $item['order']['logistics_plat'] = LogisticsCode::getMessage($item['order']['logistics_plat']);
            $price = AgUserIncome::query()->where(['agent_id' => $post['id'], 'cat' => AgentIncomeCatCode::AGEVNT_INCOME_CAT_DDBT, 'profit_order_id' => $item['profit_order_id']])->first();
            $item['subsidy_amount'] = empty($price) ? 0 : $price['income_amount'];
            $item['total_amount'] = bcadd((string) $item['income_amount'], (string) $item['subsidy_amount'], 2);
        }
        $list = $list->toArray();
        $list['order_count'] = $query->where($where)->count();
        $list['order_total'] = $query->where($where)->sum('income_amount');

        //条件
        unset($where[1]);
        $where[] = ['cat', '=', AgentIncomeCatCode::AGEVNT_INCOME_CAT_DDBT];

        $list['order_subsidy_total'] = $query->where($where)->sum('income_amount');

        return $this->success($list);

    }

    /**
     * [list 邀请列表]
     * @return [type] [description]
     */
    function agentList(RequestInterface $request) {
        $vo_id = $request->input('id', 0);
        $list = VoucherInvate::query()->where(['voucher_id' => $vo_id])->with('shop')->first();

        return $this->success($list);
    }

}
