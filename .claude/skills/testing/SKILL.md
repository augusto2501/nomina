---
name: testing
description: Estrategia y práctica de pruebas de software - pirámide de tests, TDD, tests unitarios, de integración, end-to-end, de contrato, dobles de prueba, cobertura y tests frágiles. Usar al escribir o revisar tests, al corregir un bug, al diseñar la estrategia de pruebas de un proyecto, o cuando un test falle o sea inestable.
---

# Testing

## Qué garantiza un buen test

- Falla cuando el comportamiento se rompe y **solo** entonces.
- Prueba comportamiento observable, no detalles de implementación.
- Es determinista, rápido, independiente del orden y legible como especificación.

## Pirámide (proporción orientativa)

| Nivel | Qué cubre | Cantidad | Velocidad |
|-------|-----------|----------|-----------|
| Unitario | Lógica de dominio y funciones puras | Muchos | ms |
| Integración | Adaptadores reales: BD, colas, HTTP, serialización | Moderados | s |
| Contrato | Acuerdos entre servicios / API pública | Por contrato | s |
| End-to-end | Flujos críticos de usuario completos | Pocos | s-min |

La lógica de negocio crítica (cálculos, reglas, permisos) debe tener cobertura unitaria exhaustiva de casos y límites.

## Estructura: Arrange / Act / Assert

```
test "<comportamiento esperado> cuando <condición>":
    # Arrange: datos mínimos y explícitos
    # Act: una sola acción
    # Assert: resultado observable
```

- Nombre del test = especificación: `rechaza_pago_cuando_saldo_insuficiente`.
- Un comportamiento por test (puede tener varias aserciones sobre ese comportamiento).
- Datos de prueba mínimos; usar builders/factories con valores por defecto sensatos.
- Tests parametrizados para tablas de casos (límites, redondeos, rangos).

## TDD cuando conviene

Ciclo rojo → verde → refactor. Especialmente útil para lógica de dominio, cálculos y corrección de bugs.

**Regla para bugs**: primero un test que reproduzca el fallo (rojo), luego el fix (verde). Sin excepción salvo imposibilidad técnica documentada.

## Dobles de prueba

- Mockear solo lo que se controla mal: red, reloj, aleatoriedad, servicios de terceros, envío de correos.
- No mockear lo que se posee y es barato de usar real (value objects, lógica pura).
- Para BD, preferir una instancia real efímera (contenedor o en memoria compatible) en tests de integración, en lugar de mockear el ORM.
- Inyectar el reloj y los generadores de IDs para tests deterministas.
- Exceso de mocks = señal de diseño acoplado.

## Cobertura

- Métrica de apoyo, no objetivo. Alta cobertura con aserciones débiles no vale nada.
- Revisar qué ramas críticas **no** están cubiertas, no el porcentaje global.
- Considerar mutation testing para lógica crítica si el ecosistema lo soporta.

## Tests inestables (flaky)

Un test flaky es un bug. Causas típicas: dependencia del orden, tiempo real, sleeps, estado compartido, red, concurrencia, zona horaria o locale del entorno. Corregir la causa; nunca desactivar ni reintentar para ocultarlo.

## Checklist por cambio

- [ ] Camino feliz.
- [ ] Errores de validación y reglas de negocio incumplidas.
- [ ] Límites (0, 1, máximo, vacío, nulo).
- [ ] Permisos (acceso denegado).
- [ ] Idempotencia/concurrencia si aplica.
- [ ] Regresión del bug corregido.
- [ ] La suite completa pasa localmente antes de hacer push.
