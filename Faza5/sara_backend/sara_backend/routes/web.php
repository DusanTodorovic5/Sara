<?php

use App\Http\Controllers\GlavniKontroler;
use App\Http\Controllers\AdminKontroler;
use App\Http\Controllers\KorisnikKontroler;
use App\Http\Controllers\ModeratorKontroler;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/token', function () {
    return csrf_token(); 
});
/*
 * /registruj ruta prima json zahtev o registraciji sa potrebnim parametrima u vidu
 * 
 * {
 *  "Username" : "username",
 *  "Password" : "password",
 *  "Email" : "email",
 *  "ImeIPrezime" : "ime i prezime",
 *  "Pol" : "M ili Z",
 *  "Datum" : "datum rodjenja"
 * }
 * 
 * Vraca json odgovor sa dva parametra sledeceg tipa
 * 
 * {
 *  "Status" : "true ili false u zavisnosti od uspesnosti",
 *  "Message" : "Obrazlozenje o vracenom zahtevu"
 * }
 * 
 */
Route::post("/registruj", [GlavniKontroler::class, "register_user"]);


/**
 * Ruta koja vraca listu korisnika koji cekaju odobrenje.
 * 
 * Odgovor je niz json-a u formatu 
 * {
 *  "ID":"id",
 *  "Username" : "username",
 *  "Password" : "password",
 *  "Email" : "email",
 *  "ImeIPrezime" : "ime i prezime",
 *  "Pol" : "M ili Z",
 *  "Datum" : "datum rodjenja",
 *  "Potroseno":"0"
 * }
 * 
 */
Route::get('/pending',[AdminKontroler::class,'pending']);
/**
 * Ruta koja dodaje korisnika 
 * 
 * Telo zahteva je json u formatu
 * {
 * "id":"id korisnika iz tabele za odobravanje"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno dodavanje"
 * }
 */
Route::post('/pending/true',[AdminKontroler::class,'prihvati_kor']);
/**
 * Ruta koja odbija korisnika 
 * 
 * Telo zahteva je json u formatu
 * {
 * "id":"id korisnika iz tabele za odobravanje"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno odbijanje"
 * }
 */
Route::post('/pending/false',[AdminKontroler::class,'odbij_kor']);
/**
 * Ruta koja daje/otklanja moderatorska prava pristupa korisniku
 * 
 * Telo zahteva je json u formatu
 * {
 * "id":"id korisnika iz tabele za korisnike"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno "
 * }
 */
Route::post('/moderator',[AdminKontroler::class,'moderatori']);

/**
 * Ruta koja vraca sve korisnike
 * 
 * Odgovor je niz json-a u formatu
 * {
 *  "ID":"id",
 *  "Username" : "username",
 *  "Password" : "password",
 *  "Email" : "email",
 *  "ImeIPrezime" : "ime i prezime",
 *  "Pol" : "M ili Z",
 *  "Datum" : "datum rodjenja",
 *  "Potroseno":"0",
 *  "Tip":"K,M ili A"
 * }
 * 
 */
Route::get("/korisnici",[AdminKontroler::class,'dohv_korisnike']);

/**
 * Ruta kojom se dodaje recenzija na proivod
 * 
 * Telo zahteva je json u formatu
 * {
 * "IDProizvod":"id proizvoda",
 * "Text":"text recenzije"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno "
 * }
 */
Route::post('/recenzija',[KorisnikKontroler::class,'dodaj_recenziju']);

/**
 * Ruta koja dodaje popust na proizvod
 * 
 * Telo zahteva je json u formatu
 * {
 * "id":"id proizvoda",
 * "popust":"vrednost popusta u procentima"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno "
 * }
 */
Route::post('/popust',[ModeratorKontroler::class,'dodaj_popust']);
