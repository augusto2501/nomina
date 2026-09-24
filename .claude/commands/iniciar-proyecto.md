---
description: Inicializa un proyecto nuevo con estructura, calidad automatizada, CI y documentación base
argument-hint: <tipo de aplicación y stack deseado>
---

Proyecto a iniciar: $ARGUMENTS

1. Si el stack o el tipo de aplicación no están claros, pregúntame antes de generar nada. Si hay decisiones de stack relevantes, compara alternativas y recomiéndame una.
2. Aplica el checklist de `.claude/skills/inicio-de-proyecto/SKILL.md` completo.
3. Estructura por módulos según `.claude/skills/arquitectura/SKILL.md`.
4. Crea las tareas estándar (`setup`, `dev`, `test`, `lint`, `format`, `typecheck`, `build`, `migrate`).
5. Pipeline de CI según `.claude/skills/ci-cd/SKILL.md`.
6. Registra las decisiones de stack como ADR en `docs/adr/`.
7. Completa la sección "Proyecto" de `CLAUDE.md` con stack y comandos reales.
8. Verifica que `setup`, `lint` y `test` se ejecutan correctamente y reporta el resultado.
