---
name: requisitos
description: Análisis y especificación de requisitos - historias de usuario, criterios de aceptación, casos borde y alcance. Usar antes de implementar una funcionalidad nueva, cuando el pedido sea vago, o cuando el usuario pida escribir historias, especificaciones, PRD o criterios de aceptación.
---

# Requisitos y alcance

Objetivo: convertir un pedido en algo verificable antes de invertir en código.

## Preguntas mínimas

1. **¿Quién** lo usa y **qué problema** resuelve? (no "qué pantalla quiere")
2. **¿Cómo sabremos que funciona?** → criterios de aceptación.
3. **¿Qué queda fuera?** → no-objetivos explícitos.
4. **Restricciones**: rendimiento, seguridad, normativa (p. ej. protección de datos, requisitos legales o tributarios), compatibilidad, plazos.
5. **Datos**: qué entra, qué sale, de dónde viene, quién es dueño, cuánto vive.

Si una respuesta cambia el diseño y no se puede inferir con seguridad, preguntar. No inventar reglas de negocio: marcarlas como supuesto.

## Formato de historia

```
Como <rol>
quiero <capacidad>
para <beneficio>
```

## Criterios de aceptación (Given/When/Then)

```
Escenario: <nombre>
  Dado <estado inicial>
  Cuando <acción>
  Entonces <resultado observable>
```

Reglas:
- Observables y verificables (sin "rápido", "intuitivo", "robusto" sin cifra o condición).
- Uno por comportamiento. Incluir casos de error, no solo el camino feliz.
- Cada criterio debe poder convertirse en al menos un test.

## Checklist de casos borde

- Vacíos: listas vacías, campos nulos, strings en blanco.
- Límites: cero, negativos, máximos, desbordes, redondeo de decimales y moneda.
- Fechas: zonas horarias, fin de mes, años bisiestos, cambios de horario, periodos parciales.
- Concurrencia: dos usuarios editan lo mismo; reintentos; doble envío.
- Permisos: usuario sin acceso, recurso de otro tenant.
- Fallos externos: servicio caído, timeout, respuesta malformada.
- Volumen: qué pasa con 10x o 100x los datos esperados.

## Distinguir en la especificación

- **Hecho**: confirmado por el usuario o documentación.
- **Supuesto**: decisión tomada para avanzar; debe validarse.
- **Pregunta abierta**: bloquea o condiciona el diseño.

## Plantilla

Ver [plantilla-especificacion.md](plantilla-especificacion.md).
