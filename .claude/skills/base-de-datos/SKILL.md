---
name: base-de-datos
description: Diseño y evolución de bases de datos - modelado de esquema, normalización, restricciones, índices, migraciones seguras, transacciones, consultas eficientes y auditoría. Usar al crear o cambiar tablas, escribir migraciones, optimizar consultas o definir cómo se persisten los datos.
---

# Bases de datos

## Modelado

- Normalizar por defecto (3FN); desnormalizar solo con medición que lo justifique.
- Integridad en la BD, no solo en la aplicación: `NOT NULL`, `UNIQUE`, `FOREIGN KEY`, `CHECK`.
- Claves primarias sustitutas estables; claves naturales como `UNIQUE`.
- Tipos correctos: decimal exacto para dinero, fecha sin hora para fechas de calendario, timestamp con zona (UTC) para instantes.
- Columnas `creado_en` / `actualizado_en`; `version` para concurrencia optimista cuando haya ediciones concurrentes.
- Borrado lógico solo si hay requisito (auditoría, recuperación); implica filtrar en todas las consultas.
- Datos que no deben cambiar retroactivamente (cálculos cerrados, documentos emitidos): guardar una instantánea de los valores usados, no recalcular desde datos maestros que pueden cambiar.

## Migraciones

- Versionadas, en el repositorio, aplicadas por herramienta (nunca cambios manuales en producción).
- Una migración ya aplicada en un entorno compartido no se edita: se crea otra.
- **Compatibles con la versión anterior en ejecución** (despliegue sin downtime), patrón expandir/contraer:
  1. Agregar columna nullable o con default → desplegar código que escribe en ambas.
  2. Backfill por lotes.
  3. Código lee de la nueva → quitar la antigua en una migración posterior.
- Renombrar = agregar + copiar + eliminar, en pasos separados.
- Operaciones pesadas (índices en tablas grandes, backfills) sin bloquear: usar las opciones concurrentes/online del motor, por lotes.
- Probar migración y rollback contra una copia realista antes de producción.

## Índices y consultas

- Indexar claves foráneas y columnas usadas en filtros, joins y ordenamientos frecuentes.
- Índices compuestos en el orden de uso de las consultas.
- Cada índice cuesta en escrituras y espacio: no indexar "por si acaso".
- Revisar el plan de ejecución (`EXPLAIN`) de consultas críticas.
- Evitar N+1: carga explícita o consultas por lote.
- Paginación en toda consulta que pueda devolver muchas filas.
- Seleccionar columnas necesarias, no `SELECT *` en código de producción.

## Transacciones

- Operaciones que deben ser atómicas van en una transacción; mantenerla corta y sin llamadas de red dentro.
- Conocer el nivel de aislamiento del motor y sus anomalías.
- Efectos externos (correo, eventos) después del commit o con patrón outbox.
- Reintentos solo para errores transitorios (deadlock, serialización) y con operaciones idempotentes.

## Auditoría y datos sensibles

- Tabla o log de auditoría para cambios en datos críticos: quién, cuándo, valor anterior y nuevo.
- Cifrar columnas sensibles cuando la normativa o el riesgo lo requiera.
- Usuarios de BD con mínimo privilegio; la aplicación no usa el superusuario.
- Backups automáticos con restauración **probada** periódicamente.
