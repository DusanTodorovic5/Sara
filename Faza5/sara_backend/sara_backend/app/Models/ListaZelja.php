<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa ListaZelja predstavlja model Zeli iz baze podataka.
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
    * funkcija koja dohvata listu zelja 
    * za zadatog korisnika
    */
    public static function dohvati_sa_idKorisnika($id)
    {
        return ListaZelja::where('IdKorisnika', $id)->get();
    }

    /*
    * funkcija koja dohvata red u tabeli zeli
    * sa zadatim idKorisnik i idProizvod
    */
    public static function dohv($idProizvod, $idKorisnik)
    {
        return ListaZelja::where(['IdKorisnika' => $idKorisnik, 'IdProizvoda' => $idProizvod])->get();
    }

    /*
    * funkcija koja menja polje za obavestavanje o dostupnosti
    */
    public static function azuriraj_polje($idProizvod, $idKorisnik, $polje)
    {
        return ListaZelja::where(['IdKorisnika' => $idKorisnik, 'IdProizvoda' => $idProizvod])->update(['Obavesti' => $polje]);
    }

    /*
    * funkcija koja brise red u tabeli zeli
    * sa zadatim idKorisnik i idProizvod
    */
    public static function obrisi($idProizvod, $idKorisnik)
    {
        return ListaZelja::where('IdKorisnika', $idKorisnik)->where('IdProizvoda', $idProizvod)->delete();
    }
}
