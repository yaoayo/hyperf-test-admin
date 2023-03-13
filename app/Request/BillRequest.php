<?php

declare (strict_types = 1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class BillRequest extends FormRequest
{

    protected $scenes = [
        'get' => ['id'],
        'mod' => ['id', 'remarks'],
        'add' => ['data'],
    ];
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * 获取应用到请求的验证规则
     */
    public function rules(): array
    {
        return [
            'id' => 'required',
            'remarks' => 'required|string',
            'data' => 'required|array',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'id' => '标识',
            'remarks' => '备注',
            'data' => '数据',
        ];
    }

}
