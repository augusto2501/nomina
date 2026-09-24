---
name: depuracion
description: Metodología sistemática de depuración para encontrar la causa raíz de bugs, errores en producción, tests que fallan o comportamiento inesperado. Usar cuando algo no funciona, hay un error, stack trace, regresión o test en rojo.
---

# Depuración

Objetivo: encontrar la **causa raíz**, no silenciar el síntoma.

## Proceso

1. **Reproducir**
   - Obtener el error exacto (mensaje, stack trace, logs, entrada, versión, entorno).
   - Reproducir de forma confiable. Si no se reproduce, recolectar más datos antes de cambiar código.
   - Convertir la reproducción en un test que falle.

2. **Acotar**
   - ¿Desde cuándo? Comparar con la última versión buena (`git bisect` si hay historia).
   - ¿Qué cambió? Código, datos, configuración, dependencias, entorno, carga.
   - Reducir la entrada al caso mínimo que falla.

3. **Formular hipótesis**
   - Una hipótesis concreta y falsable a la vez: "falla porque X es nulo cuando Y".
   - Predecir qué se observará si es cierta.

4. **Verificar**
   - Confirmar con evidencia (logs, depurador, aserción, test), no por intuición.
   - Si la evidencia contradice la hipótesis, descartarla aunque parezca obvia.

5. **Corregir**
   - Arreglar la causa, no el síntoma. Un `try/catch`, un `if (x != null)` o un reintento que oculta el problema no es un fix.
   - Buscar el mismo patrón de error en otras partes del código.

6. **Prevenir**
   - El test de reproducción queda en la suite.
   - Si fue difícil de diagnosticar, mejorar logs o validaciones para la próxima vez.

## Errores comunes

- Cambiar varias cosas a la vez: no se sabe qué lo arregló.
- Asumir que el bug está en el código recién escrito y no mirar datos o configuración.
- Leer el mensaje de error por encima. Leerlo completo, incluida la causa anidada.
- Declarar resuelto sin volver a ejecutar la reproducción original.

## Reportar

Causa raíz, evidencia, fix aplicado, test agregado, y si hay otros lugares afectados.
