<?php

namespace App\Models;

use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Housekeeper extends Model
{
    use HasFactory;

    /**
     * 
     */
    protected $table = 'housekeepers';

    /**
     * Here are the attributes that are mass assignable
     */
    protected $fillable = [
        'user_id',
        'rating',
        'images',
        'nationality',
        'province',
        'religion',
        'matricule'
    ];

    /**
     * Here are the attributes that should be casted
     */
    protected $casts = [];

    /* ================================================================
     * UTILITY AND PARSING FUNCTIONS
    ================================================================*/
    public static function process_user_keeper(Housekeeper $hk, User $user) : User {
        $user = User::parse_user($user);

        $hk->verified = boolval($hk->verified);
        $hk->rating = floatval($hk->rating);
        $user->keeper = $hk;
        
        return $user;
    }
}
