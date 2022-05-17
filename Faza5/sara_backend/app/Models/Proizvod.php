<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Proizvod extends Model
{
    use HasFactory;

    protected $table='proizvod';
    protected $primaryKey='ID';
    public $timestamps=false;
    protected $fillable=[
        'Naziv','Opis','Putanja','Cena','Sezona','Tagovi','godinaOd','godinaDo'
    ];

    public static function dohvatiSaId($id){
        return Proizvod::where('ID',$id)->get();
    }
}
