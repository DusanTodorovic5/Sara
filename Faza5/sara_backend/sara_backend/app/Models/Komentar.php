<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa Komentar predstavlja model Komentara iz baze podataka.
 */
class Komentar extends Model
{
    use HasFactory;

    protected $table='komentar';
    protected $primaryKey='ID';
    public $timestamps=false;
    protected $fillable=[
        'Text','Datum','IDKorisnik','IDProizvod'
    ];
}
