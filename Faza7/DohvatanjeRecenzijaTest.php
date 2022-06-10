<?php

namespace Tests\Unit;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;


class DohvatanjeRecenzijaTest extends TestCase
{
    /**
     * Dohvati sve recenzije za id pass
     *
     * @return void
     */
    public function test_dohv_sve_recenzije_pass()
    {

        $response = $this->post('/dohvati_sve_recenzije', ['idProizvod' => '1']); //neki id koji postoji u bazi

        $response->assertStatus(200)->assertJson(
            [
                'success' => true,
            ]
        );
    }
}
