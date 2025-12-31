@extends('layouts.app')

@section('title', 'Dashboard')

@section('content')
<div class="row">
    <div class="col-12">
        <div class="card mb-4">
            <div class="card-body">
                <h1 class="display-6 mb-0">
                    <svg class="icon icon-xxl text-success me-2">
                        <use xlink:href="#cil-leaf"></use>
                    </svg>
                    Bienvenido al Sistema Agrícola
                </h1>
                <p class="text-medium-emphasis">Gestión completa de trabajos del campo</p>
            </div>
        </div>
    </div>
</div>

<!-- Stats Cards -->
<div class="row">
    <div class="col-sm-6 col-lg-3">
        <div class="card mb-4 text-white bg-success">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <div class="fs-4 fw-semibold">0</div>
                    <div>Empleados Activos</div>
                </div>
                <div class="stats-icon">
                    <svg class="icon icon-xl">
                        <use xlink:href="#cil-people"></use>
                    </svg>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-sm-6 col-lg-3">
        <div class="card mb-4 text-white bg-info">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <div class="fs-4 fw-semibold">0</div>
                    <div>Parcelas Registradas</div>
                </div>
                <div class="stats-icon">
                    <svg class="icon icon-xl">
                        <use xlink:href="#cil-location-pin"></use>
                    </svg>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-sm-6 col-lg-3">
        <div class="card mb-4 text-white bg-warning">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <div class="fs-4 fw-semibold">0</div>
                    <div>Trabajos Este mes</div>
                </div>
                <div class="stats-icon">
                    <svg class="icon icon-xl">
                        <use xlink:href="#cil-task"></use>
                    </svg>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-sm-6 col-lg-3">
        <div class="card mb-4 text-white bg-danger">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <div class="fs-4 fw-semibold">Bs. 0</div>
                    <div>Anticipos Pendientes</div>
                </div>
                <div class="stats-icon">
                    <svg class="icon icon-xl">
                        <use xlink:href="#cil-dollar"></use>
                    </svg>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Últimos trabajos -->
<div class="row">
    <div class="col-md-12">
        <div class="card mb-4">
            <div class="card-header">
                <strong>Trabajos Recientes</strong>
            </div>
            <div class="card-body">
                <div class="alert alert-info mb-0" role="alert">
                    <svg class="icon me-2">
                        <use xlink:href="#cil-info"></use>
                    </svg>
                    No hay trabajos registrados aún. Comienza registrando empleados y parcelas.
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="row">
    <div class="col-md-12">
        <div class="card mb-4">
            <div class="card-header">
                <strong>Acciones Rápidas</strong>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-3">
                        <a href="{{ route('empleados.create') }}" class="btn btn-success w-100 py-3 d-flex flex-column align-items-center">
                            <svg class="icon icon-xl mb-2">
                                <use xlink:href="#cil-user-follow"></use>
                            </svg>
                            <span>Nuevo Empleado</span>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{{ route('parcelas.create') }}" class="btn btn-info w-100 py-3 d-flex flex-column align-items-center">
                            <svg class="icon icon-xl mb-2">
                                <use xlink:href="#cil-location-pin"></use>
                            </svg>
                            <span>Nueva Parcela</span>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{{ route('trabajos.create') }}" class="btn btn-warning w-100 py-3 d-flex flex-column align-items-center">
                            <svg class="icon icon-xl mb-2">
                                <use xlink:href="#cil-task"></use>
                            </svg>
                            <span>Registrar Trabajo</span>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{{ route('anticipos.create') }}" class="btn btn-danger w-100 py-3 d-flex flex-column align-items-center">
                            <svg class="icon icon-xl mb-2">
                                <use xlink:href="#cil-dollar"></use>
                            </svg>
                            <span>Nuevo Anticipo</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
