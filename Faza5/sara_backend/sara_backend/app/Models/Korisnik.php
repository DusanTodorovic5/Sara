<?php

//Ana Maksimovic 0174/2019
//Dusan Todorovic 0393/2019
namespace App\Models;

use Carbon\Carbon;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

/*
 * Klasa Korisnik predstavlja model Korisnika
 * iz baze, ovo je izmenjena User klasa
 * iz originalnog koda.
 * Pored polja iz tabele ova klasa sadrzi
 * pomocne metode 'check_email', 
 * 'check_username', 'dohvati_sve' i 'dohv_sa_id'.
 */

class Korisnik extends Authenticatable
{
    use  HasFactory, Notifiable;

    protected $table = 'korisnik';
    protected $primaryKey = 'ID';
    public $timestamps = false;

    protected $fillable = [
        'ID', 'Username', 'Password', 'ImeIPrezime', 'Email', 'Pol', 'Potroseno', 'Datum', 'Tip'
    ];

    public function getAuthPassword()
    {
        return $this->Password;
    }

    // Metod vraca true u slucaju da ne postoji dati email
    static function check_email($email)
    {
        // where query->get() vraca listu korisnika sa zadatim emailom, isEmpty vraca true ako je lista prazna
        return Korisnik::where("Email", $email)->get()->isEmpty();
    }
    // Metod vraca true u slucaju da ne postoji dati username
    static function check_username($username)
    {
        // where query->get() vraca listu korisnika sa zadatim usernamom, isEmpty vraca true ako je lista prazna
        return Korisnik::where("Username", $username)->get()->isEmpty();
    }

    static function dohvati_godine_static($username)
    {
        return Korisnik::where("Username", $username)->get()->first()->dohvati_godine();
    }

    //Staticki metod dohvati_sve sluzi nam za dohvatanje svih korisnika iz baze podataka. 
    public static function dohvati_sve()
    {
        return Korisnik::all();
    }

    //Staticki metod dohvati_sa_id sluzi nam za dohvatanje korisnika sa zadatim ID.
    public static function dohv_sa_id($id)
    {
        return Korisnik::where('ID', $id)->get();
    }
    // Usluzni metod za dohvatanje starosti Korisnika
    public function dohvati_godine()
    {
        return Carbon::now()->year - (new Carbon($this->Datum))->year;
    }
}
