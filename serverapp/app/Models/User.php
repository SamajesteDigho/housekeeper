<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use Faker\Factory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Arr;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * Define the table name to access for this model.
     */
    protected $table = 'users';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'ref',
        'firstname',
        'lastname',
        'username',
        'birthdate',
        'avatar',
        'email',
        'phone',
        'id_docs',
        'status',
        'role',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public static function generateUsername(string $ref)
    {
        $parts = explode('-', $ref);
        $code = 'U' . last($parts);
        return $code;
    }

    public static function parse_user(User|null $user) {
        if ($user == null) {
            return null;
        }
        $user->avatar = $user->avatar ?? 'http://' . $_SERVER['SERVER_NAME'] . ':' . $_SERVER['SERVER_PORT'] . ($user->avatar ?? '/data/avatar/default_male.jpg');
        $user->id_docs = $user->id_docs != null ? 'http://' . $_SERVER['SERVER_NAME'] . ':' . $_SERVER['SERVER_PORT'] . '/' . $user->id_docs : null;
        $user->address = Address::where(['user_id' => $user->id])->first();
        return $user;
    }

    public static function parse_user_list($users) {
        $list = [];
        foreach($users as $user) {
            $list[] = User::parse_user($user);
        }
        return $list;
    }
}
