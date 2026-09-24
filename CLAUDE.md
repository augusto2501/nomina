# CLAUDE.md

Guía para agentes de IA (Claude Code) que trabajan en este repositorio.

## Proyecto

> Completar al definir el stack (el comando `/iniciar-proyecto` lo hace automáticamente).

- **Qué es**: nomina (por definir).
- **Stack**: por definir.
- **Comandos**:
  - Instalar: `make setup`
  - Desarrollo: `make dev`
  - Tests: `make test`
  - Lint / formato: `make lint` / `make format`
  - Tipos: `make typecheck`
  - Build: `make build`
  - Migraciones: `make migrate`

## Reglas de trabajo

1. Seguir el flujo de `.claude/skills/flujo-de-desarrollo/SKILL.md` en cualquier cambio no trivial.
2. Seguir las convenciones del código existente antes que preferencias propias.
3. Si un requisito es ambiguo y cambia el diseño, preguntar. No inventar reglas de negocio; marcar supuestos como tales.
4. Tests junto con el código. Un bug se corrige con un test que primero falla.
5. Antes de dar algo por terminado: lint, formato, typecheck y tests en verde. Reportar resultados reales, incluidos fallos.
6. Nunca: commitear secretos, desactivar tests para pasar CI, reescribir historia compartida, push directo a `main`.
7. Cambios en esquema de datos, contratos públicos o nuevas dependencias: proponer y esperar confirmación.
8. Commits convencionales en español o inglés (consistente con el historial).

## Skills (`.claude/skills/`)

| Skill | Cuándo |
|-------|--------|
| `flujo-de-desarrollo` | Punto de entrada para cualquier tarea de desarrollo |
| `requisitos` | Historias, criterios de aceptación, casos borde |
| `arquitectura` | Estructura, módulos, dependencias, decisiones técnicas |
| `codigo-limpio` | Escribir o modificar código |
| `testing` | Estrategia y escritura de tests |
| `revision-de-codigo` | Revisar diffs y PRs |
| `seguridad` | Entrada, auth, permisos, secretos, datos sensibles |
| `diseno-de-apis` | Endpoints y contratos |
| `base-de-datos` | Esquema, migraciones, consultas |
| `git-y-versionado` | Ramas, commits, PRs, releases |
| `ci-cd` | Pipelines y despliegue |
| `observabilidad` | Logs, métricas, trazas, alertas |
| `documentacion` | README, ADR, runbooks |
| `inicio-de-proyecto` | Arrancar un proyecto nuevo |
| `depuracion` | Bugs y errores |
| `rendimiento` | Lentitud y optimización |
| `refactorizacion` | Mejorar código sin cambiar comportamiento |

## Subagentes (`.claude/agents/`)

| Agente | Rol | Escribe código |
|--------|-----|----------------|
| `arquitecto` | Plan de implementación y trade-offs | No |
| `revisor-codigo` | Revisión de calidad del diff | No |
| `auditor-seguridad` | Revisión de seguridad | No |
| `ingeniero-tests` | Escribe y ejecuta tests | Sí (tests) |
| `depurador` | Causa raíz y fix de bugs | Sí |
| `documentador` | Documentación a partir del código | Sí (docs) |

Delegar tareas independientes a subagentes en paralelo (p. ej. revisión + auditoría).

## Comandos (`.claude/commands/`)

- `/nueva-funcionalidad <descripción>`: flujo completo requisitos → diseño → código → tests → revisión.
- `/corregir-bug <descripción>`: reproducción, causa raíz, fix y test de regresión.
- `/revisar [base|ruta]`: revisión de calidad y seguridad en paralelo.
- `/preparar-pr [base]`: verificación final, commits y descripción del PR.
- `/iniciar-proyecto <stack>`: scaffolding profesional de un proyecto nuevo.
- `/adr <decisión>`: registrar una decisión de arquitectura.

## Guardarraíles (`.claude/settings.json` + `.claude/hooks/`)

- Bloqueo de escritura en archivos de secretos (`.env`, claves, certificados).
- Bloqueo de `git push --force`, push directo a `main`/`master`, `git reset --hard`, `rm -rf` sobre raíz/home y `DROP DATABASE`/`TRUNCATE`.
- Denegación de lectura de `.env` y claves.
- Los hooks detectan patrones en el texto del comando: pueden dar falsos positivos si el patrón aparece dentro de un string.

Preferencias personales o locales: `.claude/settings.local.json` (no versionado).
