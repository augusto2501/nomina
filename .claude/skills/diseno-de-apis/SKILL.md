---
name: diseno-de-apis
description: Diseño de APIs HTTP/REST y contratos entre sistemas - recursos, verbos, códigos de estado, errores, paginación, versionado, idempotencia y documentación OpenAPI. Usar al crear o modificar endpoints, contratos entre servicios o integraciones.
---

# Diseño de APIs

## Recursos y verbos

- Recursos en sustantivo plural: `/empleados`, `/empleados/{id}/contratos`.
- `GET` lee (seguro, idempotente), `POST` crea o ejecuta acciones, `PUT` reemplaza (idempotente), `PATCH` modifica parcialmente, `DELETE` elimina (idempotente).
- Acciones que no encajan en CRUD: sub-recurso explícito (`POST /nominas/{id}/aprobacion`).
- Anidar máximo un nivel.
- Convención de nombres de campos consistente en toda la API.

## Códigos de estado

| Código | Uso |
|--------|-----|
| 200 | OK con cuerpo |
| 201 | Creado (+ `Location`) |
| 204 | OK sin cuerpo |
| 400 | Petición malformada |
| 401 | No autenticado |
| 403 | Autenticado sin permiso |
| 404 | No existe (o no debe revelarse que existe) |
| 409 | Conflicto de estado / versión |
| 422 | Validación de negocio fallida |
| 429 | Rate limit |
| 5xx | Fallo del servidor; nunca por error del cliente |

## Errores

Formato único en toda la API (p. ej. RFC 9457 Problem Details):

```json
{
  "type": "https://ejemplo.com/errores/validacion",
  "title": "Datos inválidos",
  "status": 422,
  "detail": "El periodo de fin es anterior al de inicio",
  "errors": [{ "campo": "fechaFin", "mensaje": "Debe ser posterior a fechaInicio" }],
  "traceId": "..."
}
```

Sin stack traces ni detalles internos. Incluir un identificador de correlación.

## Colecciones

- Paginación obligatoria con límite máximo. Cursor para colecciones grandes o que cambian; offset aceptable en listados pequeños.
- Filtros y ordenamiento explícitos y documentados; allowlist de campos ordenables.

## Idempotencia y concurrencia

- `POST` con efectos no repetibles (pagos, envíos, cierres de periodo): aceptar `Idempotency-Key`.
- Control de concurrencia optimista con `ETag`/`If-Match` o campo de versión → `409`/`412` en conflicto.

## Versionado y compatibilidad

- Cambios compatibles (agregar campos opcionales, endpoints nuevos) no requieren versión nueva.
- Cambios incompatibles (quitar/renombrar campos, cambiar tipos o semántica) requieren versión nueva y periodo de deprecación comunicado.
- Los clientes deben ignorar campos desconocidos.

## Contrato y documentación

- Especificación OpenAPI versionada junto al código, generada o validada en CI.
- Ejemplos de request/response y de errores para cada endpoint.
- Tests de contrato para APIs consumidas por otros equipos o servicios.

## Seguridad

Autenticación en todos los endpoints salvo excepción explícita, autorización por recurso, rate limiting, tamaño máximo de payload, validación de entrada (ver skill `seguridad`).
