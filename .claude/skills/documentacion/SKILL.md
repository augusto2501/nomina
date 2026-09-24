---
name: documentacion
description: Documentación técnica del proyecto - README, ADR (Architecture Decision Records), guías de contribución, runbooks, changelog y documentación de API. Usar al crear o actualizar documentación, al tomar una decisión arquitectónica relevante, o cuando cambie cómo se instala, configura, ejecuta o despliega el proyecto.
---

# Documentación

Documentar lo que no se deduce del código y lo que alguien nuevo necesita para ser productivo. La documentación desactualizada es peor que ninguna: actualizarla en el mismo PR que el cambio.

## Documentos por proyecto

| Documento | Propósito |
|-----------|-----------|
| `README.md` | Qué es, cómo instalar, configurar, ejecutar y testear en local |
| `CONTRIBUTING.md` | Flujo de ramas, convenciones, cómo abrir un PR |
| `docs/adr/NNNN-titulo.md` | Decisiones de arquitectura y su contexto |
| `docs/runbooks/` | Cómo operar, diagnosticar y recuperar en producción |
| `CHANGELOG.md` | Cambios por versión |
| `.env.example` | Todas las variables de entorno con descripción, sin valores reales |
| OpenAPI | Contrato de la API |
| `CLAUDE.md` | Contexto y comandos para agentes de IA |

## README

Estructura mínima: descripción en 2-3 líneas, requisitos previos (versiones), instalación, configuración, ejecución local, tests, estructura del proyecto, despliegue, enlaces a docs adicionales.

Criterio de calidad: una persona nueva puede ejecutar el proyecto siguiendo solo el README.

## ADR

Registrar cuando la decisión sea difícil de revertir, afecte a varios módulos o equipos, o haya alternativas razonables descartadas.

Plantilla: [plantilla-adr.md](plantilla-adr.md). Los ADR no se editan tras aceptarse; se reemplazan con uno nuevo que los marque como "Sustituido por".

## Comentarios en código

Explican el *por qué*: reglas de negocio con su fuente (norma, ticket, decisión), workarounds con referencia al problema, decisiones de rendimiento no obvias.

## Runbook

Por cada alerta o proceso operativo crítico: síntoma, impacto, diagnóstico paso a paso, mitigación, escalamiento.
