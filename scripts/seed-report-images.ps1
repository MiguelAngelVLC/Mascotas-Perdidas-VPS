<#
.SYNOPSIS
    Sube imágenes de ejemplo a los 30 reportes del seed via la API de la aplicación.

.DESCRIPTION
    1. Hace login como admin y obtiene un JWT.
    2. Para cada reporte (ID 1-30) busca el archivo correspondiente en
       database/seed-images/ y lo sube usando PUT /api/reports/{id}.

.PARAMETER ApiUrl
    URL base de la API. Por defecto http://localhost:8080.
    En producción: https://api.tudominio.com

.EXAMPLE
    # Entorno local (Docker Compose levantado)
    .\scripts\seed-report-images.ps1

    # VPS / producción
    .\scripts\seed-report-images.ps1 -ApiUrl "https://api.tudominio.com"
#>

param(
    [string]$ApiUrl = ""
)
if (-not $ApiUrl) { $ApiUrl = if ($env:API_URL) { $env:API_URL } else { "http://localhost:8080" } }

$ErrorActionPreference = "Stop"
$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$ImagesDir  = Join-Path $ScriptDir "..\database\seed-images"

# ── Credenciales admin ────────────────────────────────────────────────────────
$AdminUser  = "admin"
$AdminPass  = "Test1234!"

