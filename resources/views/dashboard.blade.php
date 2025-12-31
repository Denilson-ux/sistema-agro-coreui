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
            <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                <div>
                    <div class="fs-4 fw-semibold">
                        0
                        <span class="fs-6 ms-2 fw-normal">
                            Empleados
                        </span>
                    </div>
                    <div>Activos</div>
                </div>
                <svg class="icon icon-xl">
                    <use xlink:href="#cil-people"></use>
                </svg>
            </div>
        </div>
    </div>
    
    <div class="col-sm-6 col-lg-3">
        <div class="card mb-4 text-white bg-info">
            <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                <div>
                    <div class="fs-4 fw-semibold">
                        0
                        <span class="fs-6 ms-2 fw-normal">
                            Parcelas
                        </span>
                    </div>
                    <div>Registradas</div>
                </div>
                <svg class="icon icon-xl">
                    <use xlink:href="#cil-location-pin"></use>
                </svg>
            </div>
        </div>
    </div>
    
    <div class="col-sm-6 col-lg-3">
        <div class="card mb-4 text-white bg-warning">
            <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                <div>
                    <div class="fs-4 fw-semibold">
                        0
                        <span class="fs-6 ms-2 fw-normal">
                            Trabajos
                        </span>
                    </div>
                    <div>Este mes</div>
                </div>
                <svg class="icon icon-xl">
                    <use xlink:href="#cil-task"></use>
                </svg>
            </div>
        </div>
    </div>
    
    <div class="col-sm-6 col-lg-3">
        <div class="card mb-4 text-white bg-danger">
            <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                <div>
                    <div class="fs-4 fw-semibold">
                        Bs. 0
                        <span class="fs-6 ms-2 fw-normal">
                        </span>
                    </div>
                    <div>Anticipos Pendientes</div>
                </div>
                <svg class="icon icon-xl">
                    <use xlink:href="#cil-dollar"></use>
                </svg>
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
                    <i class="cil-info me-2"></i>
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
                        <a href="{{ route('empleados.create') }}" class="btn btn-success w-100 py-3">
                            <svg class="icon icon-xl">
                                <use xlink:href="#cil-user-follow"></use>
                            </svg>
                            <div class="mt-2">Nuevo Empleado</div>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{{ route('parcelas.create') }}" class="btn btn-info w-100 py-3">
                            <svg class="icon icon-xl">
                                <use xlink:href="#cil-location-pin"></use>
                            </svg>
                            <div class="mt-2">Nueva Parcela</div>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{{ route('trabajos.create') }}" class="btn btn-warning w-100 py-3">
                            <svg class="icon icon-xl">
                                <use xlink:href="#cil-task"></use>
                            </svg>
                            <div class="mt-2">Registrar Trabajo</div>
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{{ route('anticipos.create') }}" class="btn btn-danger w-100 py-3">
                            <svg class="icon icon-xl">
                                <use xlink:href="#cil-dollar"></use>
                            </svg>
                            <div class="mt-2">Nuevo Anticipo</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
