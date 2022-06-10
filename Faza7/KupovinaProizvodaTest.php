<?php

namespace Tests\Unit;

use Tests\TestCase;

use function PHPUnit\Framework\assertEquals;
use function PHPUnit\Framework\assertSame;

class KupovinaProizvodaTest extends TestCase
{
    /**
     * A basic unit test example.
     *
     * @return void
     */
    public function test_buy_products_pass()
    {
        $proizvod = [
            "ID" => 17,
            "velicina" => "s",
            "kolicina" => "1",
        ];
        $pr = array($proizvod);
        $response = $this->post(
            '/kupi',
            [
                "idKor" => "1",
                "proizvodi" => $pr,
                "flag" => false,
                "placanje" => "kartica",
                "idA" => "1",
                "idK" => "1",
            ]
        );
        assertEquals($pr, json_decode($response->content(), true));
    }

    /**
     * A basic unit test example.
     *
     * @return void
     */
    public function test_buy_products_fail()
    {
        $pr = null;
        $response = $this->post(
            '/kupi',
            [
                "idKor" => "1",
                "proizvodi" => $pr,
                "flag" => false,
                "placanje" => "kartica",
                "idA" => "1",
                "idK" => "1",
            ]
        );
        assertEquals(false, json_decode($response->content(), true));
    }
}
