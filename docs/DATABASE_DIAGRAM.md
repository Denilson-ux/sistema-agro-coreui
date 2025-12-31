# 📊 Diagrama de Base de Datos - Sistema Agrícola

## Estructura General

```
                    PARCELAS (1) ----< (*) CULTIVOS
                         |
                         | (1)
                         |
                         | (*) 
EMPLEADO (1) ----< TRABAJOS_REALIZADOS >---- (*) (1) TIPOS_TRABAJO
                         |
                         | (1)
                         |
                         | (*)
                  INSUMOS_APLICADOS
                  
                  
EMPLEADO (1) ----< ANTICIPOS >---- DESCUENTOS_ANTICIPOS ----< TRABAJOS_REALIZADOS
```

## Tablas Principales

### 1. empleados
- Almacena información de trabajadores
- Cualquier empleado puede hacer cualquier trabajo

### 2. parcelas
- Lotes de terreno
- Tiene superficie en hectáreas

### 3. cultivos
- Vinculado a una parcela
- Contiene tipo (Soja, Maíz) y variedad (3.02, DM 6.2)
- Estados: por_sembrar, sembrado, en_crecimiento, cosechado

### 4. tipos_trabajo
- Catálogo de trabajos disponibles:
  - Rastreada (requiere_insumos = FALSE)
  - Fumigada (requiere_insumos = TRUE)
  - Siembra (requiere_insumos = FALSE)
  - Cosecha (requiere_insumos = FALSE)

### 5. trabajos_realizados ⭐ TABLA CENTRAL
- Registra cada trabajo realizado
- Relaciona: empleado + parcela + tipo_trabajo + cultivo (opcional)
- Costos:
  - `precio_por_hectarea`: Para rastreada, siembra, cosecha
  - `costo_mano_obra`: Para fumigadas
  - `costo_insumos`: Suma automática de insumos_aplicados
  - `costo_total`: Total del trabajo
  - `pago_empleado`: Lo que gana el empleado

### 6. insumos_aplicados
- SOLO para trabajos de tipo "Fumigada"
- Puede tener múltiples productos por fumigada
- Tipos: herbicida, insecticida, fungicida, coadyuvante, adherente

### 7. anticipos
- Adelantos de dinero a empleados
- Se descuenta automáticamente del total ganado
- Estados: pendiente, parcialmente_descontado, descontado

### 8. descuentos_anticipos (opcional)
- Tracking detallado de qué anticipo se descontó de qué trabajo

## Reglas de Negocio

### Rastreada
- `cultivo_id` = NULL
- NO usa `insumos_aplicados`
- Usa `precio_por_hectarea`
- Cálculo: hectareas × precio_por_hectarea = pago_empleado

### Siembra
- `cultivo_id` = REQUERIDO (selecciona variedad)
- NO usa `insumos_aplicados`
- Usa `precio_por_hectarea`
- Cálculo: hectareas × precio_por_hectarea = pago_empleado

### Fumigada
- `cultivo_id` = Opcional
- SÍ usa `insumos_aplicados` (múltiples productos)
- Usa `costo_mano_obra`
- Cálculo: costo_mano_obra + SUM(insumos) = costo_total
- Empleado gana solo `costo_mano_obra`

### Cosecha
- `cultivo_id` = REQUERIDO
- NO usa `insumos_aplicados`
- Usa `precio_por_hectarea`
- Cálculo: hectareas × precio_por_hectarea = pago_empleado

## Consultas Útiles

### Balance de empleado:
```sql
SELECT 
    e.nombre,
    SUM(tr.pago_empleado) as total_ganado,
    COALESCE(SUM(a.monto), 0) as anticipos,
    SUM(tr.pago_empleado) - COALESCE(SUM(a.monto), 0) as saldo
FROM empleados e
LEFT JOIN trabajos_realizados tr ON e.id = tr.empleado_id
LEFT JOIN anticipos a ON e.id = a.empleado_id
WHERE e.id = ?
GROUP BY e.id;
```

### Costo total de cultivo:
```sql
SELECT 
    c.tipo_cultivo,
    c.variedad,
    SUM(tr.costo_total) as costo_total_produccion
FROM cultivos c
JOIN trabajos_realizados tr ON c.id = tr.cultivo_id
WHERE c.id = ?
GROUP BY c.id;
```
