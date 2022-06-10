<?php

namespace Tests\Unit;

use Tests\TestCase;
//use PHPUnit\Framework\TestCase;

class DodavanjeProizvodaTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function test_add_produc_pass()
    {
        $response = $this->post(
            '/proizvod',
            [
                'Naziv' => 'bela trenerka',
                'Opis' => 'lepa bela trenerka',
                'Cena' => '5000',
                'Sezona' => 'leto',
                'Tagovi' => 'Trenerka, Leto, Lepa, Pamuk, Donji',
                'Pol' => 'M',
                'Velicina' => 's',
                'Kolicina' => '3',
                'Interval' => '5 - 10',
                'slika1' => 'http://bit.ly/18g0VNp',
                'slika2' => 'http://bit.ly/18g0VNp',
                'slika3' => 'http://bit.ly/18g0VNp',
            ]
        );

        $response->assertStatus(200)->assertJson([
            'success' => true,
        ]);
    }

    /**
     * A basic test example.
     *
     * @return void
     */
    public function test_add_produc_fail()
    {
        $response = $this->post(
            '/proizvod',
            [
                'Naziv' => 'bela trenerka',
                'Opis' => 'lepa bela trenerka',
                'Cena' => '5000',
                'Tagovi' => 'Trenerka, Leto, Lepa, Pamuk, Donji',
                'Velicina' => 's',
                'Kolicina' => '3',
                'Interval' => '5 - 10',
                'slika1' => 'http://bit.ly/18g0VNp',
                'slika2' => 'http://bit.ly/18g0VNp',
                'slika3' => 'http://bit.ly/18g0VNp',
            ]
        );

        $response->assertStatus(200)->assertJson([
            'success' => false,
        ]);
    }
}
