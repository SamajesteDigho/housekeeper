<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreTaskRequest extends FormRequest
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
            'description' => 'required | min:1',
            'start' => 'required | date | after:now',
            'end' => 'sometimes | date | after:start',
            'price_per_hour' => 'required | numeric',
            'currency' => 'required',
            'reduction' => 'sometimes | numeric',
        ];
    }
}
