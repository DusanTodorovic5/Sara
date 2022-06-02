<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Proizvod;
use App\Models\Komentar;
use App\Models\Korisnik;
use Illuminate\Http\Request;

/**
 * Klasa ModeratorKontroler nam sluzi za moderiranje sistema 
 * u vidu kreiranja popusta, brisanja neprikladnih recenzija i slicnih stvari
 */
class ModeratorKontroler extends Controller
{

    /*
    * funkcija dodaje popust na artikal koji smo prosledili 
    * kroz telo zahteva
    *
    * @param Request $request Request
    *
    * @return Response
    */
    public function dodaj_popust(Request $request)
    {
        $proizvod = Proizvod::dohvati_sa_id($request->id)[0];
        $proizvod->Popust = $request->popust;
        $success = $proizvod->save();
        if ($success) {
            return response()->json([
                'success' => true,
                'reason' => 'Uspesno kreiranje popusta!'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'reason' => 'Greska pri kreiranju popusta!'
            ]);
        }
    }


    /*
    * funkcija koja brise recenziju kojoj 
    *  odgovara odgovara prosledjeni id
    *
    *  @param Request $request Request
    *
    * @return Response
    */
    public function obrisi_recenziju(Request $request)
    {
        $id = $request->id;
        $pronadjeno = Komentar::find($id);
        if (!$pronadjeno) {
            return response()->json([
                'success' => false,
                'reason' => 'Ne postoji recenzija sa tim id'
            ]);
        }
        Komentar::find($id)->delete();
        return response()->json([
            'success' => true,
            'reason' => 'Obrisana recenzija'
        ]);
    }


    /*
    * funkcija koja dohvata sve recenzije
    * za zadati id proizvoda
    *
    * @param Request $request Request
    *
    * @return Response
    */
    public function dohvati_sve_recenzije(Request $request)
    {
        $idProizvod = $request->idProizvod;
        $pronadjeno = Komentar::dohvati_sa_IDProizvod($idProizvod);

        if (!$pronadjeno) {
            return response()->json([
                'success' => false,
                'reason' => 'Ne postoji'
            ]);
        }

        foreach ($pronadjeno as $element) {
            $idK = $element->IDKorisnik;
            $korisnik = Korisnik::dohv_sa_id($idK);
            $uname = $korisnik[0]->Username;
            $element->username = $uname;
        }

        return response()->json([
            'success' => true,
            'list' => $pronadjeno,

        ]);
    }

    /*
    * funkcija koja vraca Korisnika
    * sa zadatim id
    *
    * @param Request $request Request
    *
    * @return Response
    */
    public function dohvati_korisnika(Request $request)
    {
        $id = $request->id;
        $pronadjeno = Korisnik::dohv_sa_id($id);
        if (!$pronadjeno) {
            return response()->json([
                'success' => false,
                'reason' => 'Ne postoji'
            ]);
        }

        return response()->json([
            'success' => true,
            'korisnik' => $pronadjeno
        ]);
    }
}
