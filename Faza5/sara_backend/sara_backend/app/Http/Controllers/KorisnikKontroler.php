<?php

//Ana Maksimovic 0174/2019
//Ivana Trtovic 0306/2019

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
    /*
    * funkcija za dodavanje recenzije na prosledjeni proizvod
    *
    * @param Request $request Request
    *
    * @return Response
    *
    */
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


    /*
    * funkcija za dohvatanje svih proizvoda
    *
    * @param Request $request Request
    *
    */
    function dohvati_sve_proizvode()
    {
        return Proizvod::all();
    }

    /*
    * funkcija zakreiranje adrese
    *
    * @param Request $request Request
    *
    * @return ID:int
    *
    */
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

    /*
    * funkcija za kreiranje kartice
    *
    * @param Request $request Request
    *
    * @return ID:int
    *
    */
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

    //Metoda koja dohvata podatke o korisniku na osnovu id-ja koji je prosledjen kroz telo
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

    /*
    * funkcija koja dohvata proizvod sa zadatim id
    *
    * @param Request $request Request
    *
    * @return Response
    *
    */
    public function dohvati_proizvod_sa_id(Request $request)
    {
        $id = $request->json()->all()['id'];
        $pronadjeno = Proizvod::dohvati_sa_id($id);
        if (!$pronadjeno) {
            return response()->json([
                'success' => false,
                'reason' => 'Ne postoji'
            ]);
        }

        return response()->json([
            'success' => true,
            'proizvod' => $pronadjeno
        ]);
    }


    /*
    * funkcija kupi_proizvod nam sluzi za pravljnje Porudzbine 
    * i pamcenje svih detalja kupovine u tabeli Sadrzi
    *
    * @param Request $request Request
    *
    * @return Response
    *
    */
    public function kupi_proizvod(Request $request)
    {

        $idKar = (int)$request->idK;
        $idAdr = (int)$request->idA;

        if ($request->flag) {
            $idAdr = KorisnikKontroler::napraviAdresu($request);
            if ($request->placanje == 'kartica') $idKar = KorisnikKontroler::napraviKarticu($request);
        }

        foreach ($request->proizvodi as $pro) {
            $file = File::get("C:\\wamp64\www\detalji\\" . $pro["ID"] . "\\velicine.json");

            $json = json_decode($file, TRUE);
            $json[$pro['velicina']] = $json[$pro['velicina']] - $pro["kolicina"];
            File::put("C:\\wamp64\www\detalji\\" . $pro["ID"] . "\\velicine.json", json_encode($json));
        }
        $kor = Korisnik::dohv_sa_id((int)$request->idKor)[0];
        $kor->Potroseno += $request->cena;
        $kor->save();

        $porudzbina = new Porudzbina();
        $porudzbina->IDAdresa = $idAdr;
        if ($request->placanje == 'kartica') {
            $porudzbina->IDKartica = $idKar;
        } else {
            $porudzbina->IDKartica = null;
        }

        $porudzbina->save();

        return $request->proizvodi;
    }

    /*
    * funkcija koja vraca listu zelja za korisnika
    *
    * @param Request $request Request
    *
    * @return Response
    *
    */
    public function dohvati_listu_zelja(Request $request)
    {
        $idKorisnik = $request->json()->all()['idKorisnik'];
        $pronadjeno = ListaZelja::dohvati_sa_idKorisnika($idKorisnik);

        if (!$pronadjeno) {
            return response()->json([
                'success' => false,
                'reason' => 'Ne postoji'
            ]);
        }
        foreach ($pronadjeno as $element) {
            $id = $element->IdProizvoda;
            $proizvod = Proizvod::dohvati_sa_id($id);
            $uname = $proizvod->Naziv;
            $element->naziv = $uname;
        }

        return response()->json([
            'success' => true,
            'list' => $pronadjeno
        ]);
    }

    /*
    * funkcija za dodavanje proizvoda u listu zelja
    *
    * @param Request $request Request
    *
    * @return Response
    *
    */
    public function dodaj_u_lz(Request $request)
    {
        $idKorisnik = $request->idKorisnik;
        $idProizvod = $request->idProizvod;


        $zeli = new ListaZelja();
        $zeli->IdProizvoda = $idProizvod;
        $zeli->IdKorisnika = $idKorisnik;
        $zeli->Obavesti = 'N';
        $success = $zeli->save();
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
    }

    /*
    * funkcija koja menja polje za obavestavanje o dostupnosti
    * za proi\vod u listi zelja
    *
    * @param Request $request Request
    *
    * @return Response
    *
    */
    public function promeni_obavestavanje(Request $request)
    {
        $idProizvod = $request->idProizvod;
        $idKorisnik = $request->idKorisnik;

        $zeli = ListaZelja::dohv($idProizvod, $idKorisnik)->first();
        $polje = 'D';
        if ($zeli->Obavesti == 'D') $polje = 'N';

        $success = ListaZelja::azuriraj_polje($idProizvod, $idKorisnik, $polje);
        if ($success) {
            return response()->json([
                'success' => true,
                'reason' => 'Uspesno promenjeno!'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'reason' => 'Greska!'
            ]);
        }
    }

    /*
    * funkcija za brisanje proizvoda iz liste zelja
    *
    * @param Request $request Request
    *
    * @return Response
    *
    */
    public function obrisi_iz_ls(Request $request)
    {

        $idProizvod = $request->idProizvod;
        $idKorisnik = $request->idKorisnik;

        $pronadjeno = ListaZelja::find($idKorisnik);
        if (!$pronadjeno) {
            return response()->json([
                'success' => false,
                'reason' => 'Ne postoji'
            ]);
        }
        ListaZelja::obrisi($idProizvod, $idKorisnik);
        return response()->json([
            'success' => true,
            'reason' => 'Obrisano iz liste zelja'
        ]);
    }
}
