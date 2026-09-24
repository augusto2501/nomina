---
description: Verifica que la rama está lista y redacta commit(s) y descripción del pull request
argument-hint: [rama base, por defecto main]
---

Rama base: $ARGUMENTS (si está vacío, usa `main`).

1. Ejecuta lint, formato, typecheck y tests del proyecto (ver comandos en `CLAUDE.md`). Reporta resultados reales; si algo falla, detente y muéstralo.
2. Revisa `git status` y `git diff <base>...HEAD`: archivos accidentales, código de depuración, secretos, cambios no relacionados.
3. Verifica la definición de terminado de `.claude/skills/flujo-de-desarrollo/SKILL.md`.
4. Propón mensajes de commit según `.claude/skills/git-y-versionado/SKILL.md`.
5. Redacta la descripción del PR usando `.claude/skills/git-y-versionado/plantilla-pr.md`.

No hagas push ni crees el PR sin mi confirmación.
