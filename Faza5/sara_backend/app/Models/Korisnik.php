<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Klasa Korisnik predstavlja tableu korisnika iz baze podataka.
 * Pored polja iz baze, sadrzi funkcije za dohvatanje svih korisnika i 
 * za dohvatanje korisnika sa zadatim ID
 */
class Korisnik extends Model
{
    use HasFactory;

    protected $table='korisnik';
    protected $primaryKey='ID';
    
    protected $fillable=[
        'Username','Password','ImeIPrezime','Email','Pol','Potroseno','Datum','Tip'
    ];

    /**
     * Staticki metod dohvati_sve sluzi nam za dohvatanje svih korisnika iz baze podataka.
     */
    public static function dohvati_sve(){
        return Korisnik::all();
    }
    /**
     * Staticki metod dohvati_sa_id sluzi nam za dohvatanje korisnika sa zadatim ID.
     */
    public static function dohv_sa_id($id){
        return Korisnik::where('ID',$id)->get();
    }
}
