<?php

//Ana Maksimovic 0174/2019

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
Route::get('/pending', [AdminKontroler::class, 'pending']);
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
Route::post('/pending/true', [AdminKontroler::class, 'prihvati_kor']);
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
Route::post('/pending/false', [AdminKontroler::class, 'odbij_kor']);
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
Route::post('/moderator', [AdminKontroler::class, 'moderatori']);

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
Route::get("/korisnici", [AdminKontroler::class, 'dohv_korisnike']);

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
Route::post('/recenzija', [KorisnikKontroler::class, 'dodaj_recenziju']);

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
Route::post('/popust', [ModeratorKontroler::class, 'dodaj_popust']);

/**
 * Ruta kojom se vrsi login korisnika
 * 
 * Telo zahteva je json u formatu
 * {
 * "Username":"username korisnika",
 * "Password":"password korisnika"
 * 
 * }
 * 
 * Odgovor je json u formatu
 * za neuspesno logovanje:
 * {
 * "success":false
 * }
 * za uspesno logovanje:
 *{
 *  "ID":"id",
 *  "Username" : "username",
 *  "Password" : "password",
 *  "Email" : "email",
 *  "ImeIPrezime" : "ime i prezime",
 *  "Pol" : "M ili Z",
 *  "Potroseno":"0",
 *  "Datum" : "datum rodjenja",
 *  "Tip" :"M ili K ili A"
 * }
 * }
 */
Route::post('/login_submit', [GlavniKontroler::class, 'login_submit'])->name('login_submit');

/*
 * Ruta kojom se vrsi logout korisnika
 */
Route::get('/logout', [GlavniKontroler::class, "logout"])->name('logout');

/**
 * Ruta kojom se brise recenzija iz baze
 * 
 * Telo zahteva je json u formatu
 * {
 * "id":"id recenzije"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno "
 * }
 */
Route::post('/obrisi_recenziju', [ModeratorKontroler::class, "obrisi_recenziju"]);

/**
 * Ruta kojom se dodaje proizvod u bazu
 * 
 * Telo zahteva je json u formatu
 * {
 *         'Naziv': nazivController.text,
 *         'Opis': 'opis',
 *         'Cena': 'cena',
 *         'Sezona': 'sezona',
 *         'Tagovi': 'tagovi',
 *         'Pol': 'pol',
 *         'Velicina': 'velicina',
 *         'Kolicina': 'kolicina',
 *         'Interval': interval,
 *         'slika1': 'slika',
 *         'slika2': 'slika',
 *         'slika3': 'slika',
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno "
 * }
 */
Route::post('/proizvod', [AdminKontroler::class, 'dodaj_proizvod']);

/**
 * Ruta kojom se kupuje proizvod
 * 
 * Telo zahteva je json u formatu
 * {
 *       "idKor": "idKorisnika",
 *        "proizvodi": "proizvodi"
 *        "adresa": {
 *           "Ulica":"ulica",
 *           "Broj": "broj",
 *           "Sprat": "sprat",
 *           "BrojStana": "broj stana",
 *           "PostanskiBroj": "postanski broj",
 *           "Mesto": "mesto,
 *         },
 *         "flag": "flag",
 *         "placanje": "nacinPlacanja",
 *         "kartica": {
 *           "BrojKartice": "broj kartice",
 *           "CSV": "csv",
 *           "DatumIsteka": "datum isteka",
 *         },
 *         "idA": "idAdrese",
 *         "idK": "idKartice",
 * }
 */
Route::post('/kupi', [KorisnikKontroler::class, 'kupi_proizvod']);

/**
 * Ruta kojom se dodaje proizvod u listu zelja
 * 
 * Telo zahteva je json u formatu
 * {
 * "id":"id proizvoda"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "Uspesno ili neuspesno "
 * }
 */
Route::post('/zeli', [KorisnikKontroler::class, 'dodaj_u_listu_zelja']);


/* 
 * Ruta za filtriranje proizvoda, salje se zahtev u sledecem obliku
 * 
 * {
 *  "Pol" : ["Z", "M"],
 *	"Tekst" : null,
 *	"Cena" : [500,2200],
 *	"Kategorija" : ["Prolece", "Jednobojna"]
 * }
 * 
 * Povratna vrednost je json niz Proizvoda
 */
