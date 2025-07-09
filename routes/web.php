<?php

use Illuminate\Support\Facades\Route;


Route::get('/debug', function () {
    return [
        'env' => app()->environment(),
        'key_set' => config('app.key') !== null,
        'db_path' => config('database.connections.sqlite.database'),
        'db_exists' => file_exists(config('database.connections.sqlite.database')),
    ];
});
Route::get('/', function () {
    return view('welcome');
});

