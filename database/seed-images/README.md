# Imágenes de ejemplo para los reportes del seed

Esta carpeta contiene las imágenes que se asignarán a los 10 reportes de prueba
creados por `database/seed.sql`. El script `scripts/seed-report-images.ps1` (Windows)
o `scripts/seed-report-images.sh` (Linux/macOS) las sube automáticamente a través
de la API de la aplicación.

## Convención de nombres

Cada archivo debe llamarse `NN-<nombre>.jpg` donde `NN` es el ID del reporte (con ceros):

| Archivo           | Reporte | Animal          |
|-------------------|---------|-----------------|
| `01-max.jpg`      | 1       | Max (Labrador)  |
| `02-luna.jpg`     | 2       | Luna (Siamés)   |
| `03-rocky.jpg`    | 3       | Rocky (Pastor)  |
| `04-misu.jpg`     | 4       | Misu (Naranja)  |
| `05-lola.jpg`     | 5       | Lola (Beagle)   |
| `06-pipo.jpg`     | 6       | Pipo (Periquito)|
| `07-bruno.jpg`    | 7       | Bruno (Bulldog) |
| `08-mestizo.jpg`  | 8       | Mestizo         |
| `09-nala.jpg`     | 9       | Nala (Persa)    |
| `10-negro.jpg`    | 10      | Gato negro      |

## Cómo obtener fotos libres de derechos

Puedes descargar imágenes de animales desde:
- https://unsplash.com (busca "golden retriever", "siamese cat", etc.)
- https://pixabay.com
- https://www.pexels.com

Guárdalas en esta carpeta con los nombres de la tabla anterior.

## Formato aceptado

- Formatos: JPG, PNG, GIF, WEBP
- Tamaño máximo: 10 MB por imagen
