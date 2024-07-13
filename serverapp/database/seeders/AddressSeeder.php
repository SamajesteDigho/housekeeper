<?php

namespace Database\Seeders;

use App\Models\Address;
use App\Models\User;
use Faker\Factory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AddressSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = User::limit(20)->get();
        $faker = Factory::create();
        foreach($users as $user) {
            Address::create([
                'user_id' => $user->id,
                'country' => $faker->country,
                'province' => $faker->city,
                'city' => $faker->city,
                'street' => $faker->streetName,
                'full_address' => $faker->streetAddress,
                'postal_code' => $faker->postcode,
                'fax' => $faker->phoneNumber,
                'fixed_phone' => $faker->phoneNumber,
            ]);
        }
    }
}
