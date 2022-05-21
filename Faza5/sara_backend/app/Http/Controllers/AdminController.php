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
        $pending=Cekanje::dohv_sve();
        return $pending;
     }

     public function dohv_korisnike(){
         $korisnici =Korisnik::dohvati_sve();
         return $korisnici;
     }

     public function moderatori(Request $request){
        $korisnik=Korisnik::dohv_sa_id($request->id)[0];
        if($korisnik->Tip=='K')$korisnik->Tip='M';
        else $korisnik->Tip='K';
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


    public function prihvati_kor(Request $request){
        $korisnik=Cekanje::dohvati_sa_id($request->id)[0];
        Cekanje::obrisi_sa_id($request->id);       
      
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

    public function odbij_kor(Request $request){
        $success=Cekanje::obrisi_sa_id($request->id);
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
