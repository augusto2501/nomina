---
name: seguridad
description: Prácticas de desarrollo seguro basadas en OWASP - validación de entrada, inyección, autenticación, autorización, gestión de secretos, datos personales, dependencias y cabeceras. Usar al manejar entrada de usuario, autenticación, permisos, archivos, secretos, datos personales o sensibles, o cuando el usuario pida una revisión de seguridad.
---

# Seguridad

Referencia: OWASP Top 10 y OWASP ASVS. Aplicar por defecto, no como fase final.

## Entrada y salida

- Validar toda entrada externa en el límite: tipo, formato, longitud, rango, lista permitida (allowlist) antes que lista negada.
- **Inyección**: consultas parametrizadas siempre; nunca concatenar entrada en SQL, comandos de shell, rutas de archivo, LDAP, plantillas o expresiones.
- **XSS**: escapar según contexto de salida (HTML, atributo, JS, URL). Usar el escapado automático del framework; revisar cualquier uso de HTML "crudo".
- **Archivos**: validar tipo por contenido, limitar tamaño, generar nombres propios, almacenar fuera del webroot, prevenir path traversal.
- **Deserialización**: no deserializar datos no confiables con formatos que ejecutan código.
- **SSRF**: si el servidor hace requests a URLs proporcionadas por usuarios, usar allowlist de destinos.

## Autenticación

- No implementar criptografía ni hashing de contraseñas a mano: usar algoritmos diseñados para contraseñas (Argon2id, bcrypt, scrypt) vía librería madura.
- Sesiones/tokens: expiración, rotación, invalidación en logout y cambio de contraseña. Cookies con `HttpOnly`, `Secure`, `SameSite`.
- Limitar intentos (rate limiting) en login, recuperación de contraseña y endpoints costosos.
- MFA para cuentas administrativas.
- Mensajes de error que no revelen si el usuario existe.

## Autorización

- Denegar por defecto. Verificar permisos **en el servidor** en cada operación, no solo en la UI.
- Verificar pertenencia del recurso (IDOR): que el recurso solicitado pertenezca al usuario o tenant autenticado.
- Centralizar la lógica de autorización; testear explícitamente los casos de acceso denegado.
- Mínimo privilegio para usuarios, servicios y credenciales de BD.

## Secretos

- Nunca en código, commits, logs, mensajes de error ni tickets.
- Variables de entorno o gestor de secretos. `.env` en `.gitignore`; versionar solo `.env.example` sin valores reales.
- Si un secreto llega a un commit: rotarlo. Borrarlo del historial no basta.
- Escaneo de secretos en CI.

## Datos personales y sensibles

- Recolectar el mínimo necesario; definir retención y borrado.
- Cifrado en tránsito (TLS) siempre; en reposo para datos sensibles (identificaciones, datos bancarios, salud, salarios).
- Enmascarar en logs y respuestas (p. ej. últimos 4 dígitos).
- Registrar auditoría de accesos y cambios a datos sensibles: quién, qué, cuándo.
- Cumplir la normativa de protección de datos aplicable a la jurisdicción del proyecto; si no está clara, preguntarlo.

## Dependencias y configuración

- Escaneo de vulnerabilidades de dependencias en CI; actualizar con regularidad.
- Cabeceras HTTP: `Content-Security-Policy`, `Strict-Transport-Security`, `X-Content-Type-Options`, `Referrer-Policy`, CORS restrictivo.
- Errores en producción sin stack traces al cliente.
- Desactivar modos debug y endpoints de administración en producción.

## Checklist rápido de revisión

- [ ] ¿Toda entrada externa se valida?
- [ ] ¿Todas las consultas están parametrizadas?
- [ ] ¿Cada endpoint verifica autenticación y autorización sobre el recurso concreto?
- [ ] ¿Hay secretos o datos sensibles en código, logs o respuestas?
- [ ] ¿Las dependencias nuevas tienen vulnerabilidades conocidas?
- [ ] ¿Se testean los casos de acceso denegado?
