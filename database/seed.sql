-- =============================================================
-- Mascotas Perdidas — Datos de ejemplo (seed)
-- Contraseña para todos los usuarios de prueba: Test1234!
-- Hash BCrypt generado con cost=10
-- =============================================================

SET NAMES utf8mb4;

-- Usuario administrador
INSERT IGNORE INTO users (id, username, email, password, full_name, phone) VALUES
(1, 'admin', 'admin@mascotasperdidas.es',
 '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu',
 'Administrador', '+34 600 000 001');

INSERT IGNORE INTO user_roles (user_id, role_id) VALUES (1, 1), (1, 2);

-- Usuarios de ejemplo
INSERT IGNORE INTO users (id, username, email, password, full_name, phone) VALUES
(2, 'maria_garcia', 'maria@example.com',
 '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu',
 'María García', '+34 612 345 678'),
(3, 'carlos_rod', 'carlos@example.com',
 '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu',
 'Carlos Rodríguez', '+34 623 456 789'),
(4, 'ana_lopez', 'ana@example.com',
 '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu',
 'Ana López', '+34 634 567 890'),
(5, 'pedro_mart', 'pedro@example.com',
 '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu',
 'Pedro Martínez', '+34 645 678 901'),
(6, 'laura_sanch', 'laura@example.com',
 '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu',
 'Laura Sánchez', '+34 656 789 012');

INSERT IGNORE INTO user_roles (user_id, role_id) VALUES
(2, 1),(3, 1),(4, 1),(5, 1),(6, 1);

-- Usuarios adicionales
INSERT IGNORE INTO users (id, username, email, password, full_name, phone) VALUES
(7,  'sofia_fern',   'sofia@example.com',   '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu', 'Sofia Fernández', '+34 667 890 123'),
(8,  'diego_mor',    'diego@example.com',   '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu', 'Diego Moreno',    '+34 678 901 234'),
(9,  'elena_ruiz',   'elena@example.com',   '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu', 'Elena Ruiz',      '+34 689 012 345'),
(10, 'javier_tor',   'javier@example.com',  '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu', 'Javier Torres',   '+34 690 123 456'),
(11, 'carmen_diaz',  'carmen@example.com',  '$2a$10$KLzRQaSpyGfyEoOBqtlBluHOF25cj0gKofOjk21fB0z0LczceTeUu', 'Carmen Díaz',     '+34 601 234 567');

INSERT IGNORE INTO user_roles (user_id, role_id) VALUES
(7, 1),(8, 1),(9, 1),(10, 1),(11, 1);

-- Reportes de ejemplo
INSERT IGNORE INTO reports
  (id, status, animal_type, name, breed, color, size, event_date, description,
   distinctive_features, location_text, city, province,
   contact_name, contact_phone, contact_email, published_by, active)
VALUES
(1, 'LOST',  'DOG', 'Max',   'Labrador Retriever', 'Dorado',    'LARGE',  '2024-11-28',
  'Perro labrador muy amigable, se perdió cerca del parque. Responde a su nombre y le encanta jugar con pelotas.',
  'Collar rojo con chapa de identificación', 'Parque del Retiro', 'Madrid', 'Madrid',
  'María García', '+34 612 345 678', 'maria@example.com', 2, 1),

(2, 'FOUND', 'CAT', 'Luna',  'Siamés',             'Gris claro','SMALL',  '2024-11-29',
  'Gata siamesa encontrada cerca de la estación. Es muy tímida pero dócil. Parece estar bien cuidada.',
  'Ojos azules, collar morado', 'Estación de Atocha', 'Madrid', 'Madrid',
  'Carlos Rodríguez', '+34 623 456 789', 'carlos@example.com', 3, 1),

(3, 'FOUND', 'DOG', 'Rocky', 'Pastor Alemán',      'Negro y marrón','LARGE','2024-11-30',
  'Perro pastor alemán encontrado deambulando. Está bien cuidado y parece ser doméstico.',
  'Cicatriz pequeña en oreja derecha', 'Barrio de Salamanca', 'Madrid', 'Madrid',
  'Ana López', '+34 634 567 890', 'ana@example.com', 4, 1),

