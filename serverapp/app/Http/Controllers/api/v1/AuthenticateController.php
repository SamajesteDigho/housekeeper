<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\Housekeeper;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Auth;

class AuthenticateController extends Controller
{
    public function login(LoginRequest $request)
    {
        try {
            $data = $request->validated();
            $pseudo = $data['pseudo'];
            $password = $data['password'];

            if (Auth::attempt(['email' => $pseudo, 'password' => $password])) {
                $user = Auth::user();
                $user->avatar = $user->avatar ?? 'http://' . $_SERVER['SERVER_NAME'] . ':' . $_SERVER['SERVER_PORT'] . ($user->avatar ?? '/data/avatar/default_male.jpg');
            } else if (Auth::attempt(['username' => $pseudo, 'password' => $password])) {
                $user = Auth::user();
                $user->avatar = $user->avatar ?? 'http://' . $_SERVER['SERVER_NAME'] . ':' . $_SERVER['SERVER_PORT'] . ($user->avatar ?? '/data/avatar/default_male.jpg');
            } else {
                return Controller::failedResponse('Invalid credentials !', 403);
            }

            // Collect keeper info
            $keeper = Housekeeper::where(['user_id' => $user->id])->first();
            $user->keeper = Housekeeper::process_user_keeper($keeper, $user)->keeper;
            $result = [
                'result' => $user,
                'token' => $user->createToken('usertoken')->plainTextToken,
            ];
            return Controller::successfulResponse($result);
        } catch (Exception $e) {
            return Controller::failedResponse('[SERVER ERROR]: ' . $e, 500);
        }
    }

    public function register(Request $request)
    {
        $data = $request->all();
        $firstname = Arr::get($data, "firstname");
        $lastname = Arr::get($data, "lastname");
        $username = Arr::get($data, "username");
        $email = Arr::get($data, "email");
        $phone = Arr::get($data, "phone");
        $password = Arr::get($data, "password");
        $ref = Controller::userRefGen();

        $query = [
            'email' => $email,
            'ref' => $ref,
            'firstname' => $firstname,
            'lastname' => $lastname,
            'username' => $username ?? User::generateUsername($ref),
            'phone' => $phone,
            'password' => bcrypt($password),
        ];

        User::create($query);
        Auth::attempt(['email' => $email, 'password' => $password]);
        $result = [
            'result' => User::parse_user(Auth::user()),
            'token' => Auth::user()->createToken('userToken')->plainTextToken,
        ];
        return Controller::successfulResponse($result, 201);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        $result = [
            'message' => 'Logged out successfully'
        ];
        return Controller::successfulResponse($result);
    }
}
