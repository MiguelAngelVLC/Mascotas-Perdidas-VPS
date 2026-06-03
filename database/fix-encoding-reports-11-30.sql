-- =============================================================
-- Corrección de encoding para reportes 11-30
-- Los campos de texto fueron sobreescritos por el script
-- seed-report-images.ps1 con codificación incorrecta.
-- =============================================================
SET NAMES utf8mb4;

UPDATE reports SET
  contact_name         = 'Sofia Fernández',
  location_text        = 'Avenida del Puerto',
  description          = 'Rottweiler joven muy cariñoso. Se escapó durante un paseo. Tiene microchip. Muy asustadizo con desconocidos.',
  distinctive_features = 'Collar negro con nombre grabado'
WHERE id = 11;

UPDATE reports SET
  contact_name         = 'Diego Moreno',
  location_text        = 'Barrio Gràcia',
  description          = 'Chihuahua muy pequeño que salió por la puerta entreabierta. Lleva collar rosa. Recompensa.',
  distinctive_features = 'Collar rosa con cascabel, mancha blanca en frente'
WHERE id = 12;

UPDATE reports SET
  contact_name         = 'Elena Ruiz',
  location_text        = 'Parque de María Luisa',
  description          = 'Golden muy sociable desaparecido cerca del río. Le encantan los niños. Responde a su nombre.',
  distinctive_features = 'Collar verde con chapa'
WHERE id = 13;

UPDATE reports SET
  contact_name         = 'Javier Torres',
  location_text        = 'Casco Viejo',
  description          = 'Husky muy activo que se escapó durante una tormenta. Ojos azules. Puede estar asustado.',
  distinctive_features = 'Ojos azules heterocromía leve, sin collar cuando se perdió'
WHERE id = 14;

UPDATE reports SET
  contact_name         = 'Carmen Díaz',
  location_text        = 'Parque del Tío Jorge',
  description          = 'Perro mestizo encontrado en el parque del Tío Jorge. Está en buen estado y es muy dócil.',
  distinctive_features = 'Sin collar, tiene una cicatriz en la pata trasera derecha'
WHERE id = 15;

UPDATE reports SET
  contact_name         = 'María García',
  location_text        = 'Playa de la Malagueta',
  description          = 'Border collie encontrado en la playa. Parece bien cuidado y obedece órdenes básicas.',
  distinctive_features = 'Sin collar, muy inteligente y obediente'
WHERE id = 16;

UPDATE reports SET
  contact_name         = 'Carlos Rodríguez',
  location_text        = 'Gran Vía de Granada',
  description          = 'Cocker spaniel encontrado cerca del centro. Muy afectuoso. Parece que tiene dueño.',
  distinctive_features = 'Pelo largo bien cuidado, collar azul sin chapa'
WHERE id = 17;

UPDATE reports SET
  contact_name         = 'Ana López',
  location_text        = 'Explanada de España',
  description          = 'Gato Maine Coon grande y peludo. Muy tranquilo. Se perdió en el portal. Tiene microchip.',
  distinctive_features = 'Pelo largo gris plateado, ojos amarillos'
WHERE id = 18;

UPDATE reports SET
  contact_name         = 'Diego Moreno',
  location_text        = 'Barrio Eixample',
  description          = 'Gata Ragdoll muy dulce. Salió al balcón y desapareció. Nunca ha salido sola.',
  distinctive_features = 'Ojos azules, punta de las patas oscuras'
WHERE id = 19;

UPDATE reports SET
  contact_name         = 'Sofia Fernández',
  location_text        = 'Barrio Ruzafa',
  description          = 'Gato bengalí muy activo. Escapó por una ventana. Puede mostrarse esquivo con extraños.',
  distinctive_features = 'Manchas de leopardo, sin collar'
WHERE id = 20;

UPDATE reports SET
  contact_name         = 'Elena Ruiz',
  location_text        = 'Parque de los Príncipes',
  description          = 'Gata siamesa encontrada en un jardín. Muy vocaliza. Parece tener dueño pues está muy bien cuidada.',
  distinctive_features = 'Puntos oscuros en cara y patas, sin collar'
WHERE id = 21;

UPDATE reports SET
  contact_name         = 'Javier Torres',
  location_text        = 'Calle Licenciado Poza',
  description          = 'Gato persa blanco encontrado en un portal. Está algo sucio pero en buen estado de salud.',
  distinctive_features = 'Pelo largo enredado, sin collar'
WHERE id = 22;

UPDATE reports SET
  contact_name         = 'Carmen Díaz',
  location_text        = 'Paseo de la Independencia',
  description          = 'Cacatúa que voló desde el balcón. Dice su nombre y otras palabras. Muy sociable.',
  distinctive_features = 'Cresta amarilla, anilla verde en pata izquierda'
WHERE id = 23;

UPDATE reports SET
  contact_name         = 'Laura Sánchez',
  location_text        = 'Paseo del Parque',
  description          = 'Agapornis encontrado posado en una terraza. Parece domesticado, no tiene miedo a las personas.',
  distinctive_features = 'Sin anilla visible'
WHERE id = 24;

UPDATE reports SET
  contact_name         = 'Pedro Martínez',
  location_text        = 'Parque Federico García Lorca',
  description          = 'Canario amarillo encontrado en un árbol del parque. Canta mucho. Debe de ser doméstico.',
  distinctive_features = 'Sin anilla'
WHERE id = 25;

UPDATE reports SET
  contact_name         = 'Sofia Fernández',
  location_text        = 'Barrio Benimaclet',
  description          = 'Gecko leopardo que escapó de su terrario. Busca lugares cálidos y oscuros. Es inofensivo.',
  distinctive_features = 'Manchas negras sobre fondo naranja, sin cola regenerada'
WHERE id = 26;

UPDATE reports SET
  contact_name         = 'Carmen Díaz',
  location_text        = 'Barrio La Almozara',
  description          = 'Dragón barbudo que salió del terrario durante una limpieza. Es dócil y está acostumbrado a personas.',
  distinctive_features = 'Barba oscura cuando se asusta, uñas sin cortar'
WHERE id = 27;

UPDATE reports SET
  contact_name         = 'Diego Moreno',
  location_text        = 'Barrio Poblenou',
  description          = 'Iguana encontrada en una terraza del quinto piso. Está bien alimentada. Claramente es una mascota.',
  distinctive_features = 'Cresta dorsal completa, uñas largas'
WHERE id = 28;

UPDATE reports SET
  contact_name         = 'Ana López',
  location_text        = 'Barrio San Blas',
  description          = 'Conejo enano blanco que escapó de su jaula en el jardín. Muy tímido con desconocidos.',
  distinctive_features = 'Ojos rosados, orejas largas, sin collar'
WHERE id = 29;

UPDATE reports SET
  contact_name         = 'Elena Ruiz',
  location_text        = 'Barrio Triana',
  description          = 'Hámster encontrado corriendo por el pasillo de un edificio. Está sano y activo.',
  distinctive_features = 'Sin marcas distintivas'
WHERE id = 30;
