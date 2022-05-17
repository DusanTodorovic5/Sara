<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;


use App\Models\Cekanje;
use App\Models\Korisnik;
use App\Models\Proizvod;
use App\Models\Komentar;
use Carbon\Carbon;

class AdminController extends Controller
{
    public function pending(){
        $pending=Cekanje::dohvSve();
        return $pending;
     }

     public function dodaj_moderatora($id){
        $korisnik=Korisnik::dohvSaId($id)[0];
        $korisnik->Tip='M';
        $success=$korisnik->save();
        if($success){
            return response()->json([
                'success'=>true,
                'reason'=>'Uspesno postavljanje moderatora!'
            ]);
        }else{
            return response()->json([
                'success'=>false,
                'reason'=>'Greska pri postavljanju moderatora!'
            ]);
        }
    }

    public function prihvati_kor($id){
        $korisnik=Cekanje::dohvatiSaId($id)[0];
        Cekanje::obrisiSaId($id);       
      
        $user=new Korisnik;

        $user->Username=$korisnik->Username;
        $user->Password=$korisnik->Password;
        $user->ImeIPrezime=$korisnik->ImeIPrezime;
        $user->Tip='K';
        $user->Pol=$korisnik->Pol;
        $user->Datum=$korisnik->Datum;
        $user->Email=$korisnik->Email;
        $user->Potroseno=$korisnik->Potroseno;
        $success=$user->save();
      
        if($success){
            return response()->json([
                'success'=>true,
                'reason'=>'Uspesno prihvatanje korisnika!'
            ]);
        }else{
            return response()->json([
                'success'=>false,
                'reason'=>'Greska pri prihvatanju korisnika!'
            ]);
        }

    }

    public function odbij_kor($id){
        $success=Cekanje::obrisiSaId($id);
        if($success){
         return response()->json([
             'success'=>true,
             'reason'=>'Uspesno odbijanje korisnika!'
         ]);
     }else{
         return response()->json([
             'success'=>false,
             'reason'=>'Greska pri odbijanju korisnika!'
         ]);
     }
     }
}
