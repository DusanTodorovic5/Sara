<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Korisnik extends Model
{
    use HasFactory;

    protected $table='korisnik';
    protected $primaryKey='ID';
    public $timestamps=false;
    protected $fillable=[
        'Username','Password','ImeIPrezime','Email','Pol','Potroseno','Datum','Tip'
    ];


    public static function dohvatiSve(){
        return Korisnik::all();
    }
    public static function dohvSaId($id){
        return Korisnik::where('ID',$id)->get();
    }
}
