<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Proizvod;
use Illuminate\Http\Request;

/**
 * Klasa ModeratorKontroler nam sluzi za moderiranje sistema 
 * u vidu kreiranja popusta, brisanja neprikladnih recenzija i slicnih stvari
 */
class ModeratorKontroler extends Controller
{ 
    // Metoda dodaj_popust dodaje popust na artikal koji smo prosledili kroz telo zahteva
    public function dodaj_popust(Request $request){
    $proizvod=Proizvod::dohvati_sa_id($request->id)[0];
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
