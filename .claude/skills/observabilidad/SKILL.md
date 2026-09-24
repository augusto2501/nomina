---
name: observabilidad
description: Logging estructurado, métricas, trazas distribuidas, manejo y reporte de errores, health checks y alertas. Usar al agregar logs o métricas, instrumentar servicios, diseñar alertas o preparar una aplicación para operar en producción.
---

# Observabilidad

Objetivo: poder responder "¿qué pasó, a quién, cuándo y por qué?" sin desplegar código nuevo.

## Logs

- Estructurados (JSON) con campos consistentes: `timestamp`, `nivel`, `mensaje`, `servicio`, `entorno`, `traceId`, `usuarioId`/`tenantId` cuando aplique.
- Niveles:
  - `ERROR`: requiere atención; algo falló y no se recuperó.
  - `WARN`: anómalo pero manejado.
  - `INFO`: eventos de negocio relevantes (inicio/fin de procesos, cambios de estado).
  - `DEBUG`: detalle para diagnóstico; desactivado en producción por defecto.
- Loguear una vez en el punto donde se maneja el error, con contexto; no en cada capa.
- **Nunca** loguear contraseñas, tokens, secretos, datos bancarios completos ni datos personales sensibles. Enmascarar.
- Mensajes con contexto útil: IDs de entidades, operación, duración.

## Métricas

- RED para servicios: **R**ate (peticiones/s), **E**rrors (tasa de error), **D**uration (latencia en percentiles, no promedio).
- USE para recursos: **U**tilización, **S**aturación, **E**rrores.
- Métricas de negocio clave (procesos completados, fallidos, en cola).
- Cuidado con la cardinalidad de etiquetas: no usar IDs de usuario ni valores sin límite.

## Trazas

- Propagar un identificador de correlación en todas las llamadas (HTTP, colas, jobs); preferir estándares (W3C Trace Context, OpenTelemetry).
- Spans en llamadas externas y operaciones costosas.

## Errores

- Captura centralizada de excepciones no manejadas con contexto (versión, entorno, usuario, traceId).
- Al cliente: mensaje genérico + traceId. Internamente: detalle completo.

## Health checks

- **Liveness**: el proceso está vivo (no consultar dependencias).
- **Readiness**: puede atender tráfico (dependencias críticas accesibles).

## Alertas

- Alertar sobre síntomas que afectan al usuario (tasa de error, latencia, procesos críticos fallidos), no sobre cada causa.
- Cada alerta debe ser accionable y tener un runbook: qué significa, cómo diagnosticar, cómo mitigar.
- Definir SLOs para servicios críticos y alertar sobre consumo del presupuesto de error.

## Auditoría (distinta de logs técnicos)

Registro inmutable de acciones de negocio sobre datos sensibles: quién, qué, cuándo, desde dónde, valor anterior/nuevo. Retención según requisito legal.
