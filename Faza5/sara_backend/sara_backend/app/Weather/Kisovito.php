<?php

namespace App\Weather;
/*
 * Klasa koja mapira kisovitost u neki od zadatih stringova
 */
class Kisovito {
    function __construct($kisovitost) {
        if ($kisovitost < 55) {
            $this->tip = 2;
        } else if ($kisovitost < 85) {
            $this->tip = 1;
        } else {
            $this->tip = 0;
        }
    }

    public function kisovito() {
        return $this->tipovi[$this->tip];
    }

    private $tipovi = ['Pljusak', 'Kisa', 'Suvo'];
    private $tip = 0;
}

?>