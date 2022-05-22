<?php

namespace App\Weather;

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

?>