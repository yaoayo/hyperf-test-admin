<?php

declare(strict_types=1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class ResourceRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'title'=>'required|string|max:45',
            'system_id'=>'integer',
            'pid'=>'integer',
            'type'=>'integer',
            'permissions'=>'string',
            'url'=>'string',
            'icon'=>'present',
            'component'=>'string',
            'hidden'=>'numeric',
            'keepalive'=>'numeric',
            'sort_no'=>'integer',
            'super_admin'=>'integer',
            'remark'=>'present',
            'status'=>'integer',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'title' => '标题',
        ];
    }
}
