<?php

namespace Database\Seeders;

use App\Http\Controllers\Controller;
use App\Models\Task;
use App\Models\User;
use Faker\Factory;
use Illuminate\Database\Seeder;

class TaskSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $keeper = User::where(['role' => 'HOUSEKEEPER'])->limit(20)->get();
        $client = User::where(['role' => 'CLIENT'])->limit(10)->get();
        $faker = Factory::create();

        Task::factory(50)->create([
            'ref' => Controller::taskRefGen(),
            'client_id' => $faker->randomElement($client)->id,
            'keeper_id' => $faker->randomElement($keeper)->id,
            'description' => $faker->text,
            'start' => $faker->dateTime,
            'end' => $faker->dateTime,
            'price_per_hour' => $faker->randomFloat(null, 1, 100000),
            'currency' => $faker->randomElement(['usd', 'euro', 'xaf']),
            'reduction' => $faker->randomFloat(null, 0, 100),
            'status' => $faker->randomElement(['PENDING', 'ACCEPTED', 'ONGOING', 'COMPLETED', 'PAID', 'REFUSED', 'PRE-EMPTED']),
            'rating' => $faker->randomFloat(null, 0, 5),
            'appreciation' => $faker->text,
            'paid' => $faker->boolean,
            'payment_ref' => $faker->uuid(),
        ]);
    }
}
