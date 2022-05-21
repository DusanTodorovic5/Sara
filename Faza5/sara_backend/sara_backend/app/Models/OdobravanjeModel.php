<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
/*
 * Klasa OdobravanjeModel predstavlja tabelu odobravanje iz baze podataka. Pored polja tabela
 * ova klasa sadrzi 2 pomocne metode checkUsername i checkPassword.
 * 
 * Ovaj model je zaduzen za funkcionalnost registrovanja.
 */
class OdobravanjeModel extends Model
{
    use HasFactory;

    protected $table = "odobravanje";
    protected $primaryKey = "ID";
    public $timestamps = false;
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
     * i u slucaju da jesu vraca false kao status sa odgovarajucom porukom
     */
    static function add_new($data) {
        // Proverava da li postoji zadati username u tabeli korisnik ili tabeli odobravanje
        if (!KorisnikModel::checkUsername($data["Username"]) || !OdobravanjeModel::checkUsername($data["Username"])){
            return response()->json([
                "Status" => false,
                "Message" => "Korisnicko ime vec postoji"
            ]);
        }
         // Proverava da li postoji zadati email u tabeli korisnik ili tabeli odobravanje
        if (!KorisnikModel::checkEmail($data["Email"]) || !OdobravanjeModel::checkEmail($data["Email"])){
            return response()->json([
                "Status" => false,
                "Message" => "Email vec postoji"
            ]);
        }
        // Postavlja odgovarajuca polja u klasi OdobravanjeModel
        $odobravanjeModel = new OdobravanjeModel;
        $odobravanjeModel->Username = $data["Username"];
        $odobravanjeModel->Password = $data["Password"];
        $odobravanjeModel->ImeIPrezime = $data["ImeIPrezime"];
        $odobravanjeModel->Email = $data["Email"];
        $odobravanjeModel->Pol = $data["Pol"];
        // Za polje Potroseno se postavlja podrazumevana vrednost od 0
        $odobravanjeModel->Potroseno = 0;
        // Podrazumeva se da sam zahtev vraca datum u formatu Y-M-D
        $odobravanjeModel->Datum = $data["Datum"];
        // Radimo inser u tabeli odobravanje
        $success = $odobravanjeModel->save();
        // U slucaju da je insert bio uspesan, metoda save() vraca objekat, samim tim metod vraca poruku o uspesnosti
        if ($success) {
            return response()->json([
                "Status" => true,
                "Message" => "Uspesno registrovani, sacekajte da vas admin prihvati"
            ]);
        }
        // U ostalim slucajevima se vraca ne definisana greska
        return response()->json([
            "Status" => false,
            "Message" => "Internal error"
        ]);

    }
    // Metod vraca true u slucaju da ne postoji dati email
    static function checkEmail($email) {
        // where query->get() vraca listu neodobrenih korisnika sa zadatim emailom, isEmpty vraca true ako je lista prazna
        return OdobravanjeModel::where("Email", $email)->get()->isEmpty();
    }
    // Metod vraca true u slucaju da ne postoji dati username
    static function checkUsername($username) {
        // where query->get() vraca listu neodobrenih korisnika sa zadatim usernamom, isEmpty vraca true ako je lista prazna
        return OdobravanjeModel::where("Username", $username)->get()->isEmpty();
    }
}
