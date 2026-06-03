#!/usr/bin/env bash
# =============================================================================
# seed-report-images.sh
# Sube imágenes de ejemplo a los 30 reportes del seed via la API.
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

put_report 11 "11-rex.jpg" \
  '{"status":"LOST","animalType":"DOG","name":"Rex","breed":"Rottweiler","color":"Negro","size":"LARGE","eventDate":"2025-01-05","description":"Rottweiler joven muy cariñoso. Se escapó durante un paseo. Tiene microchip. Muy asustadizo con desconocidos.","distinctiveFeatures":"Collar negro con nombre grabado","locationText":"Avenida del Puerto","city":"Valencia","province":"Valencia","contactName":"Sofia Fernández","contactPhone":"+34 667 890 123","contactEmail":"sofia@example.com"}'

put_report 12 "12-coco.jpg" \
  '{"status":"LOST","animalType":"DOG","name":"Coco","breed":"Chihuahua","color":"Marrón","size":"SMALL","eventDate":"2025-01-08","description":"Chihuahua muy pequeño que salió por la puerta entreabierta. Lleva collar rosa. Recompensa.","distinctiveFeatures":"Collar rosa con cascabel, mancha blanca en frente","locationText":"Barrio Gràcia","city":"Barcelona","province":"Barcelona","contactName":"Diego Moreno","contactPhone":"+34 678 901 234","contactEmail":"diego@example.com"}'

put_report 13 "13-toby.jpg" \
  '{"status":"LOST","animalType":"DOG","name":"Toby","breed":"Golden Retriever","color":"Dorado","size":"LARGE","eventDate":"2025-01-12","description":"Golden muy sociable desaparecido cerca del río. Le encantan los niños. Responde a su nombre.","distinctiveFeatures":"Collar verde con chapa","locationText":"Parque de María Luisa","city":"Sevilla","province":"Sevilla","contactName":"Elena Ruiz","contactPhone":"+34 689 012 345","contactEmail":"elena@example.com"}'

put_report 14 "14-thor.jpg" \
  '{"status":"LOST","animalType":"DOG","name":"Thor","breed":"Husky Siberiano","color":"Blanco y gris","size":"LARGE","eventDate":"2025-01-15","description":"Husky muy activo que se escapó durante una tormenta. Ojos azules. Puede estar asustado.","distinctiveFeatures":"Ojos azules heterocromía leve, sin collar cuando se perdió","locationText":"Casco Viejo","city":"Bilbao","province":"País Vasco","contactName":"Javier Torres","contactPhone":"+34 690 123 456","contactEmail":"javier@example.com"}'

put_report 15 "15-bobby.jpg" \
  '{"status":"FOUND","animalType":"DOG","name":"Bobby","breed":"Mestizo","color":"Marrón","size":"MEDIUM","eventDate":"2025-01-18","description":"Perro mestizo encontrado en el parque del Tío Jorge. Está en buen estado y es muy dócil.","distinctiveFeatures":"Sin collar, tiene una cicatriz en la pata trasera derecha","locationText":"Parque del Tío Jorge","city":"Zaragoza","province":"Aragón","contactName":"Carmen Díaz","contactPhone":"+34 601 234 567","contactEmail":"carmen@example.com"}'

put_report 16 "16-border.jpg" \
  '{"status":"FOUND","animalType":"DOG","breed":"Border Collie","color":"Negro y blanco","size":"MEDIUM","eventDate":"2025-01-20","description":"Border collie encontrado en la playa. Parece bien cuidado y obedece órdenes básicas.","distinctiveFeatures":"Sin collar, muy inteligente y obediente","locationText":"Playa de la Malagueta","city":"Málaga","province":"Málaga","contactName":"María García","contactPhone":"+34 612 345 678","contactEmail":"maria@example.com"}'

