<?php

namespace Tests\Unit;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;


class BrisanjeRecenzijeTest extends TestCase
{
    /**
     * Obrisi recenziju pass
     *
     * @return void
     */
    public function test_obrisi_recenziju_pass()
    {

        $response = $this->post('/obrisi_recenziju', ['id' => '1']); //neki id koji postoji u bazi

        $response->assertStatus(200)->assertJson(
            [
                'success' => true,
            ]
        );
    }

    /**
     * Obrisi recenziju fail
     *
     * @return void
     */
    public function test_obrisi_recenziju_fail()
    {

        $response = $this->post('/obrisi_recenziju', ['id' => '33']);  //neki id koji ne postoji u bazi

        $response->assertStatus(200)->assertJson(
            [
                'success' => false,
            ]
        );
    }
}
