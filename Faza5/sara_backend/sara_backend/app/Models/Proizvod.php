<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
/**
 * Klasa Proizvod predstavlja model Proizvoda iz baze podataka;
 */
class Proizvod extends Model
{
    use HasFactory;

    protected $table='proizvod';
    protected $primaryKey='ID';
    public $timestamps=false;
    protected $fillable=[
        'Naziv',
        'Opis',
        'Putanja',
        'Cena',
        'Sezona',
        'Tagovi',
        'godinaOd',
        'godinaDo',
        'Pol'
    ];
    
    //Staticki metod dohvati_sa_id vraca proizvod iz baze sa zadatim ID
    public static function dohvati_sa_id($id){
        return Proizvod::where('ID',$id)->get();
    }

    /*
     * Staticki metod koji filtrrira proizvode po zadatom argumentu
     */
    public static function filter($arguments){
        $cena_od = $arguments['Cena'][0];
        $cena_do = $arguments['Cena'][1];

        $kategorije = $arguments['Kategorija'];

        $polovi = $arguments['Pol'];

        $tekst = $arguments['Tekst'];
        // Filtrira proizvod po ceni
        $filter = Proizvod::where(function ($query) use ($cena_od, $cena_do) {
            $query->where('Cena', '>=', $cena_od);
            $query->where('Cena', '<=', $cena_do);
        });
        // Ako su selektovane neke kategorije, filtrira i po kategorijama
        if (count($kategorije) > 0){
            $filter = $filter->where(function ($query) use ($kategorije){
                foreach ($kategorije as $kategorija){
                    $query->orWhereRaw('Tagovi like "%'.$kategorija.'%"');
                }
            });
        }
        // Ako je izabran odredjeni pol, filtrira i po polu
        if (count($polovi) == 1){
            $filter = $filter->where('Pol', $polovi[0]);
        }
        // U slucaju da je ukucan neki tekst, on ce filtrirati i po tekstu
        if ($tekst != null){
            $filter = $filter->whereRaw('Naziv like "%'.$tekst.'%"');
        }
        // Vraca json niz filtriranih proizvoda
        return $filter->get();
    }
}
