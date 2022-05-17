<?php

namespace App\Http\Controllers;

use App\Models\KomentarModel;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

use Illuminate\Http\Request;

class ModeratorController extends Controller
{
    
    public function obrisi_recenziju(Request $request){     
        $id=$request->id;
        $pronadjeno=KomentarModel::find($id);
        if(!$pronadjeno) {
            return response()->json([
                'success'=>false,
                'reason'=>'Ne postoji recenzija sa tim id'
            ]);
        }
        KomentarModel::find($id)->delete();
        return response()->json([
            'success'=>true,
            'reason'=>'Obrisana recenzija'
        ]);
    }
    
}
