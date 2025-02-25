<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    use HasFactory;
    protected $table = 'addresses';

    protected $fillable = [
        'user_id',
        'country',
        'province',
        'city',
        'street',
        'full_address',
        'postal_code',
        'fax',
        'fixed_phone',
    ];
}
