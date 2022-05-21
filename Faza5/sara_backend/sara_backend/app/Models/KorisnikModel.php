<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KorisnikModel extends Model
{
    use HasFactory;

    protected $table = "korisnik";
    protected $primaryKey = "ID";

    protected $fillable = [
        "ID",
        "Username",
        "Password",
        "ImeIPrezime",
        "Email",
        "Pol",
        "Potroseno",
        "Datum",
        "Tip"
    ]; 

    static function checkEmail($email) {
        return KorisnikModel::where("Email", $email)->get()->isEmpty();
    }

    static function checkUsername($username) {
        return KorisnikModel::where("Username", $username)->get()->isEmpty();
    }
}
