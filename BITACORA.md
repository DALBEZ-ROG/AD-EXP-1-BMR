# Bitácora del equipo

## Lunes 16 de noviembre de 2026

- **Presentes:** Dariem Benites. Angello Mendoza y Dayver Rivas enviaron por mensaje su proyecto y su usuario de GitHub.
- **Qué hicimos:**
  - Quedó el equipo: Benites, Mendoza y Rivas.
  - El tema es Servicios web (SOAP y REST).
  - Cada uno aplica el tema en un proyecto propio: PresustentacionesAWPS (Dariem), SGIRI (Angello) y Gestión documental de titulación (Dayver).
  - Se propuso el orden de la exposición: primero la explicación general y después lo que aplicó cada uno, con unos 3 a 4 minutos por persona.
  - Se creó el repositorio con la carátula, la base de las diapositivas y de las notas, y la bibliografía inicial.
- **Problemas resueltos:**
  - La guía del SGA pide analizar un sistema real, pero en clase se indicó explicar el tema y luego mostrar dónde lo aplicó cada uno. Se juntaron las dos cosas: la explicación general cubre las ocho partes de la guía con casos reales (el SRI y AWS) y después cada uno muestra su proyecto.
  - Se comprobaron en Crossref las primeras referencias antes de agregarlas.

## Martes 17 de noviembre de 2026

- **Presentes:** Dariem Benites.
- **Qué hicimos:**
  - En PresustentacionesAWPS se agregó un servicio SOAP: la operación `ConsultarEstadoSolicitud`, con su contrato XSD y el WSDL en `/ws/estado.wsdl`. Reutiliza el mismo servicio que la consulta REST de estado.
  - Se preparó la base de datos local del PFC para probar las dos consultas con datos de prueba.
  - Se escribió el script de medición REST frente a SOAP (`evidencias/medicion/`) y se corrió en la computadora de Dariem: 200 consultas por estilo. La respuesta SOAP pesó 703 bytes y la REST 252; en promedio, SOAP tardó 3,78 ms y REST 2,99 ms.
  - Se preparó la captura de la lectura 1 (Bogner et al., 2023), con las frases que usamos resaltadas.
  - Se terminaron y subieron las secciones 1, 2, 8 y 11 de las diapositivas y de las notas, y el diagrama de arquitectura en draw.io.
  - Dariem dibujó a mano el primer bosquejo de la arquitectura, con los nombres de los tres y la fecha, y se subió la foto a `evidencias/`.
  - Se subió a GitHub el código del servicio SOAP de PresustentacionesAWPS, con su prueba. Las 119 pruebas del proyecto pasan.
  - Se agregó el `.gitignore` al repositorio y se subió la carátula al SGA.
  - Se prepararon las secciones generales de Angello (3, 4 y 5) y de Dayver (6 y 7) para que las revisen y las suban.
- **Problemas resueltos:**
  - El PFC no compilaba con Java 25 por la versión de Lombok; se instaló Java 17, que es la versión del proyecto.
  - Con `spring.jpa.open-in-view=false` el REST fallaba al convertir entidades a JSON; se volvió al valor por defecto.
  - La consulta REST devolvía `200` con datos vacíos cuando la solicitud no existía; ahora devuelve `404`. El SOAP responde con un SOAP Fault.
  - IntelliJ no mostraba los cambios para hacer el commit porque el proyecto tenía registradas como repositorios Git dos carpetas que no lo eran; se quitaron en la configuración de control de versiones.
  - Al primer bosquejo le faltaban los nombres y la fecha; se agregaron y se volvió a subir la foto.

## Martes 17 de noviembre de 2026 (segunda sesión)

- **Presentes:** Angello Mendoza.
- **Qué hicimos:**
  - Se revisó el código de SGIRI para confirmar qué servicios web expone y cuáles consume: la API REST de tickets, Globalping y Cloudinary.
  - Se armó la sección 9 de las diapositivas con el diagrama, las rutas reales de `TicketController` y la cadena de respaldo de Globalping.
  - Se escribió el borrador de la nota de esa parte.
