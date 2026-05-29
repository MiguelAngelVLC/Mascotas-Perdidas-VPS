-- Restaura textos UTF-8 correctos tras corrupción por multipart ISO-8859-1
--
-- Aplicar (Windows, desde la raíz del proyecto):
--   docker cp database/fix-encoding.sql mi_mariadb_local:/tmp/fix-encoding.sql
--   docker exec mi_mariadb_local mariadb --default-character-set=utf8mb4 -u mp_user -pmp_password mascotas_perdidas -e "source /tmp/fix-encoding.sql"
--
SET NAMES utf8mb4;

UPDATE users SET full_name = 'María García'     WHERE id = 2;
UPDATE users SET full_name = 'Carlos Rodríguez' WHERE id = 3;
UPDATE users SET full_name = 'Ana López'        WHERE id = 4;
UPDATE users SET full_name = 'Pedro Martínez'   WHERE id = 5;
UPDATE users SET full_name = 'Laura Sánchez'    WHERE id = 6;

UPDATE reports SET
  breed = 'Labrador Retriever',
  description = 'Perro labrador muy amigable, se perdió cerca del parque. Responde a su nombre y le encanta jugar con pelotas.',
  distinctive_features = 'Collar rojo con chapa de identificación',
  location_text = 'Parque del Retiro',
  contact_name = 'María García'
WHERE id = 1;

UPDATE reports SET
  breed = 'Siamés',
  description = 'Gata siamesa encontrada cerca de la estación. Es muy tímida pero dócil. Parece estar bien cuidada.',
  distinctive_features = 'Ojos azules, collar morado',
  location_text = 'Estación de Atocha',
  contact_name = 'Carlos Rodríguez'
WHERE id = 2;

UPDATE reports SET
  breed = 'Pastor Alemán',
  description = 'Perro pastor alemán encontrado deambulando. Está bien cuidado y parece ser doméstico.',
  distinctive_features = 'Cicatriz pequeña en oreja derecha',
  location_text = 'Barrio de Salamanca',
  contact_name = 'Ana López'
WHERE id = 3;

UPDATE reports SET
  breed = 'Europeo común',
  description = 'Gato naranja muy cariñoso que salió por la ventana y no ha regresado. Le gustan las caricias.',
  distinctive_features = 'Mancha blanca en el pecho',
  location_text = 'Calle Gran Vía',
  contact_name = 'Pedro Martínez'
WHERE id = 4;

UPDATE reports SET
  description = 'Beagle muy juguetona desaparecida en el parque. Tiene microchip. Recompensa.',
  distinctive_features = 'Collar azul con cascabel',
  location_text = 'Parque de El Retiro',
  contact_name = 'Laura Sánchez'
WHERE id = 5;

UPDATE reports SET
  description = 'Periquito encontrado en el balcón. Parece domesticado, habla algunas palabras.',
  distinctive_features = 'Anilla azul en la pata izquierda',
  location_text = 'Calle Alcalá',
  contact_name = 'María García'
WHERE id = 6;

UPDATE reports SET
  breed = 'Bulldog Francés',
  description = 'Bulldog francés muy dócil. Se escapó por la puerta. Necesita medicación diaria.',
  distinctive_features = 'Oreja cortada parcialmente, collar negro',
  location_text = 'Barrio de Malasaña',
  contact_name = 'Carlos Rodríguez'
WHERE id = 7;

UPDATE reports SET
  description = 'Perro mestizo encontrado en la calle. No tiene collar. Muy tranquilo y obediente.',
  location_text = 'Avenida de América',
  contact_name = 'Ana López'
WHERE id = 8;

UPDATE reports SET
  description = 'Gata persa muy asustadiza. Salió al patio y no ha vuelto. Tiene las vacunas al día.',
  distinctive_features = 'Pelo largo, lazo rosa en el cuello',
  location_text = 'Barrio de Lavapiés',
  contact_name = 'Pedro Martínez'
WHERE id = 9;

UPDATE reports SET
  description = 'Gato negro encontrado mojado bajo un coche. Está en buen estado. Busca dueño.',
  distinctive_features = 'Sin collar, muy sociable',
  location_text = 'Calle Fuencarral',
  contact_name = 'Laura Sánchez'
WHERE id = 10;
