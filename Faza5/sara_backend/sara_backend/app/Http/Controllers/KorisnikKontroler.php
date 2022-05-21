<?php

namespace App\Http\Controllers;

use App\Models\Komentar;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Carbon\Carbon;

/**
 * Klasa Korisnik kontroler nam sluzi za radnje koje ce izvrsavati
 * registrovani korisnik sistema.
 */
class KorisnikKontroler extends Controller
{
    // Metod dodaj_recenziju nam sluzi za dodavanje recenzije na proizvod iz zahteva
    public function dodaj_recenziju(Request $request){
        
         $recenzija=new Komentar;
           $recenzija->Text=$request->Text;
           $recenzija->Datum=Carbon::now()->format("Y-m-d");
           $recenzija->IDKorisnik=1; //auth()->user()->ID
           $recenzija->IDProizvod=$request->IDProizvod;
           $success=$recenzija->save();
           if($success){
            return response()->json([
                'success'=>true,
                'reason'=>'Uspesno dodavanje recenzije!'
            ]);
        }else{
            return response()->json([
                'success'=>false,
                'reason'=>'Greska pri dodavanju recenzije!'
            ]);
        }
        }
}
