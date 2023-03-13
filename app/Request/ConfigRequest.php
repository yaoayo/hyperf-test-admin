<?php

declare (strict_types = 1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class ConfigRequest extends FormRequest
{
    protected $scenes = [
        'get' => ['name'],
        'add' => ['name', 'contens'],
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
            'name' => 'required|max:50',
            'contens' => 'required|json',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'name' => 'key',
            'contens' => '数据',
        ];
    }
}