- **Problemas resueltos:**
  - Se comprobó en `GlobalpingServiceImpl` que la cadena es IPv4 en Ecuador, IPv6 en Ecuador e IPv4 en Sudamérica, y que si todo falla se guarda la corrida como fallida y se copia el último resultado bueno.
  - La sección 9 compila sin la captura de Postman: la diapositiva deja un recuadro en su lugar y la imagen entra cuando exista el archivo.

## Miércoles 18 de noviembre de 2026

- **Presentes:** Angello Mendoza.
- **Qué hicimos:**
  - Se revisaron las secciones 3, 4 y 5 que preparó Dariem y se subieron con sus notas.
  - En la sección 4 se cambió la cita de Brewer por la de Abadi: la de Brewer no tiene PDF de acceso libre y la de Abadi sí, y dice lo mismo de las particiones.
  - Se comprobó que las diapositivas y las notas compilan sin errores y sin texto que se salga del marco.
- **Problemas resueltos:**
  - La tabla de la sección 4 y el bloque de abajo se pasaban del alto de la diapositiva; se acortaron las frases y ya entran.
  - La tabla de la sección 9 se salía a lo ancho; se cambió la ruta completa por la parte final y se aclaró que todas cuelgan de `/api/tickets`.

## Miércoles 18 de noviembre de 2026 (segunda sesión)

- **Presentes:** Dariem Benites.
- **Qué hicimos:**
  - Se revisó en el repositorio lo que ya está y lo que le falta a cada uno antes del cierre del sábado 21.
  - Se le confirmó a Dayver que su paquete trae todo lo que le toca: las secciones 6, 7 y 10, sus capturas, la lectura 3 y su nota de uso de IA.
- **Problemas resueltos:**
  - Angello y Dayver tenían el paquete del lunes, que no traía sus secciones generales y les asignaba lecturas que no son de acceso libre (Neumann y Soldani). Ya tienen el paquete nuevo, con sus secciones (3, 4 y 5 para Angello; 6 y 7 para Dayver) y lecturas de acceso libre (Golmohammadi et al., 2024, y Lercher et al., 2024).

## Jueves 19 de noviembre de 2026

- **Presentes:** Dariem Benites.
- **Qué hicimos:**
  - Se comprobó que las diapositivas y las notas compilan desde una copia limpia del repositorio, ya con las secciones de Angello y de Dayver.
  - Se prepararon opciones de pregunta crítica para los equipos de WebSockets, de RPC, gRPC y RMI, y de computación paralela.
- **Problemas resueltos:**
  - En las notas de la parte 8 arregle un texto que no estaba bien, y se volvió a compilar.
- **Pendiente:**
  - Las notas ya ocupan 5 páginas y la guía pide de 2 a 4. El viernes se ajustan, dejando el bosquejo a mano como anexo.

## Jueves 19 de noviembre de 2026 (segunda sesión)

- **Presentes:** Angello Mendoza.
- **Qué hicimos:**
  - Se instaló PostgreSQL 19 y se levantó la base local `SGIM2` con el respaldo del proyecto: 16 usuarios y 33 tickets.
  - Se compiló el backend de SGIRI con Java 21 y se arrancó contra esa base para probar la API de verdad.
  - Se probó el login y la consulta de tickets, y se tomó la captura de la petición para la sección 9.
  - Se ajustó la sección 9: la ruta que un cliente puede usar es `GET /api/tickets/my-tickets`, no `/all`, que es solo de administradores.
- **Problemas resueltos:**
  - El respaldo es del 20 de marzo y no traía las columnas `firma_tecnico_url` y `firma_cliente_url`; se agregaron a la base local para que las consultas de tickets respondieran.
  - El usuario `sgiri_app` no tenía permisos sobre los esquemas; se le dieron para que el backend arrancara.
  - La API devuelve el usuario completo, con el hash de la contraseña; por eso la captura se hizo del login y no de la lista de tickets.
- **Nota:** el commit se subió el viernes 20 de noviembre a las 00:04, después de terminar la captura.
