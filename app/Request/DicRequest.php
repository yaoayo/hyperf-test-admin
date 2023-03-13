<?php

declare(strict_types=1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class DicRequest extends FormRequest
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
            'title'=>'required|string|min:1,max:45',
            'field'=>'required|string',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'title' => '字典名称',
            'field' => '字段',
        ];
    }
}
