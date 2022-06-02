<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa Porudzbina predstavlja model Porudzbina iz baze podataka.
 */
class Porudzbina extends Model
{
    use HasFactory;
    protected $table = 'porudzbina';
    protected $primaryKey = 'ID';
    public $timestamps = false;
    protected $fillable = [
        'IDAdresa', 'IDKartica'
    ];
}
