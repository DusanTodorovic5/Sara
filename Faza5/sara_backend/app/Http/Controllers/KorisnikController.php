<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cekanje;
use App\Models\Korisnik;
use App\Models\Proizvod;
use App\Models\Komentar;
use Carbon\Carbon;

class KorisnikController extends Controller
{
    public function dodaj_recenziju(Request $request){
        // dd($request);
         $recenzija=new Komentar;
           $recenzija->Text=$request->Text;
           $recenzija->Datum=Carbon::now()->format("Y-m-d");
           $recenzija->IDKorisnik=3;//session('korisnik') treba da bude
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