put_report 17 "17-simba.jpg" \
  '{"status":"FOUND","animalType":"DOG","name":"Simba","breed":"Cocker Spaniel","color":"Rubio","size":"MEDIUM","eventDate":"2025-01-22","description":"Cocker spaniel encontrado cerca del centro. Muy afectuoso. Parece que tiene dueño.","distinctiveFeatures":"Pelo largo bien cuidado, collar azul sin chapa","locationText":"Gran Vía de Granada","city":"Granada","province":"Granada","contactName":"Carlos Rodríguez","contactPhone":"+34 623 456 789","contactEmail":"carlos@example.com"}'

put_report 18 "18-mochi.jpg" \
  '{"status":"LOST","animalType":"CAT","name":"Mochi","breed":"Maine Coon","color":"Gris","size":"LARGE","eventDate":"2025-01-25","description":"Gato Maine Coon grande y peludo. Muy tranquilo. Se perdió en el portal. Tiene microchip.","distinctiveFeatures":"Pelo largo gris plateado, ojos amarillos","locationText":"Explanada de España","city":"Alicante","province":"Alicante","contactName":"Ana López","contactPhone":"+34 634 567 890","contactEmail":"ana@example.com"}'

put_report 19 "19-kira.jpg" \
  '{"status":"LOST","animalType":"CAT","name":"Kira","breed":"Ragdoll","color":"Blanco y gris","size":"MEDIUM","eventDate":"2025-01-27","description":"Gata Ragdoll muy dulce. Salió al balcón y desapareció. Nunca ha salido sola.","distinctiveFeatures":"Ojos azules, punta de las patas oscuras","locationText":"Barrio Eixample","city":"Barcelona","province":"Barcelona","contactName":"Diego Moreno","contactPhone":"+34 678 901 234","contactEmail":"diego@example.com"}'

put_report 20 "20-loki.jpg" \
  '{"status":"LOST","animalType":"CAT","name":"Loki","breed":"Bengalí","color":"Atigrado marrón","size":"SMALL","eventDate":"2025-01-30","description":"Gato bengalí muy activo. Escapó por una ventana. Puede mostrarse esquivo con extraños.","distinctiveFeatures":"Manchas de leopardo, sin collar","locationText":"Barrio Ruzafa","city":"Valencia","province":"Valencia","contactName":"Sofia Fernández","contactPhone":"+34 667 890 123","contactEmail":"sofia@example.com"}'

put_report 21 "21-siames.jpg" \
  '{"status":"FOUND","animalType":"CAT","breed":"Siamés","color":"Beige y marrón","size":"SMALL","eventDate":"2025-02-02","description":"Gata siamesa encontrada en un jardín. Muy vocaliza. Parece tener dueño pues está muy bien cuidada.","distinctiveFeatures":"Puntos oscuros en cara y patas, sin collar","locationText":"Parque de los Príncipes","city":"Sevilla","province":"Sevilla","contactName":"Elena Ruiz","contactPhone":"+34 689 012 345","contactEmail":"elena@example.com"}'

put_report 22 "22-nube.jpg" \
  '{"status":"FOUND","animalType":"CAT","name":"Nube","breed":"Persa","color":"Blanco","size":"MEDIUM","eventDate":"2025-02-05","description":"Gato persa blanco encontrado en un portal. Está algo sucio pero en buen estado de salud.","distinctiveFeatures":"Pelo largo enredado, sin collar","locationText":"Calle Licenciado Poza","city":"Bilbao","province":"País Vasco","contactName":"Javier Torres","contactPhone":"+34 690 123 456","contactEmail":"javier@example.com"}'

put_report 23 "23-kiwi.jpg" \
  '{"status":"LOST","animalType":"BIRD","name":"Kiwi","breed":"Cacatúa ninfa","color":"Gris y amarillo","size":"SMALL","eventDate":"2025-02-08","description":"Cacatúa que voló desde el balcón. Dice su nombre y otras palabras. Muy sociable.","distinctiveFeatures":"Cresta amarilla, anilla verde en pata izquierda","locationText":"Paseo de la Independencia","city":"Zaragoza","province":"Aragón","contactName":"Carmen Díaz","contactPhone":"+34 601 234 567","contactEmail":"carmen@example.com"}'

