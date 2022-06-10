<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class KreiranjePopustaTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function test_kreiranje_popusta()
    {
        $response = $this->post('/popust',["id"=>15,"popust"=>21]);

        $response->assertStatus(200)->assertJson(
            [
            'success'=>true,
        ]);
    }
}
