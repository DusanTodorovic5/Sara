<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class PendingTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
   
     public function test_dohvatanje_pending()
    {
        $response = $this->get('/pending');

        $response->assertStatus(200);
    }

    public function test_odobravanje_naloga(){
        $response = $this->post('/pending/true',['id'=>21]);

        $response->assertStatus(200)->assertJson(
            [
                'success'=>true,
            ]
        );
    }

    public function test_odbijanje_naloga(){
        $response = $this->post('/pending/false',['id'=>22]);

        $response->assertStatus(200)->assertJson(
            [
                'success'=>true,
            ]
        );
    }

}
