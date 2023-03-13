<?php

declare(strict_types=1);

namespace App\Request;

use Hyperf\Validation\Request\FormRequest;

class DicEntryRequest extends FormRequest
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
            'did'=>'required|integer',
            'title'=>'required|string|min:1,max:45',
            'val'=>'required|string',
        ];
    }

    /**
     * [attributes 获取验证错误的自定义属性]
     * @return [array] [description]
     */
    public function attributes(): array
    {
        return [
            'title' => '含义',
            'val' => '键值',
        ];
    }
}
