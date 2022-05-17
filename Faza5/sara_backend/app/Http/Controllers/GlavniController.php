<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

use Illuminate\Http\Request;

class GlavniController extends Controller
{

    public function login_submit(Request $request){
       // dd($request);

        $this->validate(
            $request,[
                'Username' => 'required',
                'Password' => 'required'
            ],[
                'required' => 'Polje :attribute je obavezno'
            ]
        );

        if (!auth()->attempt($request->only('Username','Password'))){       
               return response()->json([
                'success'=>false,
            ]);           
         } 

        return auth()->user();
    }

    public function logout()
    {
        auth()->logout();
       // return view('login');
        
    }
}
