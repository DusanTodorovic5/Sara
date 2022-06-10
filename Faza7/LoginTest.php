<?php

namespace Tests\Unit;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;


class LoginTest extends TestCase
{
    /**
     * Login test
     *
     * @return void
     */
    public function test_try_login_pass()
    {

        $response = $this->post('/login_submit', ['Username' => 'janko', 'Password' => 'janko']);

        $response->assertStatus(200)->assertJson(
            [
                'success' => true,
            ]
        );
    }

    /**
     * Login test neuspesan
     *
     * @return void
     */
    public function test_try_login_fail()
    {

        $response = $this->post('/login_submit', ['Username' => 'x', 'Password' => 'x']);

        $response->assertStatus(200)->assertJson(
            [
                'success' => false,
            ]
        );
    }
}
