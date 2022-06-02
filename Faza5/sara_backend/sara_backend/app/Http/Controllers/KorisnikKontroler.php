<?php

namespace App\Http\Controllers;


use App\Models\Komentar;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Korisnik;
use App\Models\Adresa;
use App\Models\Proizvod;
use App\Models\Kartica;
use App\Models\ListaZelja;
use App\Models\Porudzbina;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Mail;



/**
 * Klasa Korisnik kontroler nam sluzi za radnje koje ce izvrsavati
 * registrovani korisnik sistema.
 */
class KorisnikKontroler extends Controller
{
    // Metod dodaj_recenziju nam sluzi za dodavanje recenzije na proizvod iz zahteva
    public function dodaj_recenziju(Request $request)
    {

        $recenzija = new Komentar;
        $recenzija->Text = $request->Text;
        $recenzija->Datum = Carbon::now()->format("Y-m-d");
        $recenzija->IDKorisnik = 1; //auth()->user()->ID
        $recenzija->IDProizvod = $request->IDProizvod;
        $success = $recenzija->save();
        if ($success) {
            return response()->json([
                'success' => true,
                'reason' => 'Uspesno dodavanje recenzije!'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'reason' => 'Greska pri dodavanju recenzije!'
            ]);
        }
    }

    // Metod dodaj_u_listu_zelja nam sluzi za dodavanje proizvoda u listu zelja
    public function dodaj_u_listu_zelja(Request $request)
    {

        if (Auth::check()) {
            $id_korisnika = auth()->user()->id;
            $proizvod = Proizvod::dohv_sa_id($request->id)[0];
            $success = DB::table('zeli')->insert(['IdKorisnika' => $id_korisnika, 'IdProizvoda' => $request->id]);
            if ($success) {
                return response()->json([
                    'success' => true,
                    'reason' => 'Uspesno dodavanje u listu zelja!'
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'reason' => 'Greska pri dodavanju u listu zelja!'
                ]);
            }
        } else return response()->json([
            'success' => false,
            'reason' => 'Korisnik nije ulogovan!'
        ]);
    }

    //Metod koji vraca sve proizvode iz baze
    function dohvati_sve_proizvode()
    {
        return Proizvod::all();
    }

    public function napraviAdresu(Request $request)
    {
        $adresa = new Adresa();
        $adresa->IdKorisnik = (int)$request->idKor;
        $adresa->Mesto = $request->adresa['Mesto'];
        $adresa->PostanskiBroj = (int)$request->adresa['PostanskiBroj'];
        $adresa->Ulica = $request->adresa['Ulica'];
        $adresa->Broj = (int)$request->adresa['Broj'];
        if ($request->adresa['Sprat'] != "") $adresa->Sprat = (int)$request->adresa['Sprat'];
        if ($request->adresa['BrojStana'] != "") $adresa->Sprat = (int)$request->adresa['BrojStana'];
        $adresa->save();
        return $adresa->ID;
    }

    public function napraviKarticu(Request $request)
    {

        $kartica = new Kartica();
        $kartica->Broj = $request->kartica["BrojKartice"];
        $kartica->CSV = (int)$request->kartica["CSV"];
        $kartica->DatumIsteka = Carbon::createFromFormat('Y-m-d', $request->kartica['DatumIsteka']);
        $kartica->idKorisnik = (int)($request->idKor);
        $kartica->save();

        return $kartica->ID;
    }

    public function dohvati_podatke(Request $request)
    {
        $kartica = Kartica::dohv_za_korisnika($request->id)->first();
        $adresa = Adresa::dohv_za_korisnika($request->id)->first();
        $kor = DB::table('Korisnik')->where('ID', $request->id)->first();
        if ($kor == null) $ime = null;
        else $ime = $kor->ImeIPrezime;
        $ret = [
            'ime' => $ime,
            'adresa' => $adresa,
            'kartica' => $kartica
        ];
        return $ret;
    }
}
