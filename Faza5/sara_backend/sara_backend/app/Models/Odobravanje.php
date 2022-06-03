<?php
//Dusan Todorovic 0393/2019
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
/*
 * Klasa Odobravanje predstavlja tabelu odobravanje iz baze podataka. Pored polja tabela
 * ova klasa sadrzi pomocne metode check_username i check_password,funkcije za dohvatanje svih korisnika koji cekaju odobravanje,
 * za dohvatanje korisnika sa zadatim ID i za brisanje korisnika sa zadatim ID
 * 
 * Ovaj model je zaduzen za funkcionalnost registrovanja.
 */

class Odobravanje extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $table = "odobravanje";
    protected $primaryKey = "ID";
    protected $fillable = [
        "ID",
        "Username",
        "Password",
        "ImeIPrezime",
        "Email",
        "Pol",
        "Potroseno",
        "Datum"
    ];
    /*
     * Statican metod add_new prima kao parametar telo zahteva za registraciju, proverava da li su email i username zauzeti
     * i u slucaju da jesu vraca false kao"success sa odgovarajucom porukom
     */
    static function add_new($data)
    {
        // Proverava da li postoji zadati username u tabeli korisnik ili tabeli odobravanje
        if (!Korisnik::check_username($data["Username"]) || !Odobravanje::check_username($data["Username"])) {
            return response()->json([
                "success" => false,
                "reason" => "Korisnicko ime vec postoji"
            ]);
        }
        // Proverava da li postoji zadati email u tabeli korisnik ili tabeli odobravanje
        if (!Korisnik::check_email($data["Email"]) || !Odobravanje::check_email($data["Email"])) {
            return response()->json([
                "success" => false,
                "reason" => "Email vec postoji"
            ]);
        }
        // Postavlja odgovarajuca polja u klasi Odobravanje
        $Odobravanje = new Odobravanje;
        $Odobravanje->Username = $data["Username"];
        $Odobravanje->Password = $data["Password"];
        $Odobravanje->ImeIPrezime = $data["ImeIPrezime"];
        $Odobravanje->Email = $data["Email"];
        $Odobravanje->Pol = $data["Pol"];
        // Za polje Potroseno se postavlja podrazumevana vrednost od 0
        $Odobravanje->Potroseno = 0;
        // Podrazumeva se da sam zahtev vraca datum u formatu Y-M-D
        $Odobravanje->Datum = $data["Datum"];
        // Radimo inser u tabeli odobravanje
        $success = $Odobravanje->save();
        // U slucaju da je insert bio uspesan, metoda save() vraca objekat, samim tim metod vraca poruku o uspesnosti
        if ($success) {
            return response()->json([
                "success" => true,
                "reason" => "Uspesno registrovani, sacekajte da vas admin prihvati"
            ]);
        }
        // U ostalim slucajevima se vraca ne definisana greska
        return response()->json([
            "success" => false,
            "reason" => "Internal error"
        ]);
    }
    // Metod vraca true u slucaju da ne postoji dati email
    static function check_email($email)
    {
        // where query->get() vraca listu neodobrenih korisnika sa zadatim emailom, isEmpty vraca true ako je lista prazna
        return Odobravanje::where("Email", $email)->get()->isEmpty();
    }
    // Metod vraca true u slucaju da ne postoji dati username
    static function check_username($username)
    {
        // where query->get() vraca listu neodobrenih korisnika sa zadatim usernamom, isEmpty vraca true ako je lista prazna
        return Odobravanje::where("Username", $username)->get()->isEmpty();
    }



    //Staticki metod dohv_sve vraca sve korisnike koji cekaju odobravanje naloga
    public static function dohv_sve()
    {
        return Odobravanje::all();
    }

    //Staticki metod dohv_sa_id dohvata korisnika sa zadatom vrednoscu ID
    public static function dohvati_sa_id($id)
    {
        return Odobravanje::where("ID", $id)->get();
    }

    /**
     * Staticki metod obrisi_sa_id brise korisinika sa zadatom vrednoscu ID iz tabele
     * za odobravanje
     */
    public static function obrisi_sa_id($id)
    {
        return Odobravanje::where('ID', $id)->delete();
    }
}
