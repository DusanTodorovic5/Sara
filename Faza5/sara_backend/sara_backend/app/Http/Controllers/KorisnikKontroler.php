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
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\File;

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

    // Metod dodaj_u_listu_zelja nam sluzi za dodavanje proizvoda u listu zelja
    public function dodaj_u_listu_zelja(Request $request){

        if (Auth::check())
        {
            $id_korisnika = auth()->user()->id; 
            $proizvod=Proizvod::dohv_sa_id($request->id)[0];
            $success = DB::table('zeli')->insert(['IdKorisnika' => $id_korisnika, 'IdProizvoda' => $request->id]);
            if($success){
                return response()->json([
                    'success'=>true,
                    'reason'=>'Uspesno dodavanje u listu zelja!'
                ]);
            }else{
                return response()->json([
                    'success'=>false,
                    'reason'=>'Greska pri dodavanju u listu zelja!'
                ]);
            }    
        } else return response()->json([
            'success'=>false,
            'reason'=>'Korisnik nije ulogovan!'
        ]);
    }

    //Metod kupi_proizvod nam sluzi za pravljnje Porudzbine i pamcenje svih detalja kupovine u tabeli Sadrzi
    public function kupi_proizvod(Request $request){

        //dohvatanje podataka o korisniku
        $id_korisnika = auth()->user()->id; 
        $korisnik=Korisnik::dohv_sa_id($id_korisnika)[0];
        //dohvatanje podataka o adresi
        $adresa = json_decode(json_encode($request->adresa),true); 
        $ulica = $adresa[0]["Ulica"];
        $broj = $adresa[0]["Broj"];
        $sprat = $adresa[0]["Sprat"];
        $broj_stana = $adresa[0]["BrojStana"];
        $postanski_broj = $adresa[0]["PostanskiBroj"];
        $mesto = $adresa[0]["Mesto"];
        //provera da li postoji adresa
        $postoji = Adresa::proveri_da_li_postoji($ulica, $broj, $sprat, $broj_stana, $postanski_broj, $mesto, $id_korisnika);
        //ukoliko postoji samo dohvatimo id
        if(!$postoji->isEmpty()){
            $id_adresa = $postoji[0]->ID;
        } else { //ukoliko ne postoji dodam u tabelu Adresa i vratim id
            $nova_adresa = new Adresa();
            $nova_adresa->Ulica=$ulica;
            $nova_adresa->Broj=$broj;
            $nova_adresa->Sprat=$sprat;
            $nova_adresa->BrojStana=$broj_stana;
            $nova_adresa->PostanskiBroj=$postanski_broj;
            $nova_adresa->Mesto=$mesto;
            $nova_adresa->IdKorisnik=$id_korisnika;
            $success=$nova_adresa->save();
            $postoji = Adresa::proveri_da_li_postoji($ulica, $broj, $sprat, $broj_stana, $postanski_broj, $mesto, $id_korisnika);
            if(!$postoji->isEmpty()){
                $id_adresa = $postoji[0]->ID;
            } else {
                dd("greska");
            }
        }
        //provera da li se placanje obavlja karticom
        $placanje = $request->placanje;
        //ukoliko je nacin placanja karticom proverim da li postoji u tabeli Kartica, ukoliko ne postoji dodam u tabelu Kartica i vracam id
        if($placanje == "kartica"){  
            $kartica = json_decode(json_encode($request->kartica),true); 
            $broj_kartice = $kartica[0]["BrojKartice"];
            $csv = $kartica[0]["CSV"];
            $datum_isteka = $kartica[0]["DatumIsteka"];
            $postoji = Kartica::dohv_sa_id($id_korisnika);
            if(!$postoji->isEmpty()){
                $id_kartica = $postoji[0]->ID;
            } else {
                $nova_kartica = new Kartica();
                $nova_kartica->idKorisnik=$id_korisnika;
                $nova_kartica->Broj=$broj_kartice;
                $nova_kartica->CSV=$csv;
                $nova_kartica->DatumIsteka=$datum_isteka;
                $success=$nova_kartica->save();
                $postoji = Kartica::dohv_sa_id($id_korisnika);
                if(!$postoji->isEmpty()){
                    $id_kartica = $postoji[0]->ID;
                } else {
                    dd("greska");
                }
            }
            //provera da li postoji u tabeli Porudzbina 
            $postoji = DB::table('porudzbina')->where([['IDAdresa', '=', $id_adresa],['IDKartica', '=', $id_kartica]])->get();
            //ukoliko postoji vratim id
            if(!$postoji->isEmpty()){
                $id_porudzbine = $postoji[0]->ID;
            } else { //ukoliko ne postoji napravim novu Porudzbinu i vratim id
                $success = DB::table('porudzbina')->insert(['IDAdresa' => $id_adresa, 'IDKartica' => $id_kartica]);
                $postoji = DB::table('porudzbina')->where([['IDAdresa', '=', $id_adresa],['IDKartica', '=', $id_kartica]])->get(); 
                $id_porudzbine = $postoji[0]->ID;    
            }
        } else { //ukoliko se ne placa karticom
            //provera da li postoji u tabeli Porudzbina 
            $postoji = DB::table('porudzbina')->where([['IDAdresa', '=', $id_adresa],['IDKartica', '=', null]])->get();
            //ukoliko postoji vratim id
            if(!$postoji->isEmpty()){
                $id_porudzbine = $postoji[0]->ID;
            } else { //ukoliko ne postoji napravim novu Porudzbinu i vratim id
                $success = DB::table('porudzbina')->insert(['IDAdresa' => $id_adresa]);
                $postoji = DB::table('porudzbina')->where([['IDAdresa', '=', $id_adresa],['IDKartica', '=', null]])->get(); 
                $id_porudzbine = $postoji[0]->ID;    
            }
        }
        //dohvatim proizvode
        $proizvodi = json_decode(json_encode($request->proizvodi),true); 
        $broj_proizvoda = count($proizvodi);
        $provera = 0;
        $potroseno = 0;
        //za svaki proizvod proverim da li postoji u dovoljnoj kolicini za odredjenu velicinu
        foreach($proizvodi as $proizvod){
            $pr=Proizvod::dohv_sa_id($proizvod["ID"]);
            $putanja = $pr[0]->Putanja;
            $kolicina = $proizvod["kolicina"];
            $velicina = $proizvod["velicina"];
            $json = json_decode(file_get_contents($putanja), true); 
            $dostupna_kolicina = $json[$velicina];
            //ukoliko postoji dovoljno kolicine izracunam koliko je korisnik potrosio, azuriram kolicinu i dodam u tabelu Sadrzi
            if($dostupna_kolicina >= $kolicina){
                $ostalo_kolicine = $dostupna_kolicina - $kolicina;
                $potroseno = $potroseno + ($kolicina * $pr[0]->Cena);
                $ostalo_kolicine = (string)$ostalo_kolicine;
                $json[$velicina]=$ostalo_kolicine;
                $izmenjeni_json = json_encode($json);
                file_put_contents($putanja , $izmenjeni_json);
                $postoji = DB::table('sadrzi')->where([['IDProizvod', '=', $proizvod["ID"]],['IDPorudzbina', '=', $id_porudzbine], ['Velicina', '=', $velicina],['Kolicina', '=', $kolicina]])->get();
                if($postoji->isEmpty()){
                    $success = DB::table('sadrzi')->insert(['IDProizvod' => $proizvod["ID"], 'IDPorudzbina' => $id_porudzbine, 'Velicina' => $velicina, 'Kolicina' => $kolicina]);  
                } 
                $provera = $provera + 3; //3 dodajem ukoliko su kupljeni svi proizvodi
            } else if($dostupna_kolicina > 0){ //ukoliko ima nedovoljno kolicine izracunam koliko je korisnik potrosio, azuriram kolicinu i dodam u tabelu Sadrzi
                $ostalo_kolicine = 0;
                $potroseno = $potroseno + ($dostupna_kolicina * $pr[0]->Cena);
                $ostalo_kolicine = (string)$ostalo_kolicine;
                $json[$velicina]=$ostalo_kolicine;
                $izmenjeni_json = json_encode($json);
                file_put_contents($putanja , $izmenjeni_json);
                $postoji = DB::table('sadrzi')->where([['IDProizvod', '=', $proizvod["ID"]],['IDPorudzbina', '=', $id_porudzbine], ['Velicina', '=', $velicina],['Kolicina', '=', $dostupna_kolicina]])->get();
                if($postoji->isEmpty()){
                    $success = DB::table('sadrzi')->insert(['IDProizvod' => $proizvod["ID"], 'IDPorudzbina' => $id_porudzbine, 'Velicina' => $velicina, 'Kolicina' => $dostupna_kolicina]);
                }
                $provera = $provera + 2; //2 dodajem ako je bar nesto imalo da se kupi
            } 
            
        }
        //azuriram korisnikovu potrosnju
        $korisnik->Potroseno=$korisnik->Potroseno + $potroseno;
        $success=$korisnik->save();
        $provera2 = $broj_proizvoda*3;
        //vracanje odgovora u zavisnosti da li je kupovina uspesno obavljena
        if($provera2 == $provera){
            return response()->json([
                'success'=>true,
                'reason'=>'Kupovina uspesno obavljena!'
            ]);
        }
        if($provera == 0){
            return response()->json([
                'success'=>false,
                'reason'=>'Kupovina nije obavljena!'
            ]);
        } else{
            return response()->json([
                'success'=>false,
                'reason'=>'Kupovina delimicno obavljena!'
            ]);
        }
    }
}