(4, 'LOST',  'CAT', 'Misu',  'Europeo común',      'Naranja',    'SMALL',  '2024-12-01',
  'Gato naranja muy cariñoso que salió por la ventana y no ha regresado. Le gustan las caricias.',
  'Mancha blanca en el pecho', 'Calle Gran Vía', 'Madrid', 'Madrid',
  'Pedro Martínez', '+34 645 678 901', 'pedro@example.com', 5, 1),

(5, 'LOST',  'DOG', 'Lola',  'Beagle',             'Tricolor',   'MEDIUM', '2024-12-02',
  'Beagle muy juguetona desaparecida en el parque. Tiene microchip. Recompensa.',
  'Collar azul con cascabel', 'Parque de El Retiro', 'Madrid', 'Madrid',
  'Laura Sánchez', '+34 656 789 012', 'laura@example.com', 6, 1),

(6, 'FOUND', 'BIRD','Pipo',  'Periquito',           'Verde y amarillo','SMALL','2024-12-03',
  'Periquito encontrado en el balcón. Parece domesticado, habla algunas palabras.',
  'Anilla azul en la pata izquierda', 'Calle Alcalá', 'Madrid', 'Madrid',
  'María García', '+34 612 345 678', 'maria@example.com', 2, 1),

(7, 'LOST',  'DOG', 'Bruno', 'Bulldog Francés',    'Atigrado',   'SMALL',  '2024-12-04',
  'Bulldog francés muy dócil. Se escapó por la puerta. Necesita medicación diaria.',
  'Oreja cortada parcialmente, collar negro', 'Barrio de Malasaña', 'Madrid', 'Madrid',
  'Carlos Rodríguez', '+34 623 456 789', 'carlos@example.com', 3, 1),

(8, 'FOUND', 'DOG', NULL,    'Mestizo',             'Blanco y negro','MEDIUM','2024-12-05',
  'Perro mestizo encontrado en la calle. No tiene collar. Muy tranquilo y obediente.',
  NULL, 'Avenida de América', 'Madrid', 'Madrid',
  'Ana López', '+34 634 567 890', 'ana@example.com', 4, 1),

(9, 'LOST',  'CAT', 'Nala',  'Persa',              'Blanco',     'MEDIUM', '2024-12-06',
  'Gata persa muy asustadiza. Salió al patio y no ha vuelto. Tiene las vacunas al día.',
  'Pelo largo, lazo rosa en el cuello', 'Barrio de Lavapiés', 'Madrid', 'Madrid',
  'Pedro Martínez', '+34 645 678 901', 'pedro@example.com', 5, 1),

(10,'FOUND', 'CAT', NULL,    'Europeo',             'Negro',      'SMALL',  '2024-12-07',
  'Gato negro encontrado mojado bajo un coche. Está en buen estado. Busca dueño.',
  'Sin collar, muy sociable', 'Calle Fuencarral', 'Madrid', 'Madrid',
  'Laura Sánchez', '+34 656 789 012', 'laura@example.com', 6, 1),

-- DOG (7 reportes: 4 LOST, 3 FOUND) --
(11, 'LOST',  'DOG', 'Rex',   'Rottweiler',          'Negro',             'LARGE',  '2025-01-05',
  'Rottweiler joven muy cariñoso. Se escapó durante un paseo. Tiene microchip. Muy asustadizo con desconocidos.',
  'Collar negro con nombre grabado', 'Avenida del Puerto', 'Valencia', 'Valencia',
  'Sofia Fernández', '+34 667 890 123', 'sofia@example.com', 7, 1),

(12, 'LOST',  'DOG', 'Coco',  'Chihuahua',           'Marrón',            'SMALL',  '2025-01-08',
  'Chihuahua muy pequeño que salió por la puerta entreabierta. Lleva collar rosa. Recompensa.',
  'Collar rosa con cascabel, mancha blanca en frente', 'Barrio Gràcia', 'Barcelona', 'Barcelona',
  'Diego Moreno', '+34 678 901 234', 'diego@example.com', 8, 1),

(13, 'LOST',  'DOG', 'Toby',  'Golden Retriever',    'Dorado',            'LARGE',  '2025-01-12',
  'Golden muy sociable desaparecido cerca del río. Le encantan los niños. Responde a su nombre.',
  'Collar verde con chapa', 'Parque de María Luisa', 'Sevilla', 'Sevilla',
  'Elena Ruiz', '+34 689 012 345', 'elena@example.com', 9, 1),

