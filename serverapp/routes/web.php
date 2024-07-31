<?php

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
})->name('home');

Route::get('/welcome', function () {
    return redirect('/');
})->name('home');

Route::get('/dashboard', function () {
    return view('admin.dashboard');
});

Route::group(['prefix' => 'auth'], function () {
    Route::get('login', function(){ return '<h2>Login Page</h2>'; })->name('auth.login');
});

Route::get('unauthorized', function () {
    return Controller::failedResponse('Unauthorized request', 422);
})->name('unauthorized');

Route::get('register', function () {
    return 'Not yet defined';
})->name('register');