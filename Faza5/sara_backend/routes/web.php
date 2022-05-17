<?php

use Illuminate\Support\Facades\Route;
use \App\Http\Controllers\GlavniController;
use \App\Http\Controllers\ModeratorController;

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

Route::post('/login_submit',[GlavniController::class,'login_submit'])->name('login_submit');
Route::get('/logout', [GlavniController::class, "logout"])->name('logout');

Route::post('/obrisi_recenziju', [ModeratorController::class, "obrisi_recenziju"]);