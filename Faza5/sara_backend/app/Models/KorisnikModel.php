<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class KorisnikModel extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
 
    protected $table='korisnik';
    protected $primaryKey='ID';
    public $timestamps=false;

    protected $fillable = [
        'ID', 'Username', 'Password', 'ImeIPrezime', 'Email', 'Pol', 'Potroseno', 'Datum', 'Tip'
    ];
    
    public function getAuthPassword(){
        return $this->Password;
    }

    public static function dohvati_sa_id($id){
        return KorisnikModel::where('ID',$id)->get();
    }
}