(14, 'LOST',  'DOG', 'Thor',  'Husky Siberiano',     'Blanco y gris',     'LARGE',  '2025-01-15',
  'Husky muy activo que se escapó durante una tormenta. Ojos azules. Puede estar asustado.',
  'Ojos azules heterocromía leve, sin collar cuando se perdió', 'Casco Viejo', 'Bilbao', 'País Vasco',
  'Javier Torres', '+34 690 123 456', 'javier@example.com', 10, 1),

(15, 'FOUND', 'DOG', 'Bobby', 'Mestizo',             'Marrón',            'MEDIUM', '2025-01-18',
  'Perro mestizo encontrado en el parque del Tío Jorge. Está en buen estado y es muy dócil.',
  'Sin collar, tiene una cicatriz en la pata trasera derecha', 'Parque del Tío Jorge', 'Zaragoza', 'Aragón',
  'Carmen Díaz', '+34 601 234 567', 'carmen@example.com', 11, 1),

(16, 'FOUND', 'DOG', NULL,    'Border Collie',       'Negro y blanco',    'MEDIUM', '2025-01-20',
  'Border collie encontrado en la playa. Parece bien cuidado y obedece órdenes básicas.',
  'Sin collar, muy inteligente y obediente', 'Playa de la Malagueta', 'Málaga', 'Málaga',
  'María García', '+34 612 345 678', 'maria@example.com', 2, 1),

(17, 'FOUND', 'DOG', 'Simba', 'Cocker Spaniel',      'Rubio',             'MEDIUM', '2025-01-22',
  'Cocker spaniel encontrado cerca del centro. Muy afectuoso. Parece que tiene dueño.',
  'Pelo largo bien cuidado, collar azul sin chapa', 'Gran Vía de Granada', 'Granada', 'Granada',
  'Carlos Rodríguez', '+34 623 456 789', 'carlos@example.com', 3, 1),

-- CAT (5 reportes: 3 LOST, 2 FOUND) --
(18, 'LOST',  'CAT', 'Mochi', 'Maine Coon',          'Gris',              'LARGE',  '2025-01-25',
  'Gato Maine Coon grande y peludo. Muy tranquilo. Se perdió en el portal. Tiene microchip.',
  'Pelo largo gris plateado, ojos amarillos', 'Explanada de España', 'Alicante', 'Alicante',
  'Ana López', '+34 634 567 890', 'ana@example.com', 4, 1),

(19, 'LOST',  'CAT', 'Kira',  'Ragdoll',             'Blanco y gris',     'MEDIUM', '2025-01-27',
  'Gata Ragdoll muy dulce. Salió al balcón y desapareció. Nunca ha salido sola.',
  'Ojos azules, punta de las patas oscuras', 'Barrio Eixample', 'Barcelona', 'Barcelona',
  'Diego Moreno', '+34 678 901 234', 'diego@example.com', 8, 1),

(20, 'LOST',  'CAT', 'Loki',  'Bengalí',             'Atigrado marrón',   'SMALL',  '2025-01-30',
  'Gato bengalí muy activo. Escapó por una ventana. Puede mostrarse esquivo con extraños.',
  'Manchas de leopardo, sin collar', 'Barrio Ruzafa', 'Valencia', 'Valencia',
  'Sofia Fernández', '+34 667 890 123', 'sofia@example.com', 7, 1),

(21, 'FOUND', 'CAT', NULL,    'Siamés',              'Beige y marrón',    'SMALL',  '2025-02-02',
  'Gata siamesa encontrada en un jardín. Muy vocaliza. Parece tener dueño pues está muy bien cuidada.',
  'Puntos oscuros en cara y patas, sin collar', 'Parque de los Príncipes', 'Sevilla', 'Sevilla',
  'Elena Ruiz', '+34 689 012 345', 'elena@example.com', 9, 1),

