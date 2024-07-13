<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tasks', function (Blueprint $table) {
            $table->id();
            $table->string('ref');
            $table->unsignedBigInteger('client_id');
            $table->unsignedBigInteger('keeper_id');
            $table->text('description');
            $table->dateTime('start');
            $table->dateTime('end');
            $table->float('price_per_hour');
            $table->enum('currency', ['usd', 'euro', 'xaf'])->default('usd');
            $table->float('reduction')->default(0);
            $table->enum('status', ['PENDING', 'ACCEPTED', 'ONGOING', 'COMPLETED', 'PAID', 'REFUSED', 'PRE-EMPTED'])->default('PENDING');
            $table->float('rating')->default(0);
            $table->text('appreciation')->nullable();
            $table->boolean('paid')->default(false);
            $table->string('payment_ref')->nullable();
            $table->timestamps();

            $table->foreign('client_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('keeper_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tasks');
    }
};
