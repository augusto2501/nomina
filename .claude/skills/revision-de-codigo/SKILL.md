---
name: revision-de-codigo
description: Checklist de revisión de código (code review) para cambios propios o ajenos - corrección, diseño, tests, seguridad, rendimiento y mantenibilidad. Usar antes de hacer commit o abrir un PR, o cuando el usuario pida revisar un diff, PR o archivo.
---

# Revisión de código

Revisar con mirada adversarial: buscar cómo se rompe, no confirmar que funciona.

## Orden de revisión (de mayor a menor impacto)

1. **Corrección**
   - ¿Hace lo que pide el requisito? ¿Cumple los criterios de aceptación?
   - Casos borde: nulos, vacíos, límites, errores de redondeo, zonas horarias.
   - Concurrencia: condiciones de carrera, doble procesamiento, transacciones.
   - Manejo de errores: ¿se propagan o se ocultan?
2. **Seguridad** (ver skill `seguridad`)
   - Entrada no validada, inyección, autorización faltante, secretos, datos sensibles en logs.
3. **Datos**
   - Migraciones reversibles y compatibles con la versión anterior en ejecución.
   - Pérdida de datos, índices faltantes, consultas N+1.
4. **Tests**
   - ¿Cubren el cambio? ¿Fallarían si el código estuviera mal? ¿Son deterministas?
5. **Diseño**
   - ¿Respeta límites de módulos y convenciones existentes? ¿Reutiliza lo que ya hay?
   - ¿Hay complejidad o abstracción innecesaria?
6. **Legibilidad**
   - Nombres, tamaño de funciones, comentarios del *por qué*.
7. **Operación**
   - Logs y métricas suficientes para diagnosticar; configuración nueva documentada; feature flags si el riesgo lo amerita.

## Cómo reportar hallazgos

Clasificar cada hallazgo:

- **Bloqueante**: bug, vulnerabilidad, pérdida de datos, contrato roto.
- **Importante**: problema de diseño o test faltante que conviene resolver ahora.
- **Sugerencia / nit**: estilo o mejora opcional.

Para cada uno: ubicación (`archivo:línea`), qué pasa, escenario concreto que lo dispara y propuesta. Sin escenario concreto, es opinión: marcarlo como tal.

## Autorrevisión antes de commit

- [ ] Leí el diff completo, no solo los archivos que recuerdo.
- [ ] Sin código de depuración, comentarios obsoletos ni archivos accidentales.
- [ ] Sin cambios no relacionados mezclados.
- [ ] Lint, formato, typecheck y tests pasan.
- [ ] El mensaje de commit explica el por qué.
