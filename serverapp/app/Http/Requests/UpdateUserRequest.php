<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateUserRequest extends FormRequest
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
            'firstname' => 'sometimes | min:3',
            'lastname' => 'sometimes | min:2',
            'username' => 'sometimes | min:5 | unique:users,username',
            'phone' => 'sometimes',
            'birthdate' => 'sometimes | date_format:Y/m/d',
            'avatar' => 'sometimes',
        ];
    }

    public function messages()
    {
        return [
            'firstname.min' => 'The firstname field should have atleat 3 characters.',
            'lastname.min' => 'The lastname field should have atleat 2 characters.',
            'username.min' => 'The username field should have atleat 5 characters.',
            'username.unique' => 'The username is already in use. Choose another one.',
            'birthdate.date_format' => 'Birthdate must respect the format Y/m/d'
        ];
    }
}
