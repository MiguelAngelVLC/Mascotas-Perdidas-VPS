#!/usr/bin/env bash
# =============================================================================
# seed-report-images.sh
# Sube imágenes de ejemplo a los 10 reportes del seed via la API.
#
# USO:
#   # Entorno local (Docker Compose levantado)
#   bash scripts/seed-report-images.sh
#
#   # VPS / producción
#   API_URL=https://api.tudominio.com bash scripts/seed-report-images.sh
#
# REQUISITOS: curl, jq
# =============================================================================

set -euo pipefail

API_URL="${API_URL:-http://localhost:8080}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGES_DIR="$SCRIPT_DIR/../database/seed-images"

ADMIN_USER="admin"
ADMIN_PASS="Test1234!"

# ── Login ─────────────────────────────────────────────────────────────────────
echo "Iniciando sesión como '$ADMIN_USER'..."
TOKEN=$(curl -sS -X POST "$API_URL/api/auth/login" \
  -H "Content-Type: application/json" \
  -d "{\"usernameOrEmail\":\"$ADMIN_USER\",\"password\":\"$ADMIN_PASS\"}" \
  | jq -r '.token')

if [[ -z "$TOKEN" || "$TOKEN" == "null" ]]; then
  echo "ERROR: No se obtuvo token. Revisa credenciales o URL ($API_URL)." >&2
  exit 1
fi
echo "Login correcto."

# ── Helper ────────────────────────────────────────────────────────────────────
put_report() {
  local id="$1"
  local img_file="$2"
  local report_json="$3"
  local img_path="$IMAGES_DIR/$img_file"

  if [[ ! -f "$img_path" ]]; then
    echo "  [SKIP] Reporte $id: '$img_file' no encontrado."
    return
  fi

  echo "  [PUT]  Reporte $id + $img_file..."
  local http_status
  http_status=$(curl -sS -o /dev/null -w "%{http_code}" \
    -X PUT "$API_URL/api/reports/$id" \
    -H "Authorization: Bearer $TOKEN" \
    -F "report=${report_json};type=application/json;charset=utf-8" \
    -F "image=@$img_path")

  if [[ "$http_status" =~ ^2 ]]; then
    echo "         OK ($http_status)"
  else
    echo "         FAIL ($http_status)" >&2
  fi
}

# ── Reportes (JSON UTF-8 + imagen) ───────────────────────────────────────────
put_report 1 "01-max.jpg" \
  '{"status":"LOST","animalType":"DOG","name":"Max","breed":"Labrador Retriever","color":"Dorado","size":"LARGE","eventDate":"2024-11-28","description":"Perro labrador muy amigable, se perdió cerca del parque. Responde a su nombre y le encanta jugar con pelotas.","distinctiveFeatures":"Collar rojo con chapa de identificación","locationText":"Parque del Retiro","city":"Madrid","province":"Madrid","contactName":"María García","contactPhone":"+34 612 345 678","contactEmail":"maria@example.com"}'

put_report 2 "02-luna.jpg" \
  '{"status":"FOUND","animalType":"CAT","name":"Luna","breed":"Siamés","color":"Gris claro","size":"SMALL","eventDate":"2024-11-29","description":"Gata siamesa encontrada cerca de la estación. Es muy tímida pero dócil. Parece estar bien cuidada.","distinctiveFeatures":"Ojos azules, collar morado","locationText":"Estación de Atocha","city":"Madrid","province":"Madrid","contactName":"Carlos Rodríguez","contactPhone":"+34 623 456 789","contactEmail":"carlos@example.com"}'

put_report 3 "03-rocky.jpg" \
  '{"status":"FOUND","animalType":"DOG","name":"Rocky","breed":"Pastor Alemán","color":"Negro y marrón","size":"LARGE","eventDate":"2024-11-30","description":"Perro pastor alemán encontrado deambulando. Está bien cuidado y parece ser doméstico.","distinctiveFeatures":"Cicatriz pequeña en oreja derecha","locationText":"Barrio de Salamanca","city":"Madrid","province":"Madrid","contactName":"Ana López","contactPhone":"+34 634 567 890","contactEmail":"ana@example.com"}'