Route::post('/filter', [GlavniKontroler::class, 'filter']);
/*
 * Ruta za preporuku proizvoda, salje se get zahtev u sledecem obliku
 * {
 *  "lat" : "lat",
 *  "long" : "long",
 *  "Username" : "username",
 *  "Password" : "password"
 * }
 * 
 * Povratna vrednost je json niz Proizvoda
 */
Route::post('/preporuka', [GlavniKontroler::class, 'preporuka']);

/** Ruta koja sluzi za dohvatanje svih proizvoda
 * 
 */
Route::get('/proizvodi', [KorisnikKontroler::class, 'dohvati_sve_proizvode']);


/*
 * Ruta za dodavanje velicine
 * {
 *  "id" : "id proizvoda",
 *  "velicina" : "velicina",
 *  "kolicina" : "kolicina"
 * }
 */
Route::post('/dodajVelicinu', [AdminKontroler::class, 'dodaj_novu_velicinu']);

/*
 * Ruta za dohvatanje svih recenzija
 * {
 *  "idProizvod" : "idProizvnod"
 * }
 * 
 *  Odgovor je json u formatu
 * {
 * "success":true,
 * "list": "lista recenzija"
 * }
 */
Route::post('/dohvati_sve_recenzije', [ModeratorKontroler::class, 'dohvati_sve_recenzije']);


Route::post('/dohvati_korisnika', [ModeratorKontroler::class, 'dohvati_korisnika']);

/**
 * Ruta kojom se dohvata proizvod
 * 
 * Telo zahteva je json u formatu
 * {
 * "id":"id proizvoda"
 * }
 * 
 * Odgovor je json u formatu
 * {
 * "success":false,
 * "reason": "Ne postoji!"
 * }
 * ili
 * {
 * "success":true,
 * "proizvod":"proizvod"
 * }
 */
Route::post('/dohvati_proizvod_sa_id', [KorisnikKontroler::class, 'dohvati_proizvod_sa_id']);

/**
 *Ruta koja dohvata podatke o kojim se popunjavaju polje u frontendu
 *
 * Telo zahteva je oblika
 *{
 *  'id':'idKorisnika'
 *}
 *Telo odgovora je oblika
 *{'ime':'ime korisnika',
 * 'adresa':{ 'Ulica':'ulica',
 *          'Broj':'broj',
 *          'Sprat':'sprat',
 *          'BrojStana':'brojstana',
 *        },
 * 'kartica':{'Broj':'brojkartice',
 *            'CSV':'csv',
 *            'DatumIsteka':'datumIsteka'
 *          }
 *}
 */

Route::post('/dohvatiPodatke', [KorisnikKontroler::class, 'dohvati_podatke']);


/*
 * Ruta za dohvatanje liste zelja zadatog korisnika
 * {
 *  "idKorisnik" : "idKorisnik"
 * }
 * 
 *  Odgovor je json u formatu
 * {
 * "success":true,
 * "list": "lista proizvoda koji su u listi zelja"
 * }
 */
Route::post('/zeli_sa_id', [KorisnikKontroler::class, 'dohvati_listu_zelja']);


/*
 * Ruta za dodavanje u listu zelja
 * {
 *  "idKorisnik" : "idKorisnik",
 *  "idProizvod" : "idProizvnod"
 * }
 * 
 *  Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "uspesno ili ne"
 * }
 */
Route::post('/dodaj_u_lz', [KorisnikKontroler::class, 'dodaj_u_lz']);

/*
 * Ruta za promenu obavestavanja za proizvod iz liste zelja
 * {
 *  "idKorisnik" : "idKorisnik",
 *  "idProizvod" : "idProizvnod"
 * }
 * 
 *  Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "uspesno ili ne"
 * }
 */
Route::post('/promeni_obavestavanje', [KorisnikKontroler::class, 'promeni_obavestavanje']);

/*
 * Ruta za brisanje iz liste zelja
 * {
 *  "idKorisnik" : "idKorisnik",
 *  "idProizvod" : "idProizvnod"
 * }
 * 
 *  Odgovor je json u formatu
 * {
 * "success":true ili false,
 * "reason": "uspesno ili ne"
 * }
 */
Route::post('/obrisi_iz_ls', [KorisnikKontroler::class, 'obrisi_iz_ls']);
