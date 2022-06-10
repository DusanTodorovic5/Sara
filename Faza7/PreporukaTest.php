<?php

namespace Tests\Unit;

use Tests\TestCase;

class PreporukaTest extends TestCase
{
    /**
     * A basic unit test example.
     *
     * @return void
     */
    public function test_preporuka_pass()
    {
        $response = $this->postJson(
            '/preporuka',
            [
                "lat" => "44.787197",
                "long" => "20.457273",
                "Username" => "janko",
                "Password" => "janko",
            ]
        );

        $response->assertStatus(200);
    }
}
