---
name: arquitectura
description: Diseño de arquitectura y estructura de software - capas, módulos, dependencias, límites de dominio, principios SOLID y decisiones técnicas con trade-offs. Usar al diseñar un sistema o módulo nuevo, al decidir dónde ubicar código, al introducir una dependencia o patrón, o cuando el usuario pida evaluar o proponer una arquitectura.
---

# Arquitectura y diseño

## Principios

- **Simplicidad primero**: la arquitectura más simple que cumpla los requisitos actuales y los previsibles. No diseñar para escenarios hipotéticos (YAGNI).
- **Alta cohesión, bajo acoplamiento**: lo que cambia junto vive junto; los módulos se comunican por interfaces pequeñas.
- **Dependencias hacia el dominio**: la lógica de negocio no depende de frameworks, base de datos ni HTTP. La infraestructura depende del dominio, no al revés.
- **Límites explícitos**: cada módulo expone una API pública mínima; el resto es privado.
- **Decisiones reversibles baratas, irreversibles con cuidado**: esquema de datos, contratos públicos, proveedor de nube y lenguaje merecen un ADR.

## Estructura por defecto (monolito modular)

Empezar con un monolito modular salvo razón concreta (escalado independiente probado, equipos autónomos, requisitos de aislamiento). Los microservicios añaden red, consistencia eventual, despliegue y observabilidad distribuida: su costo es alto y se paga desde el día uno.

```
src/
  <modulo>/            # organizado por capacidad de negocio, no por tipo técnico
    dominio/           # entidades, value objects, reglas; sin I/O
    aplicacion/        # casos de uso; orquesta dominio y puertos
    infraestructura/   # adaptadores: BD, HTTP, colas, servicios externos
    api/               # controladores / handlers; traduce transporte <-> casos de uso
  compartido/          # solo lo verdaderamente transversal (evitar el "utils" vertedero)
```

Adaptar nombres a las convenciones del lenguaje y del proyecto existente. Si el proyecto ya tiene una estructura, seguirla.

## SOLID aplicado (sin dogma)

- **S**: una razón para cambiar por clase/módulo. Señal de violación: nombres con "Manager", "Helper", "And".
- **O**: extender por composición o estrategia cuando haya variación real, no anticipada.
- **L**: los subtipos no deben sorprender a quien usa el tipo base.
- **I**: interfaces pequeñas definidas por quien las consume.
- **D**: depender de abstracciones en los límites (BD, reloj, red, aleatoriedad) para poder testear.

## Modelado de dominio

- Usar el lenguaje del negocio en nombres de clases, métodos y tablas.
- **Value objects** para conceptos con reglas (Dinero, Periodo, Email, Identificación). Validan en su construcción; son inmutables.
- **Dinero**: nunca `float`. Usar decimales de precisión fija o enteros en la unidad mínima, con moneda explícita y regla de redondeo documentada.
- **Fechas**: guardar instantes en UTC; usar tipos de fecha sin hora para conceptos de calendario (fecha de ingreso, periodo).
- Invariantes dentro de la entidad, no dispersas en controladores.

## Evaluar una decisión técnica

Para cada alternativa relevante (mínimo dos):

| Criterio | Opción A | Opción B |
|----------|----------|----------|
| Complejidad operativa | | |
| Curva de aprendizaje del equipo | | |
| Costo | | |
| Riesgo / madurez | | |
| Reversibilidad | | |
| Ajuste a requisitos no funcionales | | |

Recomendar una, explicar por qué, y registrar la decisión en un ADR si es difícil de revertir.

## Señales de alerta

- Lógica de negocio en controladores, vistas o consultas SQL.
- Dependencias circulares entre módulos.
- Un cambio simple obliga a tocar muchos archivos en módulos distintos.
- Abstracciones con una sola implementación sin razón de test o de límite.
- Estado global mutable; singletons con I/O.
