<?php

declare (strict_types = 1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class UserRequest extends FormRequest
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
            'username' => 'required|string|min:4,max:45',
            'password' => 'present',
            'confirm_password' => 'present',
            'real_name' => 'required|string|min:2,max:125',
            'role_ids' => 'present',
            'gender' => 'integer',
            'email' => 'email',
            'mobile' => 'telephone_number',
            'super_admin' => 'integer',
            'remark' => 'present',
            'status' => 'integer',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'username' => '用户名',
            'password' => '密码',
            'real_name' => '真实姓名',
            'header_url' => '头像',
        ];
    }
}
