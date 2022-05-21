<?php

namespace App\Http\Controllers;

use App\Models\KorisnikModel;
use App\Models\OdobravanjeModel;
use Illuminate\Http\Request;

class GlavniKontroler extends Controller
{
    function register_user(Request $request){
        $body = $request->json()->all();
        return OdobravanjeModel::add_new($body);
    }
}
