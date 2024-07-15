<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Auth;

class AuthenticateController extends Controller
{
    public function login(LoginRequest $request) {
        $data = $request->validated();
        $pseudo = $data['pseudo'];
        $password = $data['password'];

        if (Auth::attempt(['email' => $pseudo, 'password' => $password])) {
            $user = Auth::user();
        }
        else if (Auth::attempt(['username' => $pseudo, 'password' => $password])) {
            $user = Auth::user();
        }
        else {
            return Controller::failedResponse('Invalid credentials !', 403);
        }
        $result = [
            'user' => $user,
            'token' => $user->createToken('usertoken')->plainTextToken,
        ];
        return Controller::successfulResponse($result);
    }

    public function register(RegisterRequest $request) {
        $data = $request->validated();
        $email = Arr::get($data, 'email');
        $password = Arr::get($data, 'password');
        $ref = Controller::userRefGen();

        $query = [
            'ref' => $ref,
            'firstname' => Arr::get($data, 'firstname', null),
            'lastname' => Arr::get($data, 'lastname', null),
            'username' => Arr::get($data, 'username', null) ?? User::generateUsername($ref),
            'email' => $email,
            'phone' => Arr::get($data, 'phone', null),
            'birthdate' => Arr::get($data, 'birthdate', null),
            'password' => bcrypt($password),
        ];
        User::create($query);
        Auth::attempt(['email' => $email, 'password' => $password]);
        $result = [
            'user' => Auth::user(),
            'token' => Auth::user()->createToken('userToken')->plainTextToken,
        ];
        return Controller::successfulResponse($result, 201);
    }
    
    public function logout(Request $request) {
        $request->user()->currentAccessToken()->delete();
        $result= [
            'message' => 'Logged out successfully'
        ];
        return Controller::successfulResponse($result);
    }
}
