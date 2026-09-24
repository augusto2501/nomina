---
description: Revisión completa (calidad + seguridad) de los cambios actuales o de una rama/ruta
argument-hint: [rama base, ruta o vacío para cambios sin commitear]
---

Alcance de la revisión: $ARGUMENTS
(Si está vacío: cambios sin commitear y staged. Si es una rama: `git diff <rama>...HEAD`.)

Lanza en paralelo:
- Subagente `revisor-codigo` sobre ese alcance.
- Subagente `auditor-seguridad` sobre ese alcance.

Luego consolida en un único informe, sin duplicados, ordenado por severidad:
- Bloqueantes
- Importantes
- Sugerencias

Cada hallazgo con `archivo:línea`, escenario y propuesta. Termina con veredicto y pregúntame si aplico las correcciones.
