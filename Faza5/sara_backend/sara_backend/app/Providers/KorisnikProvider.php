<?php

namespace App\Providers;

use App\Models\Korisnik;
use Illuminate\Contracts\Auth\UserProvider;
use Illuminate\Contracts\Auth\Authenticatable;

class KorisnikProvider implements UserProvider{
    
    public function retrieveById($identifier){
        return Korisnik::where('ID', $identifier)->first();
    }

    public function retrieveByToken($identifier, $token){}
    
    
    public function updateRememberToken(Authenticatable $user, $token){}
 
    
    public function retrieveByCredentials(array $credentials){
        return Korisnik::where('Username', $credentials['Username'])->first();
    }
    
    public function validateCredentials(Authenticatable $user, array $credentials){
        return $user->getAuthPassword()==$credentials['Password'];
    }
}