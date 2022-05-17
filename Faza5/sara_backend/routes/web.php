<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\ModeratorController;
use App\Http\Controllers\KorisnikController;
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
Route::get('/pending',[AdminController::class,'pending']);
Route::get('/pending/{id}/true',[AdminController::class,'prihvati_kor']);
Route::get('/pending/{id}/false',[AdminController::class,'odbij_kor']);
Route::get('/moderator/{id}',[AdminController::class,'dodaj_moderatora']);

Route::post('/recenzija',[KorisnikController::class,'dodaj_recenziju']);
Route::post('/popust',[ModeratorController::class,'dodaj_popust']);

