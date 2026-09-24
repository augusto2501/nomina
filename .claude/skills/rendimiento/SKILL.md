---
name: rendimiento
description: Análisis y optimización de rendimiento - medición, profiling, consultas lentas, caché, concurrencia, procesamiento por lotes y pruebas de carga. Usar cuando algo sea lento, consuma demasiados recursos, al procesar grandes volúmenes o cuando se pida optimizar.
---

# Rendimiento

## Reglas

1. **Medir antes de optimizar.** Sin medición, la optimización es una suposición.
2. Optimizar el cuello de botella real (profiling), no lo que parece lento.
3. Definir el objetivo en cifras (p. ej. p95 < X ms, lote de N registros en < T minutos) antes de empezar.
4. Medir después para confirmar la mejora y verificar que el comportamiento no cambió (tests).

## Causas frecuentes, en orden de probabilidad

1. **Base de datos**: N+1, índices faltantes, traer más filas/columnas de las necesarias, transacciones largas.
2. **I/O en serie**: llamadas de red secuenciales que podrían ser paralelas o por lote.
3. **Algoritmos**: complejidad cuadrática oculta (búsquedas en listas dentro de bucles → usar mapas/sets).
4. **Serialización** y payloads excesivos.
5. **Memoria**: cargar colecciones enteras en lugar de procesar en streaming o por lotes.

## Técnicas

- **Procesamiento por lotes**: para volúmenes grandes, procesar en lotes con tamaño configurable, idempotente y reanudable; registrar progreso.
- **Caché**: solo con estrategia clara de invalidación y tiempo de vida. Definir qué pasa si el dato cacheado está desactualizado. No cachear datos por usuario en cachés compartidas sin clave de usuario.
- **Trabajo asíncrono**: mover tareas lentas fuera de la petición (colas, jobs) con reintentos y manejo de fallos.
- **Paginación y límites** en toda respuesta de tamaño variable.
- **Pools de conexiones** dimensionados; timeouts en toda llamada externa.

## Pruebas de carga

- Escenarios realistas (mezcla de operaciones, volumen de datos parecido a producción).
- Medir percentiles (p50, p95, p99), tasa de error y saturación de recursos.
- Ejecutar antes de lanzamientos importantes y de picos de uso conocidos.

## Trade-off

Toda optimización añade complejidad. Si la mejora no cambia la experiencia del usuario ni el costo de forma apreciable, no vale la pena.
