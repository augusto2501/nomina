---
name: codigo-limpio
description: Convenciones de código limpio y mantenible - nombres, funciones, manejo de errores, inmutabilidad, comentarios y complejidad. Usar al escribir o modificar código de producción en cualquier lenguaje.
---

# Código limpio

La regla principal: **seguir el estilo existente del proyecto**. Estas pautas aplican donde el proyecto no define otra cosa.

## Nombres

- Revelan intención: `diasHabilesPendientes`, no `d` ni `data2`.
- Vocabulario del dominio, consistente en todo el código (un concepto = una palabra).
- Booleanos como predicados: `estaActivo`, `tienePermiso`.
- Funciones con verbo: `calcularDeducciones`, `enviarNotificacion`.
- Evitar abreviaturas no estándar y prefijos de tipo.

## Funciones

- Hacen una cosa, en un solo nivel de abstracción.
- Pocos parámetros; si son muchos, agrupar en un objeto con nombre.
- Sin argumentos booleanos que cambian el comportamiento: separar en dos funciones.
- Separar cálculo puro de efectos (I/O, BD, red, reloj). La lógica pura es trivial de testear.
- Retorno temprano (guard clauses) en lugar de anidamiento profundo.

## Manejo de errores

- Fallar rápido y con mensaje útil: qué falló, con qué entrada (sin datos sensibles), qué hacer.
- No tragar excepciones. Un `catch` vacío o que solo loguea y continúa necesita justificación explícita.
- Capturar solo lo que se puede manejar; dejar propagar el resto.
- Distinguir errores de negocio esperados (validación, regla incumplida) de fallos técnicos (timeout, bug). Los primeros son parte del contrato; los segundos se reportan.
- Validar en los límites del sistema (entrada HTTP, archivos, colas, servicios externos); dentro, confiar en tipos e invariantes.
- Liberar recursos siempre (try-with-resources, `using`, `with`, `defer`, `finally`).

## Estado y datos

- Preferir inmutabilidad; mutar solo donde se justifique por rendimiento o claridad.
- Minimizar el alcance de variables.
- Nada de estado global mutable.
- Sin números ni strings mágicos: constantes con nombre o configuración.

## Comentarios

- El código explica el *qué*; los comentarios explican el *por qué* (regla de negocio, decisión no obvia, referencia a norma o ticket).
- No comentar código muerto: borrarlo, git lo recuerda.
- Documentar la API pública (parámetros, errores, efectos) según convención del lenguaje.

## Complejidad

- Si una función no cabe en pantalla o tiene más de 3 niveles de anidamiento, probablemente hace demasiado.
- Duplicación: tolerar dos copias; a la tercera, extraer. Duplicación accidental (parecido pero con razones distintas para cambiar) no se unifica.
- No introducir abstracciones, patrones ni dependencias sin un problema presente que lo exija.

## Dependencias externas

- Antes de añadir una librería: ¿mantenida?, ¿licencia compatible?, ¿tamaño razonable?, ¿vulnerabilidades conocidas?, ¿el problema se resuelve en pocas líneas propias?
- Fijar versiones con lockfile.
- Aislar librerías críticas detrás de una interfaz propia si son difíciles de reemplazar.
