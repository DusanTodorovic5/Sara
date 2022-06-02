<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use \Illuminate\Support\Facades\File;

use App\Models\Odobravanje;
use App\Models\Korisnik;
use App\Models\Proizvod;
use App\Models\Komentar;
use Carbon\Carbon;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Mail;
use Mailgun\Mailgun;

/**
 * Klasa AdminKontroler nam sluzi za administriranje sistema.
 * Sadrzi metode pending, dohv_korisnike, moderatori, prihvati_kor, odbij_kor, dodaj_proizvod
 */
class AdminKontroler extends Controller
{
    //Metod pending vraca sve korisnike koji cekaju odobravanje
    public function pending()
    {
        $pending = Odobravanje::dohv_sve();
        return $pending;
    }

    //metod dohv_korisnike vraca sve korisnike aplikacije
    public function dohv_korisnike()
    {
        $korisnici = Korisnik::dohvati_sve();
        return $korisnici;
    }

    //Metod moderatori postavlja odosno uklanja moderatorska prava pristupa
    public function moderatori(Request $request)
    {
        $korisnik = Korisnik::dohv_sa_id($request->id)[0];
        if ($korisnik->Tip == 'K') $korisnik->Tip = 'M';
        else $korisnik->Tip = 'K';
        $success = $korisnik->save();
        if ($success) {
            return response()->json([
                'success' => true,
                'reason' => 'Uspesno postavljanje moderatora!'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'reason' => 'Greska pri postavljanju moderatora!'
            ]);
        }
    }

    public static function basic_email($id)
    {
        # Instantiate the client.
        $mgClient = Mailgun::create('beac00b6650ac2258f09bcaf77983990-27a562f9-fc7afaae');
        $domain = "sandboxd909a5f41027416ba771aa99af73d064.mailgun.org";

        # Make the call to the client.
        $result = $mgClient->messages()->send(
            "$domain",
            array(
                'from'    => 'Mailgun Sandbox <postmaster@sandboxd909a5f41027416ba771aa99af73d064.mailgun.org>',
                'to'      => 'Sara PSI <dukestudios5@gmail.com>',
                'subject' => 'Sara PSI',
                'text'    => 'Mozete pogledati produkt na linku : http://localhost:5555/proizvod?id=' . $id
            )
        );
        dd($result);
    }
    //Metod prihvati_kor dodaje korisnika u bazu
    public function prihvati_kor(Request $request)
    {
        $korisnik = Odobravanje::dohvati_sa_id($request->id)[0];
        Odobravanje::obrisi_sa_id($request->id);

        $user = new Korisnik;

        $user->Username = $korisnik->Username;
        $user->Password = $korisnik->Password;
        $user->ImeIPrezime = $korisnik->ImeIPrezime;
        $user->Tip = 'K';
        $user->Pol = $korisnik->Pol;
        $user->Datum = $korisnik->Datum;
        $user->Email = $korisnik->Email;
        $user->Potroseno = $korisnik->Potroseno;
        $success = $user->save();

        if ($success) {
            return response()->json([
                'success' => true,
                'reason' => 'Uspesno prihvatanje korisnika!'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'reason' => 'Greska pri prihvatanju korisnika!'
            ]);
        }
    }

    // Metod odbij_kor uklanja korisnika iz tabele za odobravanje 
    public function odbij_kor(Request $request)
    {
        $success = Odobravanje::obrisi_sa_id($request->id);
        if ($success) {
            return response()->json([
                'success' => true,
                'reason' => 'Uspesno odbijanje korisnika!'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'reason' => 'Greska pri odbijanju korisnika!'
            ]);
        }
    }
}
