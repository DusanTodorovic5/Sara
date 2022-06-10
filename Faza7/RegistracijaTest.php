<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class RegistracijaTest extends TestCase
{
    /**
     * Testira uspesnu registraciju korisnika
     *
     * @return void
     */
    public function test_uspesna_registracija()
    {
        $response = $this->postJson("/registruj", [
            "Username" => "testiranje",
            "Password" => "sifra testiranja",
            "Email" => "test@test.laravel",
            "Pol" => "Z",
            "ImeIPrezime" => "Test Testic",
            "Datum" => "2000-06-25",
        ]);

        $response->assertStatus(200)->assertJson(
            [
                "success" => true,
                "reason" => "Uspesno registrovani, sacekajte da vas admin prihvati"
            ]
        );
    }

    /**
     * Testira neuspesnu registraciju, korisnicko ime je zauzeto
     *
     * @return void
     */
    public function test_zauzeto_korisnicko_ime()
    {
        $response = $this->postJson("/registruj", [
            'Username' => "janko",
            "Password" => "sifra testiranja",
            "Email" => "test2@test2.laravel",
            "Pol" => "Z",
            "ImeIPrezime" => "Test Testic",
            "Datum" => "2000-06-25",
        ]);

        $response->assertStatus(200)->assertJson(
            [
                "success" => false,
                "reason" => "Korisnicko ime vec postoji"
            ]
        );
    }

    /**
     * Testira neuspesnu registraciju, zauzet je email
     *
     * @return void
     */
    public function test_zazuet_emejl()
    {
        $response = $this->postJson("/registruj", [
            'Username' => "testiranje2",
            "Password" => "sifra testiranja",
            "Email" => "janko@gmail.com",
            "Pol" => "Z",
            "ImeIPrezime" => "Test Testic",
            "Datum" => "2000-06-25",
        ]);

        $response->assertStatus(200)->assertJson(
            [
                "success" => false,
                "reason" => "Email vec postoji"
            ]

        );
    }
}
