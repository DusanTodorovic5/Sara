<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KomentarModel extends Model
{
    use HasFactory;

    protected $table='komentar';
    protected $primaryKey='ID';
    public $timestamps=false;

    protected $fillable=[
        'ID','Text','Datum','IDKorisnik','IDProizvod'
    ];

     public static function dohvati_sa_id($id){
        return KomentarModel::where('ID',$id)->get();
    }
}