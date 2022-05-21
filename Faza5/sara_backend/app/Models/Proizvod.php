<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
/**
 * Klasa Proizvod predstavlja tabelu proizvoda iz baze podataka.
 * Pored polja iz baze sadrzi i funkciju za dohvatanje proizvoda sa zadatim ID
 */

class Proizvod extends Model
{
    use HasFactory;

    protected $table='proizvod';
    protected $primaryKey='ID';
    public $timestamps=false;
    protected $fillable=[
        'Naziv','Opis','Putanja','Cena','Sezona','Tagovi','godinaOd','godinaDo'
    ];
    /**
     * Staticki metod dohvati_sa_id vraca proizvod iz baze sa zadatim ID
     */
    public static function dohvati_sa_id($id){
        return Proizvod::where('ID',$id)->get();
    }
}
