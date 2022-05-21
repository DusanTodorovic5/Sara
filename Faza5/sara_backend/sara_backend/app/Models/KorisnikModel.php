<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
/*
 * Klasa predstavlja model Korisnika u bazi podataka. Pored polja iz tabele ova klasa sadrzi 
 * pomocne metode 'checkEmail' i 'checkUsername'.
 */ 
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
    // Metod vraca true u slucaju da ne postoji dati email
    static function checkEmail($email) {
        // where query->get() vraca listu korisnika sa zadatim emailom, isEmpty vraca true ako je lista prazna
        return KorisnikModel::where("Email", $email)->get()->isEmpty();
    }
    // Metod vraca true u slucaju da ne postoji dati username
    static function checkUsername($username) {
        // where query->get() vraca listu korisnika sa zadatim usernamom, isEmpty vraca true ako je lista prazna
        return KorisnikModel::where("Username", $username)->get()->isEmpty();
    }
}
