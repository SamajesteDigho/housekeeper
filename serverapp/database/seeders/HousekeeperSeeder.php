<?php

namespace Database\Seeders;

use App\Http\Controllers\Controller;
use App\Models\Housekeeper;
use App\Models\User;
use Faker\Factory;
use Illuminate\Database\Seeder;

class HousekeeperSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Factory::create();
        $users = User::where(['role' => 'HOUSEKEEPER'])->limit(20)->get();
        foreach ($users as $user) {
            Housekeeper::create([
                'user_id' => $user->id,
                'matricule' => Controller::housekeeperRefGen(),
                'rating' => $faker->randomFloat(null, 0, 5),
                'nationality' => $faker->country,
                'province' => $faker->city,
                'religion' => $faker->randomElement(['CHRISTIAN', 'MUSLIM', 'NONE', 'TRADITIONALIST', 'BUDDIST']),
                'verified' => $faker->boolean
            ]);
        };
    }
}
