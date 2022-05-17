<?php

namespace App\Http\Controllers;
use App\Models\Cekanje;
use App\Models\Korisnik;
use App\Models\Proizvod;
use App\Models\Komentar;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ModeratorController extends Controller
{
    public function dodaj_popust(Request $request){
        $proizvod=Proizvod::dohvatiSaId($request->id)[0];
        $proizvod->Cena=$proizvod->Cena*(100-(int)($request->popust))/100;
        $success=$proizvod->save();
        if($success){
         return response()->json([
             'success'=>true,
             'reason'=>'Uspesno kreiranje popusta!'
         ]);
     }else{
         return response()->json([
             'success'=>false,
             'reason'=>'Greska pri kreiranju popusta!'
         ]);
     }
     }
}
