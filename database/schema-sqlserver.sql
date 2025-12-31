-- =============================================
-- SISTEMA DE GESTIÓN AGRÍCOLA
-- SQL SERVER
-- =============================================

USE AGRO;
GO

-- 1. EMPLEADOS
CREATE TABLE empleados (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    dni_ci NVARCHAR(20) UNIQUE,
    telefono NVARCHAR(20),
    direccion NVARCHAR(MAX),
    fecha_contratacion DATE,
    estado NVARCHAR(20) DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- 2. PARCELAS
CREATE TABLE parcelas (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    superficie_hectareas DECIMAL(10,2) NOT NULL,
    ubicacion NVARCHAR(MAX),
    tipo_suelo NVARCHAR(50),
    estado NVARCHAR(20) DEFAULT 'disponible' CHECK (estado IN ('disponible', 'en_uso', 'descanso')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- 3. CULTIVOS
CREATE TABLE cultivos (
    id INT PRIMARY KEY IDENTITY(1,1),
    parcela_id INT NOT NULL,
    tipo_cultivo NVARCHAR(100) NOT NULL,
    variedad NVARCHAR(100) NOT NULL,
    fecha_siembra DATE,
    fecha_cosecha_estimada DATE,
    estado NVARCHAR(20) DEFAULT 'por_sembrar' CHECK (estado IN ('por_sembrar', 'sembrado', 'en_crecimiento', 'cosechado')),
    observaciones NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_cultivos_parcelas FOREIGN KEY (parcela_id) 
        REFERENCES parcelas(id) ON DELETE CASCADE
);
GO

CREATE INDEX idx_cultivos_parcela ON cultivos(parcela_id);
CREATE INDEX idx_cultivos_estado ON cultivos(estado);
GO

-- 4. TIPOS DE TRABAJO
CREATE TABLE tipos_trabajo (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX),
    requiere_insumos BIT DEFAULT 0,
    unidad_medida NVARCHAR(20) DEFAULT 'hectareas',
    precio_base_hectarea DECIMAL(10,2),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- Insertar datos iniciales
INSERT INTO tipos_trabajo (nombre, descripcion, requiere_insumos, precio_base_hectarea) VALUES
('Rastreada', 'Preparación mecánica del suelo', 0, 80.00),
('Fumigada', 'Aplicación de productos químicos', 1, 0),
('Siembra', 'Siembra del cultivo', 0, 70.00),
('Cosecha', 'Cosecha del cultivo', 0, 120.00);
GO

-- 5. TRABAJOS REALIZADOS (TABLA CENTRAL)
CREATE TABLE trabajos_realizados (
    id INT PRIMARY KEY IDENTITY(1,1),
    tipo_trabajo_id INT NOT NULL,
    parcela_id INT NOT NULL,
    cultivo_id INT NULL,
    empleado_id INT NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NULL,
    hectareas_trabajadas DECIMAL(10,2) NOT NULL,
    horas_trabajadas DECIMAL(5,2),
    precio_por_hectarea DECIMAL(10,2),
    costo_mano_obra DECIMAL(10,2),
    costo_insumos DECIMAL(10,2) DEFAULT 0,
    costo_total DECIMAL(10,2) NOT NULL,
    pago_empleado DECIMAL(10,2) NOT NULL,
    observaciones NVARCHAR(MAX),
    estado NVARCHAR(20) DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'en_proceso', 'completado', 'cancelado')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_trabajos_tipos FOREIGN KEY (tipo_trabajo_id) 
        REFERENCES tipos_trabajo(id),
    CONSTRAINT FK_trabajos_parcelas FOREIGN KEY (parcela_id) 
        REFERENCES parcelas(id),
    CONSTRAINT FK_trabajos_cultivos FOREIGN KEY (cultivo_id) 
        REFERENCES cultivos(id) ON DELETE SET NULL,
    CONSTRAINT FK_trabajos_empleados FOREIGN KEY (empleado_id) 
        REFERENCES empleados(id)
);
GO

CREATE INDEX idx_trabajos_empleado_fecha ON trabajos_realizados(empleado_id, fecha_inicio);
CREATE INDEX idx_trabajos_parcela_tipo ON trabajos_realizados(parcela_id, tipo_trabajo_id);
CREATE INDEX idx_trabajos_cultivo ON trabajos_realizados(cultivo_id);
CREATE INDEX idx_trabajos_estado ON trabajos_realizados(estado);
GO

-- 6. INSUMOS APLICADOS (Solo para Fumigadas)
CREATE TABLE insumos_aplicados (
    id INT PRIMARY KEY IDENTITY(1,1),
    trabajo_id INT NOT NULL,
    tipo_insumo NVARCHAR(20) NOT NULL CHECK (tipo_insumo IN ('herbicida', 'insecticida', 'fungicida', 'coadyuvante', 'adherente', 'otro')),
    producto NVARCHAR(100) NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    unidad NVARCHAR(20) NOT NULL,
    dosis_hectarea DECIMAL(10,2),
    costo_unitario DECIMAL(10,2) NOT NULL,
    costo_total AS (cantidad * costo_unitario) PERSISTED,
    observaciones NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_insumos_trabajos FOREIGN KEY (trabajo_id) 
        REFERENCES trabajos_realizados(id) ON DELETE CASCADE
);
GO

CREATE INDEX idx_insumos_trabajo ON insumos_aplicados(trabajo_id);
GO

-- 7. ANTICIPOS
CREATE TABLE anticipos (
    id INT PRIMARY KEY IDENTITY(1,1),
    empleado_id INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_anticipo DATE NOT NULL,
    motivo NVARCHAR(255),
    forma_pago NVARCHAR(20) DEFAULT 'efectivo' CHECK (forma_pago IN ('efectivo', 'transferencia', 'cheque')),
    estado NVARCHAR(30) DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'descontado', 'parcialmente_descontado')),
    monto_descontado DECIMAL(10,2) DEFAULT 0,
    saldo_pendiente AS (monto - monto_descontado) PERSISTED,
    observaciones NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_anticipos_empleados FOREIGN KEY (empleado_id) 
        REFERENCES empleados(id)
);
GO

