<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa Kartica predstavlja model Kartice iz baze podataka.
 */
class Kartica extends Model
{
    use HasFactory;

    protected $table = 'kartica';
    protected $primaryKey = 'ID';
    public $timestamps = false;
    protected $fillable = [
        'Broj', 'CSV', 'DatumIsteka', 'idKorisnik'
    ];

    //Metoda koja dohvata sve kartice iz baze
    public static function dohvati_sve()
    {
        return Kartica::all();
    }

    //Metoda koja dohvata karticu sa zadatim id
    public static function dohv_sa_id($id)
    {
        return Kartica::where('ID', $id)->get();
    }

    public static function dohv_za_korisnika($id)
    {
        return Kartica::where('IdKorisnik', $id);
    }

    //Metoda za proveru da li kartica postoji u bazi
    public static function proveri_da_li_postoji($broj_kartice, $csv, $datum_isteka, $id_korisnika)
    {
        return Adresa::where([
            ['Broj', '=', $broj_kartice],
            ['CSV', '=', $csv],
            ['DatumIsteka', '=', $datum_isteka],
            ['idKorisnik', '=', $id_korisnika],
        ])->get();
    }
}
