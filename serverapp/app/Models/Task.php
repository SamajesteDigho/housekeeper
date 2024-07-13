<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    use HasFactory;

    protected $table = 'tasks';

    protected $fillable = [
        'ref',
        'client_id',
        'keeper_id',
        'description',
        'start',
        'end',
        'price_per_hour',
        'currency',
        'reduction',
        'status',
        'rating',
        'appreciation',
        'paid',
        'payment_ref'
    ];
}
