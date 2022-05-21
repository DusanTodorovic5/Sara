<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

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

    static function add_new($data) {
        if (!KorisnikModel::checkUsername($data["Username"]) || !OdobravanjeModel::checkUsername($data["Username"])){
            return response()->json([
                "Status" => false,
                "Message" => "Korisnicko ime vec postoji"
            ]);
        }

        if (!KorisnikModel::checkEmail($data["Email"]) || !OdobravanjeModel::checkEmail($data["Email"])){
            return response()->json([
                "Status" => false,
                "Message" => "Email vec postoji"
            ]);
        }

        $odobravanjeModel = new OdobravanjeModel;
        $odobravanjeModel->Username = $data["Username"];
        $odobravanjeModel->Password = $data["Password"];
        $odobravanjeModel->ImeIPrezime = $data["ImeIPrezime"];
        $odobravanjeModel->Email = $data["Email"];
        $odobravanjeModel->Pol = $data["Pol"];
        $odobravanjeModel->Potroseno = 0;
        $odobravanjeModel->Datum = $data["Datum"];

        $success = $odobravanjeModel->save();
        if ($success) {
            return response()->json([
                "Status" => true,
                "Message" => "Uspesno registrovani, sacekajte da vas admin prihvati"
            ]);
        }
        return response()->json([
            "Status" => false,
            "Message" => "Internal error"
        ]);

    }

    static function checkEmail($email) {
        return OdobravanjeModel::where("Email", $email)->get()->isEmpty();
    }

    static function checkUsername($username) {
        return OdobravanjeModel::where("Username", $username)->get()->isEmpty();
    }
}
