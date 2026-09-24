---
description: Corrige un bug encontrando la causa raíz, con test de regresión
argument-hint: <descripción del bug, error o stack trace>
---

Corrige este bug: $ARGUMENTS

1. Delega en el subagente `depurador` para reproducir, escribir un test que falle y encontrar la causa raíz.
2. Revisa su diagnóstico: ¿la evidencia sostiene la causa? Si no, pide más investigación.
3. Aplica el fix mínimo en la causa raíz (si el depurador no lo aplicó).
4. Confirma que el test de regresión pasa y que la suite completa sigue en verde.
5. Delega en `revisor-codigo` la revisión del diff.
6. Resume: causa raíz, fix, test agregado, resultado de tests y otros lugares con el mismo patrón. Propón el mensaje de commit `fix(...)`.
