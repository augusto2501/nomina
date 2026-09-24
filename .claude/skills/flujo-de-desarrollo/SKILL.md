---
name: flujo-de-desarrollo
description: Ciclo de trabajo estándar para cualquier cambio de software (feature, bugfix, refactor) de principio a fin. Usar al iniciar una tarea de desarrollo no trivial, cuando el usuario pida "implementa", "agrega", "construye" algo, o cuando no esté claro qué skill aplicar. Indica qué skill específico usar en cada fase.
---

# Flujo de desarrollo

Proceso por defecto para cualquier cambio. Escalar el rigor al tamaño del cambio: un typo no necesita diseño; una funcionalidad nueva sí.

## Fases

1. **Entender** → skill `requisitos`
   - Reformular el objetivo en una frase. Si no se puede, falta información: preguntar.
   - Definir criterios de aceptación verificables antes de escribir código.
   - Identificar qué NO entra en el alcance.

2. **Explorar el código existente**
   - Leer cómo el proyecto ya resuelve problemas similares. Reutilizar patrones, utilidades y convenciones existentes antes de crear nuevos.
   - Localizar tests existentes del área afectada.

3. **Diseñar** → skills `arquitectura`, `diseno-de-apis`, `base-de-datos`
   - Solo si el cambio toca límites de módulos, contratos públicos, esquema de datos o introduce dependencias.
   - Decisiones difíciles de revertir → registrar un ADR (skill `documentacion`).

4. **Implementar** → skills `codigo-limpio`, `testing`, `seguridad`
   - Pasos pequeños, cada uno compilable y con tests en verde.
   - Escribir o actualizar tests junto con el código, no al final.
   - No mezclar refactor con cambio de comportamiento en el mismo commit (skill `refactorizacion`).

5. **Verificar**
   - Ejecutar lint, formato, typecheck y tests del proyecto. Reportar resultados reales, incluidos fallos.
   - Probar el camino feliz y al menos los casos de error principales.

6. **Revisar** → skill `revision-de-codigo`
   - Autorrevisión del diff completo antes de commit, con mirada adversarial.

7. **Integrar** → skills `git-y-versionado`, `ci-cd`
   - Commits atómicos con mensaje convencional. PR con contexto suficiente para revisar sin preguntar.

8. **Operar** → skill `observabilidad`
   - El cambio debe poder diagnosticarse en producción: logs, métricas, errores con contexto.

## Definición de terminado (DoD)

- [ ] Criterios de aceptación cumplidos y verificados.
- [ ] Tests nuevos/actualizados; toda la suite en verde.
- [ ] Lint, formato y typecheck limpios.
- [ ] Sin secretos, credenciales ni datos personales en el código o logs.
- [ ] Documentación actualizada si cambió comportamiento visible, configuración o contratos.
- [ ] Migraciones reversibles o con plan de rollback, si aplica.
- [ ] Diff revisado; sin código muerto, `TODO` sin ticket ni logs de depuración.

## Cuándo detenerse y preguntar

- Requisitos contradictorios o ambiguos que cambian el diseño.
- El cambio exige romper un contrato público, borrar datos o migraciones destructivas.
- La solución correcta es mucho más grande que lo pedido.
