<?php
//Dusan Todorovic 0393/2019
namespace App\Weather;
/*
 * Klasa koja mapira oblacnost u neki od zadatih stringova
 */
class Oblacnost {
    function __construct($oblacnost) {
        if ($oblacnost < 45) {
            $this->tip = 2;
        } else if ($oblacnost < 75) {
            $this->tip = 1;
        } else {
            $this->tip = 0;
        }
    }

    public function oblacnost() {
        return $this->tipovi[$this->tip];
    }

    private $tipovi = ['Oblacno', 'Mestimicno Oblacno', 'Vedro'];
    private $tip = 0;
}