CREATE INDEX idx_anticipos_empleado_estado ON anticipos(empleado_id, estado);
CREATE INDEX idx_anticipos_fecha ON anticipos(fecha_anticipo);
GO

-- 8. DESCUENTOS DE ANTICIPOS
CREATE TABLE descuentos_anticipos (
    id INT PRIMARY KEY IDENTITY(1,1),
    anticipo_id INT NOT NULL,
    trabajo_id INT NOT NULL,
    monto_descontado DECIMAL(10,2) NOT NULL,
    fecha_descuento DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_descuentos_anticipos FOREIGN KEY (anticipo_id) 
        REFERENCES anticipos(id) ON DELETE CASCADE,
    CONSTRAINT FK_descuentos_trabajos FOREIGN KEY (trabajo_id) 
        REFERENCES trabajos_realizados(id),
    CONSTRAINT UQ_anticipo_trabajo UNIQUE (anticipo_id, trabajo_id)
);
GO

-- =============================================
-- TRIGGERS PARA updated_at
-- =============================================

-- Trigger para empleados
CREATE TRIGGER trg_empleados_updated_at
ON empleados
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE empleados
    SET updated_at = GETDATE()
    FROM empleados e
    INNER JOIN inserted i ON e.id = i.id;
END;
GO

-- Trigger para parcelas
CREATE TRIGGER trg_parcelas_updated_at
ON parcelas
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE parcelas
    SET updated_at = GETDATE()
    FROM parcelas p
    INNER JOIN inserted i ON p.id = i.id;
END;
GO

-- Trigger para cultivos
CREATE TRIGGER trg_cultivos_updated_at
ON cultivos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE cultivos
    SET updated_at = GETDATE()
    FROM cultivos c
    INNER JOIN inserted i ON c.id = i.id;
END;
GO

-- Trigger para tipos_trabajo
CREATE TRIGGER trg_tipos_trabajo_updated_at
ON tipos_trabajo
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE tipos_trabajo
    SET updated_at = GETDATE()
    FROM tipos_trabajo t
    INNER JOIN inserted i ON t.id = i.id;
END;
GO

-- Trigger para trabajos_realizados
CREATE TRIGGER trg_trabajos_realizados_updated_at
ON trabajos_realizados
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE trabajos_realizados
    SET updated_at = GETDATE()
    FROM trabajos_realizados t
    INNER JOIN inserted i ON t.id = i.id;
END;
GO

-- Trigger para anticipos
CREATE TRIGGER trg_anticipos_updated_at
ON anticipos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE anticipos
    SET updated_at = GETDATE()
    FROM anticipos a
    INNER JOIN inserted i ON a.id = i.id;
END;
GO

PRINT 'Base de datos creada exitosamente para SQL Server';
GO
