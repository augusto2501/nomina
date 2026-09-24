---
name: refactorizacion
description: Refactorización segura de código existente - cambiar estructura sin cambiar comportamiento, con red de tests y pasos pequeños. Usar al mejorar código heredado, reducir deuda técnica, extraer módulos o cuando se pida "limpiar" o "reorganizar" código.
---

# Refactorización

Refactorizar = cambiar la estructura **sin cambiar el comportamiento observable**.

## Precondiciones

- Tests que cubran el comportamiento del código a tocar. Si no existen, escribir primero tests de caracterización que fijen el comportamiento actual (incluso si parece incorrecto; corregirlo es otro cambio).
- Objetivo concreto: qué se quiere facilitar (un cambio próximo, legibilidad, eliminar duplicación). "Dejarlo más bonito" no es objetivo suficiente.

## Proceso

1. Pasos pequeños; tests en verde después de cada uno.
2. Un tipo de transformación por commit (renombrar, extraer función, mover módulo, etc.).
3. **Nunca** mezclar refactor y cambio de comportamiento en el mismo commit.
4. Preferir refactorizaciones automáticas del IDE/herramientas cuando existan.
5. Si los tests se rompen, revertir el paso y hacerlo más pequeño.

## Refactorizaciones frecuentes

- Extraer función / renombrar para revelar intención.
- Reemplazar condicionales repetidos por polimorfismo o tabla de decisión.
- Introducir value object para primitivos con reglas.
- Separar lógica pura de I/O.
- Mover código al módulo que posee los datos que usa.
- Eliminar código muerto (verificar que realmente no se usa: búsqueda, reflexión, configuración).

## Código heredado grande

- Patrón estrangulador (strangler fig): construir lo nuevo al lado, desviar tráfico gradualmente, retirar lo viejo.
- Refactorizar la zona que se va a modificar, no todo el sistema ("regla del boy scout" acotada).
- Registrar la deuda técnica restante en tickets con impacto concreto.

## Alcance

No refactorizar oportunistamente fuera del alcance de la tarea sin acordarlo: aumenta el riesgo y dificulta la revisión. Proponerlo como cambio separado.
