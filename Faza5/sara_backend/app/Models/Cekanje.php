<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa Cekanje predstavlja tabelu odobravanje iz baze podataka.
 * Pored polja iz baze sadrzi i funkcije za dohvatanje svih korisnika koji cekaju odobravanje,
 * za dohvatanje korisnika sa zadatim ID i za brisanje korisnika sa zadatim ID
 */
class Cekanje extends Model
{
    use HasFactory;

    protected $table='odobravanje';
    protected $primaryKey="ID";
    protected $fillable=[
        'Username','Password','ImeIPrezime','Email','Pol','Potroseno','Datum'
    ];

    /**
     * Staticki metod dohv_sve vraca sve korisnike koji cekaju odobravanje naloga
     */
    public static function dohv_sve(){
        return Cekanje::all();
    }
    /**
     * Staticki metod dohv_sa_id dohvata korisnika sa zadatom vrednoscu ID
     */
    public static function dohvati_sa_id($id){
        return Cekanje::where("ID",$id)->get();
    }
    /**
     * Staticki metod obrisi_sa_id brise korisinika sa zadatom vrednoscu ID iz tabele
     * za odobravanje
     */
    public static function obrisi_sa_id($id){
       return Cekanje::where('ID',$id)->delete();
    }

    
}
