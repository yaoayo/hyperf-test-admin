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
use App\Model\Dic;
use App\Model\DicEntry;
use App\Model\Resource;
use App\Model\User;
use App\Request\DicEntryRequest;
use App\Request\DicRequest;
use App\Request\UserRequest;
use Hyperf\DbConnection\Db;
use Hyperf\HttpServer\Contract\RequestInterface;

class DictionariesController extends AbstractController
{
    /**
     * 获取字典列表
     */
    public function list(RequestInterface $request) {
        $list = Dic::where(['status' => 1])->paginate((int)$request->input('per_page',$this->per_page));
        return $this->success($list);
    }

    /**
     * [dicSave 修改字典]
     * @param  DicRequest $request [description]
     * @return [type]              [description]

     */
    public function dicSave(DicRequest $request) {
        
        $post = $request->validated();

        if (Dic::where(['id' => $request->input('id', 0)])->update($post)) {
            return $this->success();
        }

        return $this->fail('操作失败');
    }

    /**
     * [dicAdd 新建字典]
     * @param  DicRequest $request [description]
     * @return [type]              [description]
     */
    public function dicAdd(DicRequest $request) {
        $post = $request->validated();
        if (Dic::insert($post)) {
            return $this->success();
        }
        return $this->fail('操作失败');
    }
    /**
     * [entrySave 修改字典元素表]
     * @param  DicEntryRequest $request [description]
     * @return [type]                   [description]
     */
    public function entrySave(DicEntryRequest $request) {
        $post = $request->validated();

        if (DicEntry::where(['id' => $request->input('id', 0)])->update($post)) {
            return $this->success();
        }

        return $this->fail('操作失败');
    }
    /**
     * [entryAdd 新建字典元素表]
     * @param  DicEntryRequest $request [description]
     * @return [type]                   [description]
     */
    public function entryAdd(DicEntryRequest $request) {
        $post = $request->validated();
        if (DicEntry::insert($post)) {
           return $this->success();
        }
        return $this->fail('操作失败');
    }
    /**
     * 获取字典元素列表
     */
    public function entryList(RequestInterface $request) {
        $did = $request->input('did', 0);
        $list = DicEntry::where(['status' => 1, 'did' => $did])->paginate((int)$request->input('per_page',$this->per_page));
        return $this->success($list);
    }


    /**
     * 删除菜单
     */
    public function delete(RequestInterface $request) {
        //多个请传数组
        $id = $request->input('id', []);
        $list = Dic::whereIn('id', $id)->delete();
        return $this->success($list);
    }

    /**
     * 删除字段元素
     */
    public function del(RequestInterface $request) {
        //多个请传数组
        $id = $request->input('id', []);
        $list = DicEntry::whereIn('id', $id)->delete();
        return $this->success($list);
    }

    /**
     * 获取字典详情
     */
    public function info(RequestInterface $request) {
        $id = $request->input('id', 0);
        $list = Dic::where(['id' => $id])->first();
        return $this->success($list);
    }

    /**
     * 获取字典描述详情
     */
    public function detail(RequestInterface $request) {
        $id = $request->input('id', 0);
        $detail = DicEntry::where(['id' => $id])->first();
        return $this->success($detail);
    }

    /**
     * 获取字典描述详情
     */
    public function getDetailByValue(RequestInterface $request) {
        $key = $request->input('key', '');
        $did = 0;
        if ($key) {
           $did = Dic::where('field', $key)->value('id');
        }
        $list = DicEntry::where(['did' => $did])->get();
        return $this->success($list);
    }
}
