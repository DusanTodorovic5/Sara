<?php
//Dusan Todorovic 0393/2019
namespace App\Weather;
/*
 * Klasa koja mapira temperaturu u neki od zadatih stringova
 */
class Temperatura {
    function __construct($temperatura) {
        if ($temperatura < 12) {
            $this->tip = 0;
        } else if ($temperatura < 28) {
            $this->tip = 1;
        } else {
            $this->tip = 2;
        }
    }

    public function temperatura() {
        return $this->tipovi[$this->tip];
    }

    private $tipovi = ['Hladno', 'Normalno', 'Toplo'];
    private $tip = 0;
}

?>