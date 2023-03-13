<?php

declare(strict_types=1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class LoginRequest extends FormRequest
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
            'username'=>'required|string|min:4,max:45',
            'password'=>'required|string|min:6',
            'uuid'=>'required|string|min:32,max:125',
            'captcha'=>'required|string|min:4,max:6',
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
            'uuid' => '验证码KEY',
            'captcha' => '验证码',
        ];
    }
}
