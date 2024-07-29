<?php

use App\Http\Controllers\api\v1\AddressController;
use App\Http\Controllers\api\v1\AuthenticateController;
use App\Http\Controllers\api\v1\HouseKeeperController;
use App\Http\Controllers\api\v1\TaskController;
use App\Http\Controllers\api\v1\UserController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::get('ping', function (Request $request) {
    return response()->json([
        'status' => 'Listening',
        'status_code' => 200,
        'message' => 'Pinging successful.'
    ], 200);
});

/*
|---------------------------------------------------------------------------
|   AUTHENTICATION API MODULUS
|---------------------------------------------------------------------------
| This is the authentication routes for the api resources in their different
| versions grouped and specified by v_ filled with version number.
*/

Route::group(['prefix' => 'v1'], function () {
    Route::group(['prefix' => 'auth'], function () {
        Route::post('login', [AuthenticateController::class, 'login'])->name('login_v1');
        Route::post('register', [AuthenticateController::class, 'register'])->name('register_v1');
    });

    Route::group(['prefix' => 'users'], function () {
        Route::get('', [UserController::class, 'get'])->name('user.get_v1');
        Route::post('', [UserController::class, 'create'])->name('user.create_v1');
        Route::get('{ref}', [UserController::class, 'read'])->name('user.read_v1');
        Route::post('{ref}', [UserController::class, 'update'])->name('user.update_v1');
        Route::delete('{ref}', [UserController::class, 'delete'])->name('user.delete_v1');
        
        Route::post('{ref}/id_doc', [UserController::class, 'load_identificationFile'])->name('user.load_identFile_v1');
        Route::get('search/{term}', [UserController::class, 'search'])->name('user.search_v1');
    });

    Route::group(['prefix' => 'addresses'], function () {
        Route::get('', [AddressController::class, 'get'])->name('address.get_v1');
        Route::post('', [AddressController::class, 'create'])->name('address.create_v1');
        Route::get('{id}', [AddressController::class, 'read'])->name('address.read_v1');
        Route::post('{id}', [AddressController::class, 'update'])->name('address.update_v1');
        Route::delete('{id}', [AddressController::class, 'delete'])->name('address.delete_v1');
    });

    Route::group(['prefix' => 'keepers'], function () {
        Route::get('', [HouseKeeperController::class, 'get'])->name('keepers.get_v1');
        Route::post('', [HouseKeeperController::class, 'create'])->name('keepers.create_v1');
        Route::get('{id}', [HouseKeeperController::class, 'read'])->name('keepers.read_v1');
        Route::post('{id}', [HouseKeeperController::class, 'update'])->name('keepers.update_v1');
        Route::delete('{id}', [HouseKeeperController::class, 'delete'])->name('keepers.delete_v1');

        Route::get('top/search', [HouseKeeperController::class, 'top_keepers'])->name('keepers.top_v1');
        Route::get('near/search', [HouseKeeperController::class, 'near_keepers'])->name('keepers.near_v1');
        Route::get('keeper/search', [HouseKeeperController::class, 'search_keepers'])->name('keepers.keeper_v1');
    });

    Route::group(['prefix' => 'tasks'], function () {
        Route::get('', [TaskController::class, 'get'])->name('tasks.get_v1');
        Route::post('', [TaskController::class, 'create'])->name('tasks.create_v1');
        Route::get('{id}', [TaskController::class, 'read'])->name('tasks.read_v1');
        Route::post('{id}', [TaskController::class, 'update'])->name('tasks.update_v1');
        Route::delete('{id}', [TaskController::class, 'delete'])->name('tasks.delete_v1');

        Route::get('{user_ref}/my_tasks', [TaskController::class, 'user_tasks'])->name('tasks.my_tasks_v1');
        Route::post('{ref}/set_status', [TaskController::class, 'set_status'])->name('tasks.set_status_v1');
        Route::post('{ref}/appreciate', [TaskController::class, 'appreciate'])->name('tasks.appreciate_v1');
    });
});
