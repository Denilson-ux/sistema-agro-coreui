<div class="sidebar sidebar-dark sidebar-fixed" id="sidebar">
    <div class="sidebar-brand d-none d-md-flex">
        <svg class="sidebar-brand-full" width="118" height="46" alt="CoreUI Logo">
            <use xlink:href="#cil-leaf"></use>
        </svg>
        <svg class="sidebar-brand-narrow" width="46" height="46" alt="CoreUI Logo">
            <use xlink:href="#cil-leaf"></use>
        </svg>
    </div>
    
    <ul class="sidebar-nav" data-coreui="navigation" data-simplebar>
        <!-- Dashboard -->
        <li class="nav-item">
            <a class="nav-link {{ request()->routeIs('dashboard') ? 'active' : '' }}" href="{{ route('dashboard') }}">
                <svg class="nav-icon">
                    <use xlink:href="#cil-speedometer"></use>
                </svg>
                Dashboard
            </a>
        </li>
        
        <li class="nav-title">Gestión</li>
        
        <!-- Empleados -->
        <li class="nav-item">
            <a class="nav-link {{ request()->is('empleados*') ? 'active' : '' }}" href="{{ route('empleados.index') }}">
                <svg class="nav-icon">
                    <use xlink:href="#cil-people"></use>
                </svg>
                Empleados
            </a>
        </li>
        
        <!-- Parcelas -->
        <li class="nav-item">
            <a class="nav-link {{ request()->is('parcelas*') ? 'active' : '' }}" href="{{ route('parcelas.index') }}">
                <svg class="nav-icon">
                    <use xlink:href="#cil-location-pin"></use>
                </svg>
                Parcelas
            </a>
        </li>
        
        <!-- Cultivos -->
        <li class="nav-item">
            <a class="nav-link {{ request()->is('cultivos*') ? 'active' : '' }}" href="{{ route('cultivos.index') }}">
                <svg class="nav-icon">
                    <use xlink:href="#cil-eco"></use>
                </svg>
                Cultivos
            </a>
        </li>
        
        <li class="nav-title">Trabajos</li>
        
        <!-- Trabajos Realizados -->
        <li class="nav-group {{ request()->is('trabajos*') ? 'show' : '' }}">
            <a class="nav-link nav-group-toggle" href="#">
                <svg class="nav-icon">
                    <use xlink:href="#cil-task"></use>
                </svg>
                Trabajos
            </a>
            <ul class="nav-group-items">
                <li class="nav-item">
                    <a class="nav-link {{ request()->routeIs('trabajos.create') ? 'active' : '' }}" href="{{ route('trabajos.create') }}">
                        <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
                        Nuevo Trabajo
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link {{ request()->routeIs('trabajos.index') ? 'active' : '' }}" href="{{ route('trabajos.index') }}">
                        <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
                        Listar Trabajos
                    </a>
                </li>
            </ul>
        </li>
        
        <!-- Anticipos -->
        <li class="nav-item">
            <a class="nav-link {{ request()->is('anticipos*') ? 'active' : '' }}" href="{{ route('anticipos.index') }}">
                <svg class="nav-icon">
                    <use xlink:href="#cil-dollar"></use>
                </svg>
                Anticipos
            </a>
        </li>
        
        <li class="nav-title">Reportes</li>
        
        <!-- Reportes -->
        <li class="nav-group">
            <a class="nav-link nav-group-toggle" href="#">
                <svg class="nav-icon">
                    <use xlink:href="#cil-chart-pie"></use>
                </svg>
                Reportes
            </a>
            <ul class="nav-group-items">
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
                        Balance Empleados
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
                        Costos por Cultivo
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
                        Insumos Aplicados
                    </a>
                </li>
            </ul>
        </li>
        
        <li class="nav-divider"></li>
        
        <!-- Configuración -->
        <li class="nav-item">
            <a class="nav-link" href="#">
                <svg class="nav-icon">
                    <use xlink:href="#cil-settings"></use>
                </svg>
                Configuración
            </a>
        </li>
    </ul>
    
    <button class="sidebar-toggler" type="button" data-coreui-toggle="unfoldable"></button>
</div>