# ── Datos de los 30 reportes del seed ─────────────────────────────────────────
$Reports = @(
    @{ id=1;  imageFile="01-max.jpg";       status="LOST";  animalType="DOG";     name="Max";   breed="Labrador Retriever"; color="Dorado";           size="LARGE";  eventDate="2024-11-28"; locationText="Parque del Retiro";       city="Madrid";    province="Madrid";     contactName="María García";     contactPhone="+34 612 345 678"; contactEmail="maria@example.com";   description="Perro labrador muy amigable, se perdió cerca del parque. Responde a su nombre y le encanta jugar con pelotas.";       distinctiveFeatures="Collar rojo con chapa de identificación" }
    @{ id=2;  imageFile="02-luna.jpg";      status="FOUND"; animalType="CAT";     name="Luna";  breed="Siamés";             color="Gris claro";       size="SMALL";  eventDate="2024-11-29"; locationText="Estación de Atocha";      city="Madrid";    province="Madrid";     contactName="Carlos Rodríguez"; contactPhone="+34 623 456 789"; contactEmail="carlos@example.com"; description="Gata siamesa encontrada cerca de la estación. Es muy tímida pero dócil. Parece estar bien cuidada.";            distinctiveFeatures="Ojos azules, collar morado" }
    @{ id=3;  imageFile="03-rocky.jpg";     status="FOUND"; animalType="DOG";     name="Rocky"; breed="Pastor Alemán";      color="Negro y marrón";   size="LARGE";  eventDate="2024-11-30"; locationText="Barrio de Salamanca";     city="Madrid";    province="Madrid";     contactName="Ana López";        contactPhone="+34 634 567 890"; contactEmail="ana@example.com";    description="Perro pastor alemán encontrado deambulando. Está bien cuidado y parece ser doméstico.";                        distinctiveFeatures="Cicatriz pequeña en oreja derecha" }
    @{ id=4;  imageFile="04-misu.jpg";      status="LOST";  animalType="CAT";     name="Misu";  breed="Europeo común";      color="Naranja";          size="SMALL";  eventDate="2024-12-01"; locationText="Calle Gran Vía";          city="Madrid";    province="Madrid";     contactName="Pedro Martínez";   contactPhone="+34 645 678 901"; contactEmail="pedro@example.com";  description="Gato naranja muy cariñoso que salió por la ventana y no ha regresado. Le gustan las caricias.";                distinctiveFeatures="Mancha blanca en el pecho" }
    @{ id=5;  imageFile="05-lola.jpg";      status="LOST";  animalType="DOG";     name="Lola";  breed="Beagle";             color="Tricolor";         size="MEDIUM"; eventDate="2024-12-02"; locationText="Parque de El Retiro";     city="Madrid";    province="Madrid";     contactName="Laura Sánchez";    contactPhone="+34 656 789 012"; contactEmail="laura@example.com";  description="Beagle muy juguetona desaparecida en el parque. Tiene microchip. Recompensa.";                                  distinctiveFeatures="Collar azul con cascabel" }
    @{ id=6;  imageFile="06-pipo.jpg";      status="FOUND"; animalType="BIRD";    name="Pipo";  breed="Periquito";          color="Verde y amarillo"; size="SMALL";  eventDate="2024-12-03"; locationText="Calle Alcalá";            city="Madrid";    province="Madrid";     contactName="María García";     contactPhone="+34 612 345 678"; contactEmail="maria@example.com";   description="Periquito encontrado en el balcón. Parece domesticado, habla algunas palabras.";                                distinctiveFeatures="Anilla azul en la pata izquierda" }
    @{ id=7;  imageFile="07-bruno.jpg";     status="LOST";  animalType="DOG";     name="Bruno"; breed="Bulldog Francés";    color="Atigrado";         size="SMALL";  eventDate="2024-12-04"; locationText="Barrio de Malasaña";      city="Madrid";    province="Madrid";     contactName="Carlos Rodríguez"; contactPhone="+34 623 456 789"; contactEmail="carlos@example.com"; description="Bulldog francés muy dócil. Se escapó por la puerta. Necesita medicación diaria.";                              distinctiveFeatures="Oreja cortada parcialmente, collar negro" }
    @{ id=8;  imageFile="08-mestizo.jpg";   status="FOUND"; animalType="DOG";     name=$null;   breed="Mestizo";            color="Blanco y negro";   size="MEDIUM"; eventDate="2024-12-05"; locationText="Avenida de América";      city="Madrid";    province="Madrid";     contactName="Ana López";        contactPhone="+34 634 567 890"; contactEmail="ana@example.com";    description="Perro mestizo encontrado en la calle. No tiene collar. Muy tranquilo y obediente.";                            distinctiveFeatures=$null }
    @{ id=9;  imageFile="09-nala.jpg";      status="LOST";  animalType="CAT";     name="Nala";  breed="Persa";              color="Blanco";           size="MEDIUM"; eventDate="2024-12-06"; locationText="Barrio de Lavapiés";      city="Madrid";    province="Madrid";     contactName="Pedro Martínez";   contactPhone="+34 645 678 901"; contactEmail="pedro@example.com";  description="Gata persa muy asustadiza. Salió al patio y no ha vuelto. Tiene las vacunas al día.";                           distinctiveFeatures="Pelo largo, lazo rosa en el cuello" }
    @{ id=10; imageFile="10-negro.jpg";     status="FOUND"; animalType="CAT";     name=$null;   breed="Europeo";            color="Negro";            size="SMALL";  eventDate="2024-12-07"; locationText="Calle Fuencarral";        city="Madrid";    province="Madrid";     contactName="Laura Sánchez";    contactPhone="+34 656 789 012"; contactEmail="laura@example.com";  description="Gato negro encontrado mojado bajo un coche. Está en buen estado. Busca dueño.";                                 distinctiveFeatures="Sin collar, muy sociable" }
    # --- Reportes nuevos (11-30) ---
    @{ id=11; imageFile="11-rex.jpg";       status="LOST";  animalType="DOG";     name="Rex";   breed="Rottweiler";         color="Negro";            size="LARGE";  eventDate="2025-01-05"; locationText="Avenida del Puerto";      city="Valencia";  province="Valencia";   contactName="Sofia Fernández";  contactPhone="+34 667 890 123"; contactEmail="sofia@example.com";  description="Rottweiler joven muy cariñoso. Se escapó durante un paseo. Tiene microchip. Muy asustadizo con desconocidos.";  distinctiveFeatures="Collar negro con nombre grabado" }
    @{ id=12; imageFile="12-coco.jpg";      status="LOST";  animalType="DOG";     name="Coco";  breed="Chihuahua";          color="Marrón";           size="SMALL";  eventDate="2025-01-08"; locationText="Barrio Gràcia";           city="Barcelona"; province="Barcelona";  contactName="Diego Moreno";     contactPhone="+34 678 901 234"; contactEmail="diego@example.com";  description="Chihuahua muy pequeño que salió por la puerta entreabierta. Lleva collar rosa. Recompensa.";                   distinctiveFeatures="Collar rosa con cascabel, mancha blanca en frente" }
    @{ id=13; imageFile="13-toby.jpg";      status="LOST";  animalType="DOG";     name="Toby";  breed="Golden Retriever";   color="Dorado";           size="LARGE";  eventDate="2025-01-12"; locationText="Parque de María Luisa";   city="Sevilla";   province="Sevilla";    contactName="Elena Ruiz";       contactPhone="+34 689 012 345"; contactEmail="elena@example.com";  description="Golden muy sociable desaparecido cerca del río. Le encantan los niños. Responde a su nombre.";                 distinctiveFeatures="Collar verde con chapa" }
    @{ id=14; imageFile="14-thor.jpg";      status="LOST";  animalType="DOG";     name="Thor";  breed="Husky Siberiano";    color="Blanco y gris";    size="LARGE";  eventDate="2025-01-15"; locationText="Casco Viejo";             city="Bilbao";    province="País Vasco";  contactName="Javier Torres";    contactPhone="+34 690 123 456"; contactEmail="javier@example.com"; description="Husky muy activo que se escapó durante una tormenta. Ojos azules. Puede estar asustado.";                      distinctiveFeatures="Ojos azules heterocromía leve, sin collar cuando se perdió" }
    @{ id=15; imageFile="15-bobby.jpg";     status="FOUND"; animalType="DOG";     name="Bobby"; breed="Mestizo";            color="Marrón";           size="MEDIUM"; eventDate="2025-01-18"; locationText="Parque del Tío Jorge";    city="Zaragoza";  province="Aragón";     contactName="Carmen Díaz";      contactPhone="+34 601 234 567"; contactEmail="carmen@example.com"; description="Perro mestizo encontrado en el parque del Tío Jorge. Está en buen estado y es muy dócil.";                    distinctiveFeatures="Sin collar, tiene una cicatriz en la pata trasera derecha" }
    @{ id=16; imageFile="16-border.jpg";    status="FOUND"; animalType="DOG";     name=$null;   breed="Border Collie";      color="Negro y blanco";   size="MEDIUM"; eventDate="2025-01-20"; locationText="Playa de la Malagueta";   city="Málaga";    province="Málaga";     contactName="María García";     contactPhone="+34 612 345 678"; contactEmail="maria@example.com";  description="Border collie encontrado en la playa. Parece bien cuidado y obedece órdenes básicas.";                         distinctiveFeatures="Sin collar, muy inteligente y obediente" }
    @{ id=17; imageFile="17-simba.jpg";     status="FOUND"; animalType="DOG";     name="Simba"; breed="Cocker Spaniel";     color="Rubio";            size="MEDIUM"; eventDate="2025-01-22"; locationText="Gran Vía de Granada";     city="Granada";   province="Granada";    contactName="Carlos Rodríguez"; contactPhone="+34 623 456 789"; contactEmail="carlos@example.com"; description="Cocker spaniel encontrado cerca del centro. Muy afectuoso. Parece que tiene dueño.";                           distinctiveFeatures="Pelo largo bien cuidado, collar azul sin chapa" }
    @{ id=18; imageFile="18-mochi.jpg";     status="LOST";  animalType="CAT";     name="Mochi"; breed="Maine Coon";         color="Gris";             size="LARGE";  eventDate="2025-01-25"; locationText="Explanada de España";     city="Alicante";  province="Alicante";   contactName="Ana López";        contactPhone="+34 634 567 890"; contactEmail="ana@example.com";    description="Gato Maine Coon grande y peludo. Muy tranquilo. Se perdió en el portal. Tiene microchip.";                    distinctiveFeatures="Pelo largo gris plateado, ojos amarillos" }
    @{ id=19; imageFile="19-kira.jpg";      status="LOST";  animalType="CAT";     name="Kira";  breed="Ragdoll";            color="Blanco y gris";    size="MEDIUM"; eventDate="2025-01-27"; locationText="Barrio Eixample";         city="Barcelona"; province="Barcelona";  contactName="Diego Moreno";     contactPhone="+34 678 901 234"; contactEmail="diego@example.com";  description="Gata Ragdoll muy dulce. Salió al balcón y desapareció. Nunca ha salido sola.";                                 distinctiveFeatures="Ojos azules, punta de las patas oscuras" }
    @{ id=20; imageFile="20-loki.jpg";      status="LOST";  animalType="CAT";     name="Loki";  breed="Bengalí";            color="Atigrado marrón";  size="SMALL";  eventDate="2025-01-30"; locationText="Barrio Ruzafa";           city="Valencia";  province="Valencia";   contactName="Sofia Fernández";  contactPhone="+34 667 890 123"; contactEmail="sofia@example.com";  description="Gato bengalí muy activo. Escapó por una ventana. Puede mostrarse esquivo con extraños.";                       distinctiveFeatures="Manchas de leopardo, sin collar" }
    @{ id=21; imageFile="21-siames.jpg";    status="FOUND"; animalType="CAT";     name=$null;   breed="Siamés";             color="Beige y marrón";   size="SMALL";  eventDate="2025-02-02"; locationText="Parque de los Príncipes"; city="Sevilla";   province="Sevilla";    contactName="Elena Ruiz";       contactPhone="+34 689 012 345"; contactEmail="elena@example.com";  description="Gata siamesa encontrada en un jardín. Muy vocaliza. Parece tener dueño pues está muy bien cuidada.";          distinctiveFeatures="Puntos oscuros en cara y patas, sin collar" }
    @{ id=22; imageFile="22-nube.jpg";      status="FOUND"; animalType="CAT";     name="Nube";  breed="Persa";              color="Blanco";           size="MEDIUM"; eventDate="2025-02-05"; locationText="Calle Licenciado Poza";   city="Bilbao";    province="País Vasco";  contactName="Javier Torres";    contactPhone="+34 690 123 456"; contactEmail="javier@example.com"; description="Gato persa blanco encontrado en un portal. Está algo sucio pero en buen estado de salud.";                     distinctiveFeatures="Pelo largo enredado, sin collar" }
    @{ id=23; imageFile="23-kiwi.jpg";      status="LOST";  animalType="BIRD";    name="Kiwi";  breed="Cacatúa ninfa";      color="Gris y amarillo";  size="SMALL";  eventDate="2025-02-08"; locationText="Paseo de la Independencia";city="Zaragoza"; province="Aragón";     contactName="Carmen Díaz";      contactPhone="+34 601 234 567"; contactEmail="carmen@example.com"; description="Cacatúa que voló desde el balcón. Dice su nombre y otras palabras. Muy sociable.";                             distinctiveFeatures="Cresta amarilla, anilla verde en pata izquierda" }
    @{ id=24; imageFile="24-agapornis.jpg"; status="FOUND"; animalType="BIRD";    name=$null;   breed="Agapornis";          color="Verde y rojo";     size="SMALL";  eventDate="2025-02-10"; locationText="Paseo del Parque";        city="Málaga";    province="Málaga";     contactName="Laura Sánchez";    contactPhone="+34 656 789 012"; contactEmail="laura@example.com";  description="Agapornis encontrado posado en una terraza. Parece domesticado, no tiene miedo a las personas.";               distinctiveFeatures="Sin anilla visible" }
    @{ id=25; imageFile="25-canario.jpg";   status="FOUND"; animalType="BIRD";    name=$null;   breed="Canario";            color="Amarillo";         size="SMALL";  eventDate="2025-02-12"; locationText="Parque Federico García Lorca"; city="Granada"; province="Granada"; contactName="Pedro Martínez";   contactPhone="+34 645 678 901"; contactEmail="pedro@example.com";  description="Canario amarillo encontrado en un árbol del parque. Canta mucho. Debe de ser doméstico.";                      distinctiveFeatures="Sin anilla" }
    @{ id=26; imageFile="26-spike.jpg";     status="LOST";  animalType="REPTILE"; name="Spike"; breed="Gecko leopardo";     color="Naranja y negro";  size="SMALL";  eventDate="2025-02-15"; locationText="Barrio Benimaclet";       city="Valencia";  province="Valencia";   contactName="Sofia Fernández";  contactPhone="+34 667 890 123"; contactEmail="sofia@example.com";  description="Gecko leopardo que escapó de su terrario. Busca lugares cálidos y oscuros. Es inofensivo.";                    distinctiveFeatures="Manchas negras sobre fondo naranja, sin cola regenerada" }
    @{ id=27; imageFile="27-drako.jpg";     status="LOST";  animalType="REPTILE"; name="Drako"; breed="Dragón barbudo";     color="Marrón arenoso";   size="SMALL";  eventDate="2025-02-18"; locationText="Barrio La Almozara";      city="Zaragoza";  province="Aragón";     contactName="Carmen Díaz";      contactPhone="+34 601 234 567"; contactEmail="carmen@example.com"; description="Dragón barbudo que salió del terrario durante una limpieza. Es dócil y está acostumbrado a personas.";         distinctiveFeatures="Barba oscura cuando se asusta, uñas sin cortar" }
    @{ id=28; imageFile="28-iggy.jpg";      status="FOUND"; animalType="REPTILE"; name="Iggy";  breed="Iguana verde";       color="Verde";            size="MEDIUM"; eventDate="2025-02-20"; locationText="Barrio Poblenou";         city="Barcelona"; province="Barcelona";  contactName="Diego Moreno";     contactPhone="+34 678 901 234"; contactEmail="diego@example.com";  description="Iguana encontrada en una terraza del quinto piso. Está bien alimentada. Claramente es una mascota.";           distinctiveFeatures="Cresta dorsal completa, uñas largas" }
    @{ id=29; imageFile="29-buba.jpg";      status="LOST";  animalType="OTHER";   name="Buba";  breed="Conejo enano";       color="Blanco";           size="SMALL";  eventDate="2025-02-22"; locationText="Barrio San Blas";         city="Alicante";  province="Alicante";   contactName="Ana López";        contactPhone="+34 634 567 890"; contactEmail="ana@example.com";    description="Conejo enano blanco que escapó de su jaula en el jardín. Muy tímido con desconocidos.";                       distinctiveFeatures="Ojos rosados, orejas largas, sin collar" }
    @{ id=30; imageFile="30-hamster.jpg";   status="FOUND"; animalType="OTHER";   name=$null;   breed="Hámster dorado";     color="Dorado";           size="SMALL";  eventDate="2025-02-25"; locationText="Barrio Triana";           city="Sevilla";   province="Sevilla";    contactName="Elena Ruiz";       contactPhone="+34 689 012 345"; contactEmail="elena@example.com";  description="Hámster encontrado corriendo por el pasillo de un edificio. Está sano y activo.";                              distinctiveFeatures="Sin marcas distintivas" }
)

