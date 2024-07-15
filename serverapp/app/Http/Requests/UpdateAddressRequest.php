<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateAddressRequest extends FormRequest
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
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'user_ref' => 'required | exists:users,ref',
            'country' => 'sometimes',
            'province' => 'sometimes',
            'city' => 'sometimes',
            'street' => 'sometimes',
            'full_address' => 'sometimes',
            'postal_code' => 'sometimes',
            'fax' => 'sometimes',
            'fixed_phone' => 'sometimes',
        ];
    }
}
