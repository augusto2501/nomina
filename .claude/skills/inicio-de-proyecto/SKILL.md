---
name: inicio-de-proyecto
description: Checklist para arrancar un proyecto de software profesional desde cero - estructura del repositorio, herramientas de calidad, configuración, tests, CI, contenedores, documentación y seguridad base. Usar cuando se cree un proyecto o servicio nuevo, o cuando se pida "configurar", "inicializar" o "hacer scaffolding" de un repositorio.
---

# Inicio de proyecto

Antes de elegir tecnología, confirmar requisitos (skill `requisitos`) y registrar las decisiones de stack en ADRs.

## Checklist de arranque

### Repositorio
- [ ] `README.md`, `.gitignore`, `.editorconfig`, `LICENSE` (si aplica).
- [ ] `CLAUDE.md` con comandos del proyecto (build, test, lint, run).
- [ ] Estructura de carpetas por módulo de negocio (skill `arquitectura`).
- [ ] Rama `main` protegida.

### Calidad automatizada
- [ ] Formateador con configuración versionada.
- [ ] Linter con reglas estrictas desde el inicio (más barato que endurecer después).
- [ ] Tipado estático o verificación de tipos si el lenguaje lo permite, en modo estricto.
- [ ] Framework de tests con un primer test que pase; comando único para ejecutar la suite.
- [ ] Hooks de pre-commit (formato, lint, detección de secretos) livianos.

### Configuración
- [ ] Configuración por variables de entorno, validada al arrancar (fallar si falta algo obligatorio).
- [ ] `.env.example` documentado.
- [ ] Sin valores por defecto inseguros para producción.

### Dependencias
- [ ] Lockfile versionado.
- [ ] Versión del runtime fijada (archivo de versión de la herramienta correspondiente).
- [ ] Actualización automatizada de dependencias (bot de dependencias).

### Ejecución local
- [ ] Un comando para levantar dependencias locales (p. ej. compose con BD, colas).
- [ ] Datos semilla para desarrollo, sin datos reales.
- [ ] Migraciones desde el día uno.

### CI/CD (skill `ci-cd`)
- [ ] Pipeline con formato, lint, tipos, tests, escaneo de seguridad y build.
- [ ] Despliegue automatizado a staging.

### Operación (skill `observabilidad`)
- [ ] Logging estructurado.
- [ ] Endpoint de health.
- [ ] Captura de errores.

### Seguridad (skill `seguridad`)
- [ ] Escaneo de secretos y dependencias.
- [ ] Autenticación/autorización definidas antes del primer endpoint de negocio.

## Makefile / scripts estándar

Exponer los mismos nombres de tarea en todos los proyectos, sea con `make`, scripts del gestor de paquetes o `just`:

```
setup     # instala dependencias y prepara el entorno
dev       # levanta la app en modo desarrollo
test      # ejecuta toda la suite
lint      # lint + formato en modo verificación
format    # aplica formato
typecheck # verificación de tipos
build     # genera el artefacto
migrate   # aplica migraciones
```

Esto permite que personas y agentes trabajen igual en cualquier repositorio.
