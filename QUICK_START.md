# 🚀 Inicio Rápido - Sistema Agrícola

## 1️⃣ Clonar y Configurar

```bash
# Clonar repositorio
git clone https://github.com/Denilson-ux/sistema-agro-coreui.git
cd sistema-agro-coreui

# Copiar .env
cp .env.example .env

# Generar key
php artisan key:generate
```

## 2️⃣ Base de Datos

### SQL Server:
```bash
# Editar .env
DB_CONNECTION=sqlsrv
DB_DATABASE=AGRO
DB_USERNAME=sa
DB_PASSWORD=tu_password

# Ejecutar script
# Abrir SQL Server Management Studio
# Ejecutar: database/schema-sqlserver.sql
```

### MySQL:
```bash
# Editar .env
DB_CONNECTION=mysql
DB_DATABASE=agro
DB_USERNAME=root
DB_PASSWORD=

# Crear base de datos
mysql -u root -p
CREATE DATABASE agro;
exit;

# Ejecutar script
mysql -u root -p agro < database/schema-mysql.sql
```

## 3️⃣ Instalar CoreUI

### Opción A: Template Oficial (Más rápido)

```bash
git clone https://github.com/coreui/coreui-free-laravel-admin-template.git temp
cp -r temp/resources/views/* resources/views/
cp -r temp/public/* public/
rm -rf temp

npm install
npm run build
```

### Opción B: Instalación Manual

```bash
npm install @coreui/coreui @coreui/icons
npm run build
```

## 4️⃣ Iniciar Servidor

```bash
php artisan serve
```

Visita: [http://localhost:8000](http://localhost:8000)

## ✅ Verificación

- [ ] Base de datos creada
- [ ] Tablas creadas (empleados, parcelas, cultivos, etc.)
- [ ] CoreUI funcionando
- [ ] Servidor Laravel corriendo

## 📚 Siguiente Paso

Lee el [README completo](README.md) para más detalles.

---

¿Problemas? Abre un [issue](https://github.com/Denilson-ux/sistema-agro-coreui/issues) 🐛
