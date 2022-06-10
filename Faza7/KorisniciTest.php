<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class KorisniciTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function test_dohvatanje_korisnika()
    {
        $response = $this->get('/korisnici');

        $response->assertStatus(200);
    }
    
    public function test_postavi_moderatora(){
        
        $response = $this->post('/moderator',['id'=>4]);

        $response->assertStatus(200)->assertJson(
            [
                'success'=>true
            ]
        );
    }
}
