<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Cekanje extends Model
{
    use HasFactory;

    protected $table='odobravanje';
    protected $primaryKey="ID";
    protected $fillable=[
        'Username','Password','ImeIPrezime','Email','Pol','Potroseno','Datum'
    ];


    public static function dohvSve(){
        return Cekanje::all();
    }
    public static function dohvatiSaId($id){
        return Cekanje::where("ID",$id)->get();
    }
    public static function obrisiSaId($id){
       return Cekanje::where('ID',$id)->delete();
    }

    
}