# ── Login ─────────────────────────────────────────────────────────────────────
Write-Host "Iniciando sesión como '$AdminUser'..."
$loginBody = @{ usernameOrEmail = $AdminUser; password = $AdminPass } | ConvertTo-Json
$loginResp  = Invoke-RestMethod -Method Post -Uri "$ApiUrl/api/auth/login" `
    -ContentType "application/json" -Body $loginBody
$token = $loginResp.token
if (-not $token) { Write-Error "No se obtuvo token. Revisa las credenciales o la URL."; exit 1 }
Write-Host "Login correcto. Token obtenido."

# ── Subir imágenes ────────────────────────────────────────────────────────────
$ok    = 0
$skip  = 0
$fail  = 0

foreach ($r in $Reports) {
    $imgPath = Join-Path $ImagesDir $r.imageFile
    if (-not (Test-Path $imgPath)) {
        Write-Warning "  [SKIP] Reporte $($r.id): archivo '$($r.imageFile)' no encontrado en $ImagesDir"
        $skip++
        continue
    }

    Write-Host "  [PUT]  Reporte $($r.id) ($($r.animalType) '$($r.name)') + $($r.imageFile)..."

    # Construir multipart manualmente con HttpClient para PowerShell 5 compatibilidad
    Add-Type -AssemblyName System.Net.Http
    $client   = [System.Net.Http.HttpClient]::new()
    $client.DefaultRequestHeaders.Authorization = `
        [System.Net.Http.Headers.AuthenticationHeaderValue]::new("Bearer", $token)

    $form = [System.Net.Http.MultipartFormDataContent]::new()

    $reportPayload = [ordered]@{
        status       = $r.status
        animalType   = $r.animalType
        eventDate    = $r.eventDate
        contactName  = $r.contactName
        contactPhone = $r.contactPhone
    }
    if ($r.name)                { $reportPayload.name                = $r.name }
    if ($r.breed)               { $reportPayload.breed               = $r.breed }
    if ($r.color)               { $reportPayload.color               = $r.color }
    if ($r.size)                { $reportPayload.size                = $r.size }
    if ($r.description)         { $reportPayload.description         = $r.description }
    if ($r.distinctiveFeatures) { $reportPayload.distinctiveFeatures = $r.distinctiveFeatures }
    if ($r.locationText)        { $reportPayload.locationText        = $r.locationText }
    if ($r.city)                { $reportPayload.city                = $r.city }
    if ($r.province)            { $reportPayload.province            = $r.province }
    if ($r.contactEmail)        { $reportPayload.contactEmail        = $r.contactEmail }

    $utf8 = [System.Text.Encoding]::UTF8
    $reportJson = ($reportPayload | ConvertTo-Json -Compress)
    $reportPart = [System.Net.Http.StringContent]::new($reportJson, $utf8, 'application/json')
    $form.Add($reportPart, 'report')

    # Parte de imagen
    $fileBytes    = [System.IO.File]::ReadAllBytes($imgPath)
    $imgContent   = [System.Net.Http.ByteArrayContent]::new($fileBytes)
    $ext          = [System.IO.Path]::GetExtension($imgPath).TrimStart(".").ToLower()
    $mimeType     = if ($ext -eq "png") { "image/png" } elseif ($ext -in @("gif")) { "image/gif" } elseif ($ext -eq "webp") { "image/webp" } else { "image/jpeg" }
    $imgContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::new($mimeType)
    $form.Add($imgContent, "image", [System.IO.Path]::GetFileName($imgPath))

    try {
        $response = $client.PutAsync("$ApiUrl/api/reports/$($r.id)", $form).Result
        if ($response.IsSuccessStatusCode) {
            Write-Host "         OK ($([int]$response.StatusCode))"
            $ok++
        } else {
            $body = $response.Content.ReadAsStringAsync().Result
            Write-Warning "         FAIL $([int]$response.StatusCode): $body"
            $fail++
        }
    } catch {
        Write-Warning "         ERROR: $_"
        $fail++
    } finally {
        $client.Dispose()
        $form.Dispose()
    }
}

# ── Resumen ───────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "Resultado: $ok OK  |  $skip omitidos (sin archivo)  |  $fail errores"
if ($skip -gt 0) {
    Write-Host "Añade los archivos que faltan en '$ImagesDir' y vuelve a ejecutar el script."
}
