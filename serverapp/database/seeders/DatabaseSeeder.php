<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Http\Controllers\Controller;
use App\Models\User;
use Faker\Factory;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $faker = Factory::create();
        for ($i = 0; $i < 40; $i++) {
            User::create([
                'ref' => Controller::userRefGen(),
                'firstname' => $faker->firstName,
                'lastname' => $faker->lastName,
                'username' => $faker->userName,
                'email' => $faker->email,
                'phone' => $faker->phoneNumber,
                'birthdate' => $faker->dateTime,
                'role' => $faker->randomElement(['HOUSEKEEPER', 'CLIENT']),
                'status' => $faker->randomElement(['UNCOMPLETED', 'ACTIF', 'SUSPENDED', 'DELETED']),
                'password' => bcrypt('0123456789'),
            ]);
        }

        User::create([
            'ref' => Controller::userRefGen(),
            'firstname' => 'DIGHO',
            'lastname' => 'Jordan',
            'username' => 'Samajeste',
            'email' => 'samajestedigho@gmail.com',
            'phone' => $faker->phoneNumber,
            'birthdate' => $faker->dateTime,
            'role' => 'ADMIN',
            'status' => 'ACTIF',
            'password' => bcrypt('0123456789'),
        ]);

        $this->call(HousekeeperSeeder::class);
        $this->call(AddressSeeder::class);
        $this->call(TaskSeeder::class);
    }
}
