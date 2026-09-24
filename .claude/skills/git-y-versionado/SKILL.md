---
name: git-y-versionado
description: Flujo de trabajo con git - ramas, commits convencionales, pull requests, versionado semántico y changelog. Usar al crear ramas, escribir mensajes de commit, preparar o describir un pull request, o publicar una versión.
---

# Git y versionado

## Ramas

- Trunk-based por defecto: `main` siempre desplegable; ramas cortas (horas a pocos días).
- Nombres: `feat/<descripcion>`, `fix/<descripcion>`, `refactor/...`, `chore/...`, `docs/...`.
- Protección de `main`: PR obligatorio, CI en verde, al menos una revisión.
- Nunca reescribir historia de ramas compartidas (`rebase`/`push --force` solo en ramas propias no compartidas).

## Commits (Conventional Commits)

```
<tipo>(<ámbito opcional>): <resumen imperativo, ≤ 72 caracteres>

<cuerpo: por qué se hace el cambio y contexto no obvio>

<footer: BREAKING CHANGE: ..., Refs: #123>
```

Tipos: `feat`, `fix`, `refactor`, `perf`, `test`, `docs`, `build`, `ci`, `chore`.

- Un commit = un cambio lógico que compila y pasa tests.
- El resumen dice *qué*; el cuerpo explica *por qué*.
- No mezclar formato masivo o refactor con cambios de comportamiento.
- Nunca commitear secretos, archivos generados, dependencias instaladas ni archivos locales del IDE.

## Pull requests

- Pequeños y enfocados; si superan unos cientos de líneas relevantes, considerar dividir.
- Descripción con: qué cambia, por qué, cómo se probó, riesgos, pasos de despliegue o migración, capturas si hay UI. Ver [plantilla-pr.md](plantilla-pr.md).
- El autor se revisa primero (skill `revision-de-codigo`).
- Responder cada comentario: aplicado, o por qué no.

## Versionado semántico (SemVer)

`MAYOR.MENOR.PARCHE`
- MAYOR: cambios incompatibles en la API pública.
- MENOR: funcionalidad nueva compatible.
- PARCHE: correcciones compatibles.

Etiquetar releases (`vX.Y.Z`). Mantener `CHANGELOG.md` (formato Keep a Changelog), idealmente generado a partir de commits convencionales.

## .gitignore mínimo

Dependencias instaladas, artefactos de build, cobertura, `.env*` (excepto `.env.example`), logs, archivos de IDE y del sistema operativo.
