<?php

namespace App\Http\Controllers;

use App\Weather\WeatherApi;
use App\Models\Korisnik;
use App\Models\Odobravanje;
use App\Models\Proizvod;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

/*
 * GlavniKontroler je klasa izvedena iz Controller klase, zaduzena za opstu kontrolu sistema
 * Metod je zaduzen za registraciju novih korisnika 
 */

class GlavniKontroler extends Controller
{
    // Metod register_user prima Request iz post zahteva i vraca status o uspesnosti registracije
    function register_user(Request $request)
    {
        // Metod json()->all() vraca listu parametara json objekta koji je poslat kao telo zahteva
        $body = $request->json()->all();
        /*
         * Poziv staticne metode add_new sa parametrom tela zahteva vraca odgovor o uspesnosti
         * registraciju u json obliku koji odmah mozemo proslediti dalje
         */
        return Odobravanje::add_new($body);
    }

    /* 
    * funkcija koja vraca sve podatke o korisniku 
    * ukoliko je logovanje bilo uspesno, u suprotnom
    * vraca false
    */
    public function login_submit(Request $request)
    {
        /*
        proba
        */
        if (!auth()->attempt($request->only('Username', 'Password'))) {
            return response()->json([
                'success' => false,
            ]);
        }

        return response()->json([
            'success' => true,
            'korisnik' => auth()->user()
        ]);
    }

    /* funkcija koja odjavljuje korisnika,
       moderatora ili admina
    */
    public function logout()
    {
        auth()->logout();
    }
    /*
     * Metod filtera koji se prosledjuje proizvodu, prima kao argument zahtev 
     * i prosledjuje telo zahteva proizvodu
     */
    public function filter(Request $request)
    {
        return Proizvod::filter($request->json()->all());
    }
    /*
     * Metod koji preporucuje proizvode korisniku
     * Dohvata vremensku prognozu za naredna WeatherApi::tacnost dana i 
     * Trazi srednju vrednost, te generise godisnje doba u zavisnosti od
     * vremenske prognoze. Takodje, ako je korisnik prijavljen
     * ova metoda filtrira proizvode po njegovom polu i uzrastu
     * 
     * U slucaju da metoda ne nadje odgovarajuce proizvode, vraca nasumicnih 6 elemenata iz tabele proizvoda
     */
    public function preporuka($lat, $long)
    {
        // Dohvata vreme sa API-ka
        $vreme = WeatherApi::get_weather($lat, $long);
        // Generise godisnje doba u zavisnosti od vremenskih uslova
        $doba = "Prolece";
        if (($vreme[0] == "Mestimicno Oblacno" || $vreme[0] == "Vedro") &&
            $vreme[1] == "Suvo" && $vreme[2] == "Toplo"
        ) {
            $doba = "Leto";
        } else if (($vreme[0] == "Mestimicno Oblacno" || $vreme[0] == "Vedro") &&
            ($vreme[1] == "Suvo") && $vreme[2] == "Normalno"
        ) {
            $doba = "Prolece";
        } else if (($vreme[0] == "Mestimicno Oblacno" || $vreme[0] == "Oblacno") &&
            ($vreme[1] == "Pljusak" || $vreme[1] == "Kisa") && $vreme[2] == "Normalno"
        ) {
            $doba = "Jesen";
        } else if (($vreme[0] == "Mestimicno Oblacno") || ($vreme[0] == "Oblacno") && $vreme[2] == "Hladno") {
            $doba = "Zima";
        }
        /*
         * Dohvata sve proizvode koji u svom tagu imaju to godisnje doba
         * Ne treba pomesati sa Sezona, koja moze biti Leto 2022 ili Leto 2021 i 
         * oznacava da je tada izasla kolekcija a ne da se nosi u tom godisnjem dobu
         */
        $query = Proizvod::whereRaw('Tagovi like "%' . $doba . '%"');
        // Ako je korisnik prijavljen, filtrirace po njegovom kriterijumu
        if (Auth::check()) {
            $kor = Korisnik::dohv_sa_id(Auth::user()->id);

            $godine = $kor->dohvati_godine();

            $query = $query->whereRaw('godinaOd <= ' . $godine . ' AND godinaDo >=' . $godine);
            $pol = 'M';
            if ($kor->Pol == 'M') {
                $pol = 'Z';
            }
            $query = $query->where('Pol', '<>', $pol);
        }
        // Dohvata upit
        $result = $query->get();
        // Ako je upit prazan, nacice 6 nasumicnih proizvoda
        if (count($result) < 1) {
            $result = Proizvod::all()->array;
            shuffle($result);
            $result = array_slice($result, 0, 6);
        }
        // Vraca json niz preporucenih proizvoda
        return $result;
    }
}
