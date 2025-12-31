# 🎨 Guía de Instalación CoreUI Laravel

## 📌 Opción 1: Usar Template Oficial CoreUI (RECOMENDADO)

### Paso 1: Crear proyecto Laravel

```bash
composer create-project laravel/laravel sistema-agro-coreui
cd sistema-agro-coreui
```

### Paso 2: Descargar CoreUI Laravel

```bash
# Clonar template CoreUI
git clone https://github.com/coreui/coreui-free-laravel-admin-template.git temp-coreui

# Copiar archivos
cp -r temp-coreui/resources/views/* resources/views/
cp -r temp-coreui/public/css resources/views/
cp -r temp-coreui/public/js public/
cp -r temp-coreui/public/vendors public/

# Copiar configuraciones
cp temp-coreui/vite.config.js .
cp temp-coreui/package.json .

# Limpiar
rm -rf temp-coreui
```

### Paso 3: Instalar dependencias

```bash
composer install
npm install
npm run build
```

---

## 📌 Opción 2: Instalación Manual desde NPM

### Paso 1: Instalar CoreUI packages

```bash
npm install @coreui/coreui@latest
npm install @coreui/icons@latest
npm install @coreui/chartjs@latest
```

### Paso 2: Configurar Vite

Editar `vite.config.js`:

```javascript
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/css/app.css',
                'resources/js/app.js',
            ],
            refresh: true,
        }),
    ],
});
```

### Paso 3: Importar CoreUI en app.js

Editar `resources/js/app.js`:

```javascript
import './bootstrap';
import '@coreui/coreui';
import * as coreui from '@coreui/coreui';

window.coreui = coreui;
```

### Paso 4: Importar CSS en app.css

Editar `resources/css/app.css`:

```css
@import '@coreui/coreui/dist/css/coreui.min.css';
@import '@coreui/icons/css/all.min.css';

/* Tus estilos personalizados */
```

---

## 🎯 Estructura Básica de Layout

Crear `resources/views/layouts/app.blade.php`:

```blade
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title') - Sistema Agrícola</title>
    
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body>
    <div class="wrapper d-flex flex-column min-vh-100">
        <!-- Sidebar -->
        @include('layouts.sidebar')
        
        <div class="wrapper d-flex flex-column min-vh-100">
            <!-- Header -->
            @include('layouts.header')
            
            <!-- Main Content -->
            <div class="body flex-grow-1">
                <div class="container-lg px-4">
                    @yield('content')
                </div>
            </div>
            
            <!-- Footer -->
            @include('layouts.footer')
        </div>
    </div>
</body>
</html>
```

---

## 🌐 Recursos Oficiales

- **CoreUI Laravel Template:** [https://github.com/coreui/coreui-free-laravel-admin-template](https://github.com/coreui/coreui-free-laravel-admin-template)
- **Documentación CoreUI:** [https://coreui.io/docs/](https://coreui.io/docs/)
- **Componentes CoreUI:** [https://coreui.io/demos/](https://coreui.io/demos/)
- **Iconos CoreUI:** [https://icons.coreui.io/](https://icons.coreui.io/)

---

## ✅ Verificar Instalación

```bash
# Iniciar servidor
php artisan serve

# En otra terminal, compilar assets
npm run dev
```

Visita: `http://localhost:8000`

Deberías ver la interfaz CoreUI funcionando correctamente.

---

## 🔧 Siguientes Pasos

1. Configurar base de datos (`.env`)
2. Ejecutar migraciones
3. Crear controladores y vistas
4. Personalizar sidebar con menús del sistema

¡Listo para empezar a desarrollar! 🚀
