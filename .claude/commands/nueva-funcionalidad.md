---
description: Implementa una funcionalidad completa siguiendo el flujo profesional (requisitos, diseño, implementación, tests, revisión)
argument-hint: <descripción de la funcionalidad>
---

Implementa esta funcionalidad: $ARGUMENTS

Sigue `.claude/skills/flujo-de-desarrollo/SKILL.md`:

1. **Requisitos**: aplica el skill `requisitos`. Redacta historia y criterios de aceptación. Si hay ambigüedades que cambien el diseño, pregúntame antes de seguir. Separa hechos de supuestos.
2. **Diseño**: delega en el subagente `arquitecto` para obtener el plan. Muéstrame el plan y espera mi confirmación si el cambio toca esquema de datos, contratos públicos o agrega dependencias.
3. **Implementación**: sigue el plan en pasos pequeños, aplicando `codigo-limpio` y `seguridad`. Escribe tests junto con el código.
4. **Tests**: delega en `ingeniero-tests` para completar casos borde. Ejecuta la suite completa.
5. **Revisión**: lanza en paralelo `revisor-codigo` y `auditor-seguridad` sobre el diff. Corrige los hallazgos bloqueantes e importantes.
6. **Cierre**: verifica la definición de terminado y resume: qué se hizo, cómo se probó (resultados reales), riesgos y pendientes. Propón el mensaje de commit convencional.