put_report 24 "24-agapornis.jpg" \
  '{"status":"FOUND","animalType":"BIRD","breed":"Agapornis","color":"Verde y rojo","size":"SMALL","eventDate":"2025-02-10","description":"Agapornis encontrado posado en una terraza. Parece domesticado, no tiene miedo a las personas.","distinctiveFeatures":"Sin anilla visible","locationText":"Paseo del Parque","city":"Málaga","province":"Málaga","contactName":"Laura Sánchez","contactPhone":"+34 656 789 012","contactEmail":"laura@example.com"}'

put_report 25 "25-canario.jpg" \
  '{"status":"FOUND","animalType":"BIRD","breed":"Canario","color":"Amarillo","size":"SMALL","eventDate":"2025-02-12","description":"Canario amarillo encontrado en un árbol del parque. Canta mucho. Debe de ser doméstico.","distinctiveFeatures":"Sin anilla","locationText":"Parque Federico García Lorca","city":"Granada","province":"Granada","contactName":"Pedro Martínez","contactPhone":"+34 645 678 901","contactEmail":"pedro@example.com"}'

put_report 26 "26-spike.jpg" \
  '{"status":"LOST","animalType":"REPTILE","name":"Spike","breed":"Gecko leopardo","color":"Naranja y negro","size":"SMALL","eventDate":"2025-02-15","description":"Gecko leopardo que escapó de su terrario. Busca lugares cálidos y oscuros. Es inofensivo.","distinctiveFeatures":"Manchas negras sobre fondo naranja, sin cola regenerada","locationText":"Barrio Benimaclet","city":"Valencia","province":"Valencia","contactName":"Sofia Fernández","contactPhone":"+34 667 890 123","contactEmail":"sofia@example.com"}'

put_report 27 "27-drako.jpg" \
  '{"status":"LOST","animalType":"REPTILE","name":"Drako","breed":"Dragón barbudo","color":"Marrón arenoso","size":"SMALL","eventDate":"2025-02-18","description":"Dragón barbudo que salió del terrario durante una limpieza. Es dócil y está acostumbrado a personas.","distinctiveFeatures":"Barba oscura cuando se asusta, uñas sin cortar","locationText":"Barrio La Almozara","city":"Zaragoza","province":"Aragón","contactName":"Carmen Díaz","contactPhone":"+34 601 234 567","contactEmail":"carmen@example.com"}'

put_report 28 "28-iggy.jpg" \
  '{"status":"FOUND","animalType":"REPTILE","name":"Iggy","breed":"Iguana verde","color":"Verde","size":"MEDIUM","eventDate":"2025-02-20","description":"Iguana encontrada en una terraza del quinto piso. Está bien alimentada. Claramente es una mascota.","distinctiveFeatures":"Cresta dorsal completa, uñas largas","locationText":"Barrio Poblenou","city":"Barcelona","province":"Barcelona","contactName":"Diego Moreno","contactPhone":"+34 678 901 234","contactEmail":"diego@example.com"}'

put_report 29 "29-buba.jpg" \
  '{"status":"LOST","animalType":"OTHER","name":"Buba","breed":"Conejo enano","color":"Blanco","size":"SMALL","eventDate":"2025-02-22","description":"Conejo enano blanco que escapó de su jaula en el jardín. Muy tímido con desconocidos.","distinctiveFeatures":"Ojos rosados, orejas largas, sin collar","locationText":"Barrio San Blas","city":"Alicante","province":"Alicante","contactName":"Ana López","contactPhone":"+34 634 567 890","contactEmail":"ana@example.com"}'

put_report 30 "30-hamster.jpg" \
  '{"status":"FOUND","animalType":"OTHER","breed":"Hámster dorado","color":"Dorado","size":"SMALL","eventDate":"2025-02-25","description":"Hámster encontrado corriendo por el pasillo de un edificio. Está sano y activo.","distinctiveFeatures":"Sin marcas distintivas","locationText":"Barrio Triana","city":"Sevilla","province":"Sevilla","contactName":"Elena Ruiz","contactPhone":"+34 689 012 345","contactEmail":"elena@example.com"}'

echo ""
echo "Listo. Añade los archivos que falten en '$IMAGES_DIR' y vuelve a ejecutar."
