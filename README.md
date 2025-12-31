# 🌾 Sistema de Gestión Agrícola - CoreUI Laravel

Sistema completo para administrar trabajos agrícolas del campo: rastreadas, fumigadas, siembra y cosecha.

## 📋 Características

- ✅ Gestión de **Empleados** (cualquier empleado puede realizar cualquier trabajo)
- ✅ Gestión de **Parcelas** y **Cultivos** (variedades: Soja 3.02, DM 6.2, etc.)
- ✅ Registro de **Trabajos Realizados**:
  - Rastreada (solo precio por hectárea)
  - Fumigada (con múltiples insumos/productos)
  - Siembra (vinculada a variedad de cultivo)
  - Cosecha (solo precio por hectárea)
- ✅ Control de **Insumos Aplicados** (solo para fumigadas)
- ✅ Sistema de **Anticipos** a empleados con descuentos automáticos
- ✅ Reportes y estadísticas de costos

## 🛠️ Tecnologías

- **Backend:** Laravel 11.x
- **Frontend:** CoreUI Laravel (Bootstrap 5)
- **Base de Datos:** SQL Server / MySQL
- **PHP:** 8.2+

## 📦 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/Denilson-ux/sistema-agro-coreui.git
cd sistema-agro-coreui
```

### 2. Instalar dependencias

```bash
composer install
npm install
```

### 3. Configurar entorno

```bash
cp .env.example .env
php artisan key:generate
```

### 4. Configurar base de datos

Edita el archivo `.env`:

**Para SQL Server:**
```env
DB_CONNECTION=sqlsrv
DB_HOST=127.0.0.1
DB_PORT=1433
DB_DATABASE=AGRO
DB_USERNAME=sa
DB_PASSWORD=tu_password
```

**Para MySQL:**
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=agro
DB_USERNAME=root
DB_PASSWORD=
```

### 5. Crear base de datos

Ejecuta el script SQL correspondiente:
- **SQL Server:** `database/schema-sqlserver.sql`
- **MySQL:** `database/schema-mysql.sql`

### 6. Ejecutar migraciones (cuando estén listas)

```bash
php artisan migrate
php artisan db:seed
```

### 7. Compilar assets

```bash
npm run dev
```

### 8. Iniciar servidor

```bash
php artisan serve
```

Visita: `http://localhost:8000`

## 📊 Estructura de Base de Datos

### Tablas Principales:

1. **empleados** - Trabajadores del campo
2. **parcelas** - Lotes de tierra
3. **cultivos** - Cultivos con variedades (Soja 3.02, DM 6.2, etc.)
4. **tipos_trabajo** - Rastreada, Fumigada, Siembra, Cosecha
5. **trabajos_realizados** - Tabla central (quién, qué, dónde, cuándo)
6. **insumos_aplicados** - Productos químicos (solo fumigadas)
7. **anticipos** - Adelantos de pago a empleados
8. **descuentos_anticipos** - Control de descuentos

## 🎯 Flujo del Sistema

### Ejemplo de uso:

1. **Rastreada** → Juan hace rastreada en Lote Norte (50 ha × Bs. 80 = Bs. 4,000)
2. **Anticipo** → Juan pide anticipo de Bs. 1,500
3. **Siembra** → Carlos siembra Soja 3.02 en Lote Norte (Bs. 3,500)
4. **Fumigada** → Juan fumiga con 5 productos (mano obra + insumos)
5. **Cosecha** → Pedro cosecha Lote Norte (50 ha × Bs. 120 = Bs. 6,000)
6. **Liquidación** → Total ganado - anticipos = saldo a pagar

## 🚀 Instalación de CoreUI Laravel

### Opción 1: Template oficial CoreUI

```bash
# Descargar CoreUI Laravel desde GitHub
git clone https://github.com/coreui/coreui-free-laravel-admin-template.git temp-coreui

# Copiar archivos necesarios
cp -r temp-coreui/resources/* resources/
cp -r temp-coreui/public/* public/

# Limpiar
rm -rf temp-coreui
```

### Opción 2: Instalar manualmente

```bash
# Instalar CoreUI via npm
npm install @coreui/coreui
npm install @coreui/icons

# Compilar
npm run build
```

## 📁 Estructura del Proyecto

```
sistema-agro-coreui/
├── app/
│   ├── Models/
│   │   ├── Empleado.php
│   │   ├── Parcela.php
│   │   ├── Cultivo.php
│   │   ├── TipoTrabajo.php
│   │   ├── TrabajoRealizado.php
│   │   ├── InsumoAplicado.php
│   │   └── Anticipo.php
│   ├── Http/Controllers/
│   │   ├── EmpleadoController.php
│   │   ├── ParcelaController.php
│   │   ├── TrabajoController.php
│   │   └── AnticipoController.php
├── database/
│   ├── migrations/
│   ├── seeders/
│   ├── schema-sqlserver.sql
│   └── schema-mysql.sql
├── resources/
│   ├── views/
│   │   ├── empleados/
│   │   ├── parcelas/
│   │   ├── trabajos/
│   │   └── reportes/
└── routes/
    └── web.php
```

## 🔐 Usuarios por Defecto (después de seeder)

- **Admin:** admin@agro.com / password

## 📖 Documentación

- [CoreUI Laravel Docs](https://coreui.io/laravel/docs/)
- [Laravel Docs](https://laravel.com/docs)
- [Diagrama de Base de Datos](database/diagrama-er.md)

## 🤝 Contribuir

1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push al branch (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📝 Licencia

MIT License

## 👤 Autor

**Denilson** - [GitHub](https://github.com/Denilson-ux)

---

⭐ Si te gusta este proyecto, dale una estrella en GitHub!
