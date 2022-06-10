<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class FilterTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function test_filter_proizvoda()
    {
        $response = $this->postJson('/filter', [
            'Pol' => ["M"],
            "Tekst" => "",
            "Cena" => [500, 5000],
            "Kategorija" => []
        ]);

        $response->assertStatus(200);
    }
}
