<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    
    <title>@yield('title', 'Dashboard') - Sistema Agrícola</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="{{ asset('favicon.png') }}">
    
    <!-- Styles -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    
    @stack('styles')
</head>
<body>
    <!-- Sidebar -->
    @include('layouts.sidebar')
    
    <div class="wrapper d-flex flex-column min-vh-100">
        <!-- Header -->
        @include('layouts.header')
        
        <!-- Main Content -->
        <div class="body flex-grow-1 px-3 py-3">
            <div class="container-lg">
                @if(session('success'))
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="cil-check-circle me-2"></i>
                        {{ session('success') }}
                        <button type="button" class="btn-close" data-coreui-dismiss="alert"></button>
                    </div>
                @endif
                
                @if(session('error'))
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="cil-x-circle me-2"></i>
                        {{ session('error') }}
                        <button type="button" class="btn-close" data-coreui-dismiss="alert"></button>
                    </div>
                @endif
                
                @yield('content')
            </div>
        </div>
        
        <!-- Footer -->
        @include('layouts.footer')
    </div>
    
    @stack('scripts')
</body>
</html>