put_report 4 "04-misu.jpg" \
  '{"status":"LOST","animalType":"CAT","name":"Misu","breed":"Europeo común","color":"Naranja","size":"SMALL","eventDate":"2024-12-01","description":"Gato naranja muy cariñoso que salió por la ventana y no ha regresado. Le gustan las caricias.","distinctiveFeatures":"Mancha blanca en el pecho","locationText":"Calle Gran Vía","city":"Madrid","province":"Madrid","contactName":"Pedro Martínez","contactPhone":"+34 645 678 901","contactEmail":"pedro@example.com"}'

put_report 5 "05-lola.jpg" \
  '{"status":"LOST","animalType":"DOG","name":"Lola","breed":"Beagle","color":"Tricolor","size":"MEDIUM","eventDate":"2024-12-02","description":"Beagle muy juguetona desaparecida en el parque. Tiene microchip. Recompensa.","distinctiveFeatures":"Collar azul con cascabel","locationText":"Parque de El Retiro","city":"Madrid","province":"Madrid","contactName":"Laura Sánchez","contactPhone":"+34 656 789 012","contactEmail":"laura@example.com"}'

put_report 6 "06-pipo.jpg" \
  '{"status":"FOUND","animalType":"BIRD","name":"Pipo","breed":"Periquito","color":"Verde y amarillo","size":"SMALL","eventDate":"2024-12-03","description":"Periquito encontrado en el balcón. Parece domesticado, habla algunas palabras.","distinctiveFeatures":"Anilla azul en la pata izquierda","locationText":"Calle Alcalá","city":"Madrid","province":"Madrid","contactName":"María García","contactPhone":"+34 612 345 678","contactEmail":"maria@example.com"}'

put_report 7 "07-bruno.jpg" \
  '{"status":"LOST","animalType":"DOG","name":"Bruno","breed":"Bulldog Francés","color":"Atigrado","size":"SMALL","eventDate":"2024-12-04","description":"Bulldog francés muy dócil. Se escapó por la puerta. Necesita medicación diaria.","distinctiveFeatures":"Oreja cortada parcialmente, collar negro","locationText":"Barrio de Malasaña","city":"Madrid","province":"Madrid","contactName":"Carlos Rodríguez","contactPhone":"+34 623 456 789","contactEmail":"carlos@example.com"}'

put_report 8 "08-mestizo.jpg" \
  '{"status":"FOUND","animalType":"DOG","breed":"Mestizo","color":"Blanco y negro","size":"MEDIUM","eventDate":"2024-12-05","description":"Perro mestizo encontrado en la calle. No tiene collar. Muy tranquilo y obediente.","locationText":"Avenida de América","city":"Madrid","province":"Madrid","contactName":"Ana López","contactPhone":"+34 634 567 890","contactEmail":"ana@example.com"}'

put_report 9 "09-nala.jpg" \
  '{"status":"LOST","animalType":"CAT","name":"Nala","breed":"Persa","color":"Blanco","size":"MEDIUM","eventDate":"2024-12-06","description":"Gata persa muy asustadiza. Salió al patio y no ha vuelto. Tiene las vacunas al día.","distinctiveFeatures":"Pelo largo, lazo rosa en el cuello","locationText":"Barrio de Lavapiés","city":"Madrid","province":"Madrid","contactName":"Pedro Martínez","contactPhone":"+34 645 678 901","contactEmail":"pedro@example.com"}'

put_report 10 "10-negro.jpg" \
  '{"status":"FOUND","animalType":"CAT","breed":"Europeo","color":"Negro","size":"SMALL","eventDate":"2024-12-07","description":"Gato negro encontrado mojado bajo un coche. Está en buen estado. Busca dueño.","distinctiveFeatures":"Sin collar, muy sociable","locationText":"Calle Fuencarral","city":"Madrid","province":"Madrid","contactName":"Laura Sánchez","contactPhone":"+34 656 789 012","contactEmail":"laura@example.com"}'

echo ""
echo "Listo. Añade los archivos que falten en '$IMAGES_DIR' y vuelve a ejecutar."
