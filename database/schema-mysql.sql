-- =============================================
-- SISTEMA DE GESTIÓN AGRÍCOLA
-- MySQL / MariaDB
-- =============================================

-- 1. EMPLEADOS
CREATE TABLE empleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni_ci VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    direccion TEXT,
    fecha_contratacion DATE,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. PARCELAS
CREATE TABLE parcelas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    superficie_hectareas DECIMAL(10,2) NOT NULL,
    ubicacion TEXT,
    tipo_suelo VARCHAR(50),
    estado ENUM('disponible', 'en_uso', 'descanso') DEFAULT 'disponible',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. CULTIVOS
CREATE TABLE cultivos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    parcela_id INT NOT NULL,
    tipo_cultivo VARCHAR(100) NOT NULL COMMENT 'Soja, Maíz, Trigo, etc.',
    variedad VARCHAR(100) NOT NULL COMMENT 'DM 6.2, 3.02, SPS 4.5, etc.',
    fecha_siembra DATE,
    fecha_cosecha_estimada DATE,
    estado ENUM('por_sembrar', 'sembrado', 'en_crecimiento', 'cosechado') DEFAULT 'por_sembrar',
    observaciones TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (parcela_id) REFERENCES parcelas(id) ON DELETE CASCADE,
    INDEX idx_parcela (parcela_id),
    INDEX idx_estado (estado)
);

-- 4. TIPOS DE TRABAJO
CREATE TABLE tipos_trabajo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL COMMENT 'Rastreada, Fumigada, Siembra, Cosecha',
    descripcion TEXT,
    requiere_insumos BOOLEAN DEFAULT FALSE COMMENT 'TRUE solo para Fumigada',
    unidad_medida VARCHAR(20) DEFAULT 'hectareas',
    precio_base_hectarea DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Datos iniciales
INSERT INTO tipos_trabajo (nombre, descripcion, requiere_insumos, precio_base_hectarea) VALUES
('Rastreada', 'Preparación mecánica del suelo', FALSE, 80.00),
('Fumigada', 'Aplicación de productos químicos', TRUE, 0),
('Siembra', 'Siembra del cultivo', FALSE, 70.00),
('Cosecha', 'Cosecha del cultivo', FALSE, 120.00);

-- 5. TRABAJOS REALIZADOS (TABLA CENTRAL)
CREATE TABLE trabajos_realizados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_trabajo_id INT NOT NULL,
    parcela_id INT NOT NULL,
    cultivo_id INT COMMENT 'Requerido para Siembra, Fumigada y Cosecha. NULL para Rastreada',
    empleado_id INT NOT NULL,
    
    -- Fechas
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME,
    
    -- Medidas
    hectareas_trabajadas DECIMAL(10,2) NOT NULL,
    horas_trabajadas DECIMAL(5,2),
    
    -- Costos
    precio_por_hectarea DECIMAL(10,2) COMMENT 'Para Rastreada, Siembra, Cosecha',
    costo_mano_obra DECIMAL(10,2) COMMENT 'Para Fumigadas (aparte de insumos)',
    costo_insumos DECIMAL(10,2) DEFAULT 0 COMMENT 'Calculado automático de insumos_aplicados',
    costo_total DECIMAL(10,2) NOT NULL COMMENT 'Total del trabajo',
    
    -- Pago al empleado
    pago_empleado DECIMAL(10,2) NOT NULL COMMENT 'Cuánto gana el empleado por este trabajo',
    
    observaciones TEXT,
    estado ENUM('pendiente', 'en_proceso', 'completado', 'cancelado') DEFAULT 'pendiente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (tipo_trabajo_id) REFERENCES tipos_trabajo(id),
    FOREIGN KEY (parcela_id) REFERENCES parcelas(id),
    FOREIGN KEY (cultivo_id) REFERENCES cultivos(id) ON DELETE SET NULL,
    FOREIGN KEY (empleado_id) REFERENCES empleados(id),
    
    INDEX idx_empleado_fecha (empleado_id, fecha_inicio),
    INDEX idx_parcela_trabajo (parcela_id, tipo_trabajo_id),
    INDEX idx_cultivo (cultivo_id),
    INDEX idx_estado (estado)
);

-- 6. INSUMOS APLICADOS (Solo para Fumigadas)
CREATE TABLE insumos_aplicados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    trabajo_id INT NOT NULL COMMENT 'FK a trabajos_realizados - SOLO para Fumigadas',
    tipo_insumo ENUM('herbicida', 'insecticida', 'fungicida', 'coadyuvante', 'adherente', 'otro') NOT NULL,
    producto VARCHAR(100) NOT NULL COMMENT 'Glifosato, 2,4-D, Atrazina, etc.',
    cantidad DECIMAL(10,2) NOT NULL,
    unidad VARCHAR(20) NOT NULL COMMENT 'litros, kg, etc.',
    dosis_hectarea DECIMAL(10,2) COMMENT 'Dosis por hectárea',
    costo_unitario DECIMAL(10,2) NOT NULL,
    costo_total DECIMAL(10,2) GENERATED ALWAYS AS (cantidad * costo_unitario) STORED,
    observaciones TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (trabajo_id) REFERENCES trabajos_realizados(id) ON DELETE CASCADE,
    INDEX idx_trabajo (trabajo_id)
);

-- 7. ANTICIPOS
CREATE TABLE anticipos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_anticipo DATE NOT NULL,
    motivo VARCHAR(255),
    forma_pago ENUM('efectivo', 'transferencia', 'cheque') DEFAULT 'efectivo',
    estado ENUM('pendiente', 'descontado', 'parcialmente_descontado') DEFAULT 'pendiente',
    monto_descontado DECIMAL(10,2) DEFAULT 0,
    saldo_pendiente DECIMAL(10,2) GENERATED ALWAYS AS (monto - monto_descontado) STORED,
    observaciones TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (empleado_id) REFERENCES empleados(id),
    INDEX idx_empleado_estado (empleado_id, estado),
    INDEX idx_fecha (fecha_anticipo)
);

-- 8. DESCUENTOS DE ANTICIPOS (Opcional)
CREATE TABLE descuentos_anticipos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    anticipo_id INT NOT NULL,
    trabajo_id INT NOT NULL,
    monto_descontado DECIMAL(10,2) NOT NULL,
    fecha_descuento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (anticipo_id) REFERENCES anticipos(id) ON DELETE CASCADE,
    FOREIGN KEY (trabajo_id) REFERENCES trabajos_realizados(id) ON DELETE CASCADE,
    
    UNIQUE KEY unique_anticipo_trabajo (anticipo_id, trabajo_id)
);
