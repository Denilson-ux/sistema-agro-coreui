<header class="header header-sticky mb-4">
    <div class="container-fluid">
        <button class="header-toggler px-md-0 me-md-3" type="button" onclick="coreui.Sidebar.getInstance(document.querySelector('#sidebar')).toggle()">
            <svg class="icon icon-lg">
                <use xlink:href="#cil-menu"></use>
            </svg>
        </button>
        
        <a class="header-brand d-md-none" href="{{ route('dashboard') }}">
            <svg width="118" height="46">
                <use xlink:href="#cil-leaf"></use>
            </svg>
        </a>
        
        <ul class="header-nav d-none d-md-flex">
            <li class="nav-item">
                <a class="nav-link" href="{{ route('dashboard') }}">
                    <strong>🌾 Sistema Agrícola</strong>
                </a>
            </li>
        </ul>
        
        <ul class="header-nav ms-auto">
            <!-- Notificaciones -->
            <li class="nav-item dropdown">
                <a class="nav-link py-0" data-coreui-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <svg class="icon icon-lg">
                        <use xlink:href="#cil-bell"></use>
                    </svg>
                    <span class="badge badge-sm bg-danger ms-auto">3</span>
                </a>
                <div class="dropdown-menu dropdown-menu-end pt-0">
                    <div class="dropdown-header bg-light">
                        <strong>Tienes 3 notificaciones</strong>
                    </div>
                    <a class="dropdown-item" href="#">
                        <div class="d-flex">
                            <div class="flex-shrink-0 me-3">
                                <svg class="icon icon-lg text-success">
                                    <use xlink:href="#cil-check"></use>
                                </svg>
                            </div>
                            <div>
                                <small class="text-medium-emphasis">Trabajo completado</small>
                                <p class="mb-0">Fumigada en Lote Norte finalizada</p>
                            </div>
                        </div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-center" href="#">
                        Ver todas
                    </a>
                </div>
            </li>
        </ul>
        
        <ul class="header-nav ms-3">
            <!-- Usuario -->
            <li class="nav-item dropdown">
                <a class="nav-link py-0" data-coreui-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <div class="avatar avatar-md">
                        <svg class="rounded-circle" width="32" height="32">
                            <use xlink:href="#cil-user"></use>
                        </svg>
                    </div>
                </a>
                <div class="dropdown-menu dropdown-menu-end pt-0">
                    <div class="dropdown-header bg-light py-2">
                        <div class="fw-semibold">Cuenta</div>
                    </div>
                    <a class="dropdown-item" href="#">
                        <svg class="icon me-2">
                            <use xlink:href="#cil-user"></use>
                        </svg>
                        Perfil
                    </a>
                    <a class="dropdown-item" href="#">
                        <svg class="icon me-2">
                            <use xlink:href="#cil-settings"></use>
                        </svg>
                        Configuración
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
                        <svg class="icon me-2">
                            <use xlink:href="#cil-account-logout"></use>
                        </svg>
                        Cerrar Sesión
                    </a>
                </div>
            </li>
        </ul>
    </div>
</header>
