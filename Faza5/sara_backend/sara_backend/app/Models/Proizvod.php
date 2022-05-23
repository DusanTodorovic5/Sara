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

    public static function filter($arguments){
        $cena_od = $arguments['Cena'][0];
        $cena_do = $arguments['Cena'][1];

        $kategorije = $arguments['Kategorija'];

        $polovi = $arguments['Pol'];

        $tekst = $arguments['Tekst'];
        
        $filter = Proizvod::where(function ($query) use ($cena_od, $cena_do) {
            $query->where('Cena', '>=', $cena_od);
            $query->where('Cena', '<=', $cena_do);
        });
        if (count($kategorije) > 0){
            $filter = $filter->where(function ($query) use ($kategorije){
                foreach ($kategorije as $kategorija){
                    $query->orWhere('Tagovi', 'like', '%', $kategorija, '%');
                }
            });
        }
        
        if (count($polovi) == 1){
            $filter = $filter->where('Pol', $polovi[0]);
        }
        if ($tekst != null){
            $filter = $filter->where('Naziv', 'like', '%', $tekst, '%');
        }
        
        return $filter->get();
    }
}

/*
    {
        Cena: [_od, _do],
        Kategorija : [kategorije],
        Pol : [polovi],
        Tekst : "tekst"
    }

*/
