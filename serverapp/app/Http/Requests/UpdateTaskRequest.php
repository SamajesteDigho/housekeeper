<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateTaskRequest extends FormRequest
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
            'client_ref' => 'required | exists:users,ref',
            'keeper_ref' => 'required | exists:users,ref',
            'description' => 'sometimes | min:10',
            'start' => 'sometimes | date | after:now',
            'end' => 'sometimes | date:Y/m/d | after:start',
            'price_per_hour' => 'sometimes | numeric',
            'currency' => 'sometimes',
            'reduction' => 'sometimes | numeric',
        ];
    }
}
