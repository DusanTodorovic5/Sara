<?php

namespace App\Weather;

class Temperatura {
    function __construct($temperatura) {
        if ($temperatura < 12) {
            $this->tip = 0;
        } else if ($temperatura < 28) {
            $this->tip = 1;
        } else {
            $this->tip = 0;
        }
    }

    public function temperatura() {
        return $this->tipovi[$this->tip];
    }

    private static $tipovi = ['Hladno', 'Normalno', 'Toplo'];
    private $tip = 0;
}

?>