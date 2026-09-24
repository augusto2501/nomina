---
name: ci-cd
description: Integración y entrega continua - pipelines, quality gates, builds reproducibles, estrategias de despliegue, entornos, feature flags y rollback. Usar al crear o modificar pipelines de CI/CD, configurar despliegues o diagnosticar fallos de CI.
---

# CI/CD

## Pipeline de CI (en cada PR y en `main`)

Orden sugerido, fallando rápido:

1. Instalación con lockfile y caché de dependencias.
2. Formato y lint.
3. Typecheck / compilación.
4. Tests unitarios.
5. Tests de integración (servicios en contenedores).
6. Seguridad: escaneo de secretos, de dependencias (SCA) y análisis estático (SAST).
7. Build del artefacto (imagen de contenedor, paquete).
8. Tests end-to-end sobre el artefacto (en `main` o previo a release, si son lentos).

Quality gates: cualquier paso en rojo bloquea el merge. No desactivar ni saltar tests para pasar CI.

## Builds reproducibles

- Versiones fijadas: runtime, dependencias (lockfile), imágenes base (tag concreto o digest).
- El mismo artefacto se promueve entre entornos; no se recompila por entorno.
- Configuración por variables de entorno, no por builds distintos.

## Entornos

- Mínimo: local, staging (lo más parecido a producción) y producción.
- Datos de producción no se copian a entornos inferiores sin anonimizar.
- Infraestructura como código versionada.

## Despliegue

- Automatizado desde `main` o por tag. Nada de despliegues manuales a mano en servidores.
- Estrategias según riesgo: rolling, blue/green, canary.
- Migraciones de BD compatibles con la versión anterior (skill `base-de-datos`), ejecutadas como paso controlado del despliegue.
- Health checks (liveness/readiness) para que el orquestador sepa cuándo enrutar tráfico.
- **Rollback** probado y rápido: volver al artefacto anterior.
- Feature flags para desacoplar despliegue de lanzamiento en cambios riesgosos; eliminarlos cuando dejen de ser necesarios.

## Diagnóstico de CI en rojo

1. Leer el log real del paso que falló, no adivinar.
2. Reproducir localmente con el mismo comando y versiones.
3. Determinar si lo causó el cambio o ya fallaba en `main`.
4. "Flaky" no es una causa: encontrar la real (skill `testing`).
5. Corregir y verificar localmente antes de volver a hacer push.

## Secretos en CI

Usar el gestor de secretos de la plataforma; mínimo privilegio; nunca imprimirlos en logs; preferir credenciales de corta duración (OIDC) frente a claves estáticas.