(22, 'FOUND', 'CAT', 'Nube',  'Persa',               'Blanco',            'MEDIUM', '2025-02-05',
  'Gato persa blanco encontrado en un portal. Está algo sucio pero en buen estado de salud.',
  'Pelo largo enredado, sin collar', 'Calle Licenciado Poza', 'Bilbao', 'País Vasco',
  'Javier Torres', '+34 690 123 456', 'javier@example.com', 10, 1),

-- BIRD (3 reportes: 1 LOST, 2 FOUND) --
(23, 'LOST',  'BIRD', 'Kiwi', 'Cacatúa ninfa',       'Gris y amarillo',   'SMALL',  '2025-02-08',
  'Cacatúa que voló desde el balcón. Dice su nombre y otras palabras. Muy sociable.',
  'Cresta amarilla, anilla verde en pata izquierda', 'Paseo de la Independencia', 'Zaragoza', 'Aragón',
  'Carmen Díaz', '+34 601 234 567', 'carmen@example.com', 11, 1),

(24, 'FOUND', 'BIRD', NULL,   'Agapornis',           'Verde y rojo',      'SMALL',  '2025-02-10',
  'Agapornis encontrado posado en una terraza. Parece domesticado, no tiene miedo a las personas.',
  'Sin anilla visible', 'Paseo del Parque', 'Málaga', 'Málaga',
  'Laura Sánchez', '+34 656 789 012', 'laura@example.com', 6, 1),

(25, 'FOUND', 'BIRD', NULL,   'Canario',             'Amarillo',          'SMALL',  '2025-02-12',
  'Canario amarillo encontrado en un árbol del parque. Canta mucho. Debe de ser doméstico.',
  'Sin anilla', 'Parque Federico García Lorca', 'Granada', 'Granada',
  'Pedro Martínez', '+34 645 678 901', 'pedro@example.com', 5, 1),

-- REPTILE (3 reportes: 2 LOST, 1 FOUND) --
(26, 'LOST',  'REPTILE', 'Spike', 'Gecko leopardo',  'Naranja y negro',   'SMALL',  '2025-02-15',
  'Gecko leopardo que escapó de su terrario. Busca lugares cálidos y oscuros. Es inofensivo.',
  'Manchas negras sobre fondo naranja, sin cola regenerada', 'Barrio Benimaclet', 'Valencia', 'Valencia',
  'Sofia Fernández', '+34 667 890 123', 'sofia@example.com', 7, 1),

(27, 'LOST',  'REPTILE', 'Drako', 'Dragón barbudo',  'Marrón arenoso',    'SMALL',  '2025-02-18',
  'Dragón barbudo que salió del terrario durante una limpieza. Es dócil y está acostumbrado a personas.',
  'Barba oscura cuando se asusta, uñas sin cortar', 'Barrio La Almozara', 'Zaragoza', 'Aragón',
  'Carmen Díaz', '+34 601 234 567', 'carmen@example.com', 11, 1),

(28, 'FOUND', 'REPTILE', 'Iggy', 'Iguana verde',     'Verde',             'MEDIUM', '2025-02-20',
  'Iguana encontrada en una terraza del quinto piso. Está bien alimentada. Claramente es una mascota.',
  'Cresta dorsal completa, uñas largas', 'Barrio Poblenou', 'Barcelona', 'Barcelona',
  'Diego Moreno', '+34 678 901 234', 'diego@example.com', 8, 1),

-- OTHER (2 reportes: 1 LOST, 1 FOUND) --
(29, 'LOST',  'OTHER', 'Buba', 'Conejo enano',       'Blanco',            'SMALL',  '2025-02-22',
  'Conejo enano blanco que escapó de su jaula en el jardín. Muy tímido con desconocidos.',
  'Ojos rosados, orejas largas, sin collar', 'Barrio San Blas', 'Alicante', 'Alicante',
  'Ana López', '+34 634 567 890', 'ana@example.com', 4, 1),

(30, 'FOUND', 'OTHER', NULL,   'Hámster dorado',     'Dorado',            'SMALL',  '2025-02-25',
  'Hámster encontrado corriendo por el pasillo de un edificio. Está sano y activo.',
  'Sin marcas distintivas', 'Barrio Triana', 'Sevilla', 'Sevilla',
  'Elena Ruiz', '+34 689 012 345', 'elena@example.com', 9, 1);
