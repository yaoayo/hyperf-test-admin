<?php

declare (strict_types = 1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class VoucherRequest extends FormRequest
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
            'cat' => 'required|array',
            'user_id' => 'required|integer',
            'content' => 'present',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'content' => '备注',
            'user_id' => '用户ID',
            'cat' => '券类型',
        ];
    }
}
