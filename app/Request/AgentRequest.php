<?php

declare (strict_types = 1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class AgentRequest extends FormRequest
{

    protected $scenes = [
        'add' => ['agent_name', 'phone', 'state'],
        'mod' => ['id', 'agent_name', 'phone', 'state'],
        'get' => ['id'],
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
            'id' => 'required|integer',
            'agent_name' => 'required|max:45',
            'phone' => 'required',
            'state' => 'integer|in:1,2',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'agent_name' => '代理商名称',
            'phone' => '联系电话',
            'state' => '状态',
            'id' => '标识',
        ];
    }

}
