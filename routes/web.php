<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Aquí registramos las rutas del sistema agrícola
|
*/

// Dashboard
Route::get('/', function () {
    return view('dashboard');
})->name('dashboard');

// Empleados
Route::resource('empleados', App\Http\Controllers\EmpleadoController::class);

// Parcelas
Route::resource('parcelas', App\Http\Controllers\ParcelaController::class);

// Cultivos
Route::resource('cultivos', App\Http\Controllers\CultivoController::class);

// Trabajos
Route::resource('trabajos', App\Http\Controllers\TrabajoController::class);

// Anticipos
Route::resource('anticipos', App\Http\Controllers\AnticipoController::class);
