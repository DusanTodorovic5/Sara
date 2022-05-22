<?php

namespace App\Http;

use App\Models\Korisnik;
use App\Models\Odobravanje;
use App\Models\Proizvod;
use Illuminate\Http\Request;
use GuzzleHttp\Client;
class WeatherApi
{

    private static $base_url = 'https://api.tomorrow.io/v4/timelines?location=';
    private static $rest_url = '&fields=temperature,cloudCover,precipitationProbability&timesteps=1d&units=metric&apikey=';
    private static $token = 'X1V61Ix5obs7v3nhdImuEEMalQAYNXbp';

    static function get_weather($lat, $long) {
        $url = WeatherApi::$base_url.$lat.','.$long.WeatherApi::$rest_url.WeatherApi::$token;
        $client = new Client();
        $res = $client->get($url);

        dd($res->getBody()->getContents());
    }
}


/*
https://api.tomorrow.io/v4/timelines?location=44.787197,20.457273&fields=temperature,cloudCover,precipitationProbability&timesteps=1d&units=metric&apikey=X1V61Ix5obs7v3nhdImuEEMalQAYNXbp
44.787187 - latitude
20.457273 - lognitude
fields = cloudCover, precipitationprobability i temperature
startTime je datum, niz vraca pa ces po tome

po danima
u celzijus
api key se ne dira

*/