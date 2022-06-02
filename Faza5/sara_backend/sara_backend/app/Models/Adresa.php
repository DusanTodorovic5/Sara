<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa Adresa predstavlja model Adrese iz baze podataka.
 */
class Adresa extends Model
{
    use HasFactory;

    protected $table = 'adresa';
    protected $primaryKey = 'ID';
    public $timestamps = false;
    protected $fillable = [
        'Ulica', 'Broj', 'Sprat', 'BrojStana', 'PostanskiBroj', 'Mesto', 'IdKorisnik'
    ];

    //Metoda koja dohvata sve adrese iz baze
    public static function dohvati_sve()
    {
        return Adresa::all();
    }


    public static function dohv_za_korisnika($id)
    {
        return Adresa::where('IdKorisnik', $id);
    }
    //Metoda koja dohvata adresu sa zadatim id
    public static function dohv_sa_id($id)
    {
        return Adresa::where('ID', $id)->get();
    }

    //Metoda za proveru da li adresa postoji u bazi
    public static function proveri_da_li_postoji($ulica, $broj, $sprat, $brojStana, $postanskiBroj, $mesto, $id_korisnika)
    {
        return Adresa::where([
            ['Ulica', '=', $ulica],
            ['Broj', '=', $broj],
            ['Sprat', '=', $sprat],
            ['BrojStana', '=', $brojStana],
            ['PostanskiBroj', '=', $postanskiBroj],
            ['Mesto', '=', $mesto],
            ['IdKorisnik', '=', $id_korisnika],
        ])->get();
    }
}
