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

    protected $table = 'komentar';
    protected $primaryKey = 'ID';
    public $timestamps = false;
    protected $fillable = [
        'Text', 'Datum', 'IDKorisnik', 'IDProizvod'
    ];

    /*
    * funkcija koja dohvata komentar
    * sa zadatim id
    */
    public static function dohvati_sa_id($id)
    {
        return Komentar::where('ID', $id)->get();
    }
    /*
     * Metod za dohvatanje komentara za proizvod sa zadatim id
     */
    public static function dohvati_sa_IDProizvod($id)
    {
        return Komentar::where('IDProizvod', $id)->get();
    }
}
