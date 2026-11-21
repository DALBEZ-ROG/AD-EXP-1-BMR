# EXP-1: Servicios web (SOAP y REST)

Exposición del primer corte (GA-SUM-02) de Aplicaciones Distribuidas (ISR-701), Universidad Técnica Estatal de Quevedo, paralelo B. Fecha de entrega: 21 de noviembre de 2026.

| Integrante | GitHub | Proyecto donde aplica el tema |
|---|---|---|
| Benites Pérez Dariem Alberto | [DALBEZ-ROG](https://github.com/DALBEZ-ROG) | [PresustentacionesAWPS](https://github.com/DALBEZ-ROG/PresustentacionesAWPS) |
| Mendoza Bermello Angello Agustín | [Amendozab5](https://github.com/Amendozab5) | [SGIRI](https://github.com/Amendozab5/SGIRI) |
| Rivas Piloso Dayver Yahir | [drivasp](https://github.com/drivasp) | [Gestión documental de titulación (sistema-titulacion-uteq)](https://github.com/Troyano2004/sistema-titulacion-uteq) |

## Video del ensayo

Pendiente.

## Contenido

| Carpeta o archivo | Qué tiene |
|---|---|
| `diapositivas/` | Diapositivas en Beamer: `main.tex`, una sección por archivo en `secciones/` y el PDF compilado |
| `notas/` | Notas de la exposición: qué se dice en cada parte, quién la expone, tabla de aportes y declaración de uso de IA |
| `referencias.bib` | Bibliografía en formato IEEE (biblatex), compartida por las diapositivas y las notas |
| `diagrama/` | Diagrama de arquitectura en draw.io (`.drawio`) y su exportación |
| `evidencias/` | Foto del bosquejo a mano, capturas de las lecturas y, en `medicion/`, el script y el resultado de la medición REST frente a SOAP |
| `caratula/` | Carátula de una página para el SGA |
| `BITACORA.md` | Sesiones de trabajo del equipo |

## Cómo compilar

Se necesita una distribución de LaTeX con `pdflatex` y `biber` (MiKTeX o TeX Live). Paquetes que usa: `beamer`, `biblatex` con el estilo `biblatex-ieee`, `roboto`, `fontawesome5`, `qrcode`, `tikz`, `booktabs`, `tabularx`, `csquotes`, `babel` (español), `titlesec`, `enumitem`, `float`, `caption`, `xurl` y `lmodern`.

Diapositivas (archivo principal `diapositivas/main.tex`):

```
cd diapositivas
pdflatex main
biber main
pdflatex main
pdflatex main
```

Notas (archivo principal `notas/main.tex`), con el mismo orden:

```
cd notas
pdflatex main
biber main
pdflatex main
pdflatex main
```

Carátula: `pdflatex caratula` dentro de `caratula/` (una sola pasada).

Los archivos `main.bbl` se dejan en el repositorio. Si `biber` no está disponible, `pdflatex` usa ese archivo y las referencias salen igual.

## Cómo repetir la medición REST frente a SOAP

Con el backend de PresustentacionesAWPS corriendo en `http://localhost:8090` y una solicitud registrada:

```
powershell -ExecutionPolicy Bypass -File evidencias/medicion/medicion-rest-soap.ps1
```

El script hace la misma consulta de estado por REST y por SOAP, 200 veces cada una, y guarda el resultado en `resultado-medicion.txt`.
