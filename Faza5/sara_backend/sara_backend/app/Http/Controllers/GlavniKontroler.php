<?php

namespace App\Http\Controllers;

use App\Models\Korisnik;
use App\Models\Odobravanje;
use App\Models\Proizvod;
use Illuminate\Http\Request;
/*
 * GlavniKontroler je klasa izvedena iz Controller klase, zaduzena za opstu kontrolu sistema
 * Metod je zaduzen za registraciju novih korisnika 
 */
class GlavniKontroler extends Controller
{
    // Metod register_user prima Request iz post zahteva i vraca status o uspesnosti registracije
    function register_user(Request $request){
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
    public function login_submit(Request $request){
        $this->validate(
            $request,[
                'Username' => 'required',
                'Password' => 'required'
            ],[
                'required' => 'Polje :attribute je obavezno'
            ]
        );

        if (!auth()->attempt($request->only('Username','Password'))){       
               return response()->json([
                'success'=>false,
            ]);           
         } 

        return auth()->user();
    }

    /* funkcija koja odjavljuje korisnika,
       moderatora ili admina
    */
    public function logout()
    {
        auth()->logout();
        
    }

    public function filter(Request $request){
        return Proizvod::filter($request->json()->all());
    }
}
