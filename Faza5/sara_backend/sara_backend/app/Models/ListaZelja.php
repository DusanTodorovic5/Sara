<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa Komentar predstavlja model Komentara iz baze podataka.
 */
class ListaZelja extends Model
{
    use HasFactory;

    protected $table = 'zeli';
    protected $primaryKey = 'IdKorisnika';
    public $timestamps = false;
    protected $fillable = [
        'IdProizvoda', 'Obavesti', 'IdKorisnika'
    ];

    /*
    * funkcija koja dohvata komentar
    * sa zadatim id
    */
    public static function dohvati_sa_idKorisnika($id)
    {
        return ListaZelja::where('IdKorisnika', $id)->get();
    }

    public static function dohv($idProizvod, $idKorisnik)
    {
        return ListaZelja::where(['IdKorisnika' => $idKorisnik, 'IdProizvoda' => $idProizvod])->get();
    }

    public static function azuriraj_polje($idProizvod, $idKorisnik, $polje)
    {
        return ListaZelja::where(['IdKorisnika' => $idKorisnik, 'IdProizvoda' => $idProizvod])->update(['Obavesti' => $polje]);
    }

    public static function obrisi($idProizvod, $idKorisnik)
    {
        return ListaZelja::where('IdKorisnika', $idKorisnik)->where('IdProizvoda', $idProizvod)->delete();
    }
}
