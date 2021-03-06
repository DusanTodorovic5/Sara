<?php
//Dusan Todorovic 0393/2019
namespace App\Weather;

use App\Models\Korisnik;
use App\Models\Odobravanje;
use App\Models\Proizvod;
use Illuminate\Http\Request;
use GuzzleHttp\Client;
/*
 * Fasada za upi Tomorrow.io apija, usluzna klasa koja
 * vraca srednje vremenske uslove za neki period
 */

class WeatherApi
{

    private static $base_url = 'https://api.tomorrow.io/v4/timelines?location=';
    private static $rest_url = '&fields=temperature,cloudCover,precipitationProbability&timesteps=1d&units=metric&apikey=';
    private static $token = 'X1V61Ix5obs7v3nhdImuEEMalQAYNXbp';
    private static $tacnost = 5;

    static function get_weather($lat, $long)
    {
        // Proverava da li je tacnost u dobrom intervalu
        if (WeatherApi::$tacnost > 15) {
            WeatherApi::$tacnost = 15;
        } else if (WeatherApi::$tacnost < 1) {
            WeatherApi::$tacnost = 1;
        }
        // Stvara api link od lat i long
        $url = WeatherApi::$base_url . $lat . ',' . $long . WeatherApi::$rest_url . WeatherApi::$token;
        // Dohvata novog Client-a i salje zahtev
        $client = new Client();
        $res = $client->get($url);
        // Dohvata niz json intervala i uzima WeatherApi::tacnost njih
        $data = (json_decode($res->getBody()->getContents()))->data->timelines[0]->intervals;
        $data = array_slice($data, 0, WeatherApi::$tacnost);

        // Racuna prosecnu vrednost vremenskih uslova
        $cloud_cover = 0;
        $rain_probability = 0;
        $temperature = 0;

        foreach ($data as $part) {
            $cloud_cover = $cloud_cover + $part->values->cloudCover;
            $rain_probability = $rain_probability + $part->values->precipitationProbability;
            $temperature = $temperature + $part->values->temperature;
        }
        // Stvara objekte klasa koji mapiraju vremenske uslove u string
        $oblacnost = new Oblacnost($cloud_cover / count($data));
        $kisovitost = new Kisovito($rain_probability / count($data));
        $temperatura = new Temperatura($temperature / count($data));

        return [
            $oblacnost->oblacnost(),
            $kisovitost->kisovito(),
            $temperatura->temperatura()
        ];
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