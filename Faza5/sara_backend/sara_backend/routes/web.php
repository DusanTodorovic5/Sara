<?php

use App\Http\Controllers\GlavniKontroler;
use App\Http\Controllers\AdminKontroler;
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

Route::get('/pending',[AdminKontroler::class,'pending']);
Route::post('/pending/true',[AdminKontroler::class,'prihvati_kor']);
Route::post('/pending/false',[AdminKontroler::class,'odbij_kor']);
Route::post('/moderator',[AdminKontroler::class,'moderatori']);

Route::get("/korisnici",[AdminKontroler::class,'dohv_korisnike']);
