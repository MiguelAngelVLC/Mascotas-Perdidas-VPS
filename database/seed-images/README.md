# Imágenes de ejemplo para los reportes del seed

Esta carpeta contiene las imágenes que se asignarán a los 30 reportes de prueba
creados por `database/seed.sql`. El script `scripts/seed-report-images.ps1` (Windows)
o `scripts/seed-report-images.sh` (Linux/macOS) las sube automáticamente a través
de la API de la aplicación.

## Convención de nombres

Cada archivo debe llamarse `NN-<nombre>.jpg` donde `NN` es el ID del reporte (con ceros):

| Archivo              | Reporte | Animal                        | Ciudad     |
|----------------------|---------|-------------------------------|------------|
| `01-max.jpg`         | 1       | Max (Labrador)                | Madrid     |
| `02-luna.jpg`        | 2       | Luna (Siamés)                 | Madrid     |
| `03-rocky.jpg`       | 3       | Rocky (Pastor Alemán)         | Madrid     |
| `04-misu.jpg`        | 4       | Misu (Gato naranja)           | Madrid     |
| `05-lola.jpg`        | 5       | Lola (Beagle)                 | Madrid     |
| `06-pipo.jpg`        | 6       | Pipo (Periquito)              | Madrid     |
| `07-bruno.jpg`       | 7       | Bruno (Bulldog Francés)       | Madrid     |
| `08-mestizo.jpg`     | 8       | Mestizo                       | Madrid     |
| `09-nala.jpg`        | 9       | Nala (Persa)                  | Madrid     |
| `10-negro.jpg`       | 10      | Gato negro                    | Madrid     |
| `11-rex.jpg`         | 11      | Rex (Rottweiler)              | Valencia   |
| `12-coco.jpg`        | 12      | Coco (Chihuahua)              | Barcelona  |
| `13-toby.jpg`        | 13      | Toby (Golden Retriever)       | Sevilla    |
| `14-thor.jpg`        | 14      | Thor (Husky Siberiano)        | Bilbao     |
| `15-bobby.jpg`       | 15      | Bobby (Mestizo)               | Zaragoza   |
| `16-border.jpg`      | 16      | Border Collie                 | Málaga     |
| `17-simba.jpg`       | 17      | Simba (Cocker Spaniel)        | Granada    |
| `18-mochi.jpg`       | 18      | Mochi (Maine Coon)            | Alicante   |
| `19-kira.jpg`        | 19      | Kira (Ragdoll)                | Barcelona  |
| `20-loki.jpg`        | 20      | Loki (Bengalí)                | Valencia   |
| `21-siames.jpg`      | 21      | Siamés                        | Sevilla    |
| `22-nube.jpg`        | 22      | Nube (Persa)                  | Bilbao     |
| `23-kiwi.jpg`        | 23      | Kiwi (Cacatúa ninfa)          | Zaragoza   |
| `24-agapornis.jpg`   | 24      | Agapornis                     | Málaga     |
| `25-canario.jpg`     | 25      | Canario                       | Granada    |
| `26-spike.jpg`       | 26      | Spike (Gecko leopardo)        | Valencia   |
| `27-drako.jpg`       | 27      | Drako (Dragón barbudo)        | Zaragoza   |
| `28-iggy.jpg`        | 28      | Iggy (Iguana verde)           | Barcelona  |
| `29-buba.jpg`        | 29      | Buba (Conejo enano)           | Alicante   |
| `30-hamster.jpg`     | 30      | Hámster dorado                | Sevilla    |

## Cómo obtener fotos libres de derechos

Puedes descargar imágenes de animales desde:
- https://unsplash.com (busca "golden retriever", "siamese cat", etc.)
- https://pixabay.com
- https://www.pexels.com

Guárdalas en esta carpeta con los nombres de la tabla anterior.

## Formato aceptado

- Formatos: JPG, PNG, GIF, WEBP
- Tamaño máximo: 10 MB por imagen
