<?php

namespace App\Models;

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
}
