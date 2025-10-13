<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
class Package extends Model
{

    // Pour la création de la factory
    use HasFactory;

    // Seuls les champs listés dans $fillable pourront être remplis automatiquement 
    protected $fillable = [
        'name',
        'price',
        'credits'
    ];
}
