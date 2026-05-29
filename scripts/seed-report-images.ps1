<#
.SYNOPSIS
    Sube imágenes de ejemplo a los 10 reportes del seed via la API de la aplicación.

.DESCRIPTION
    1. Hace login como admin y obtiene un JWT.
    2. Para cada reporte (ID 1-10) busca el archivo correspondiente en
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

# ── Datos de los 10 reportes del seed ─────────────────────────────────────────
$Reports = @(
    @{ id=1;  imageFile="01-max.jpg";     status="LOST";  animalType="DOG";  name="Max";   breed="Labrador Retriever"; color="Dorado";          size="LARGE";  eventDate="2024-11-28"; locationText="Parque del Retiro";    city="Madrid"; province="Madrid"; contactName="María García";     contactPhone="+34 612 345 678"; contactEmail="maria@example.com";   description="Perro labrador muy amigable, se perdió cerca del parque. Responde a su nombre y le encanta jugar con pelotas.";         distinctiveFeatures="Collar rojo con chapa de identificación" }
    @{ id=2;  imageFile="02-luna.jpg";    status="FOUND"; animalType="CAT";  name="Luna";  breed="Siamés";             color="Gris claro";      size="SMALL";  eventDate="2024-11-29"; locationText="Estación de Atocha";  city="Madrid"; province="Madrid"; contactName="Carlos Rodríguez"; contactPhone="+34 623 456 789"; contactEmail="carlos@example.com"; description="Gata siamesa encontrada cerca de la estación. Es muy tímida pero dócil. Parece estar bien cuidada.";              distinctiveFeatures="Ojos azules, collar morado" }
    @{ id=3;  imageFile="03-rocky.jpg";   status="FOUND"; animalType="DOG";  name="Rocky"; breed="Pastor Alemán";      color="Negro y marrón";  size="LARGE";  eventDate="2024-11-30"; locationText="Barrio de Salamanca"; city="Madrid"; province="Madrid"; contactName="Ana López";        contactPhone="+34 634 567 890"; contactEmail="ana@example.com";    description="Perro pastor alemán encontrado deambulando. Está bien cuidado y parece ser doméstico.";                          distinctiveFeatures="Cicatriz pequeña en oreja derecha" }
    @{ id=4;  imageFile="04-misu.jpg";    status="LOST";  animalType="CAT";  name="Misu";  breed="Europeo común";      color="Naranja";         size="SMALL";  eventDate="2024-12-01"; locationText="Calle Gran Vía";      city="Madrid"; province="Madrid"; contactName="Pedro Martínez";   contactPhone="+34 645 678 901"; contactEmail="pedro@example.com";  description="Gato naranja muy cariñoso que salió por la ventana y no ha regresado. Le gustan las caricias.";                  distinctiveFeatures="Mancha blanca en el pecho" }
    @{ id=5;  imageFile="05-lola.jpg";    status="LOST";  animalType="DOG";  name="Lola";  breed="Beagle";             color="Tricolor";        size="MEDIUM"; eventDate="2024-12-02"; locationText="Parque de El Retiro"; city="Madrid"; province="Madrid"; contactName="Laura Sánchez";    contactPhone="+34 656 789 012"; contactEmail="laura@example.com";  description="Beagle muy juguetona desaparecida en el parque. Tiene microchip. Recompensa.";                                    distinctiveFeatures="Collar azul con cascabel" }
    @{ id=6;  imageFile="06-pipo.jpg";    status="FOUND"; animalType="BIRD"; name="Pipo";  breed="Periquito";          color="Verde y amarillo"; size="SMALL"; eventDate="2024-12-03"; locationText="Calle Alcalá";        city="Madrid"; province="Madrid"; contactName="María García";     contactPhone="+34 612 345 678"; contactEmail="maria@example.com";   description="Periquito encontrado en el balcón. Parece domesticado, habla algunas palabras.";                                  distinctiveFeatures="Anilla azul en la pata izquierda" }
    @{ id=7;  imageFile="07-bruno.jpg";   status="LOST";  animalType="DOG";  name="Bruno"; breed="Bulldog Francés";    color="Atigrado";        size="SMALL";  eventDate="2024-12-04"; locationText="Barrio de Malasaña";  city="Madrid"; province="Madrid"; contactName="Carlos Rodríguez"; contactPhone="+34 623 456 789"; contactEmail="carlos@example.com"; description="Bulldog francés muy dócil. Se escapó por la puerta. Necesita medicación diaria.";                                  distinctiveFeatures="Oreja cortada parcialmente, collar negro" }
    @{ id=8;  imageFile="08-mestizo.jpg"; status="FOUND"; animalType="DOG";  name=$null;   breed="Mestizo";            color="Blanco y negro";  size="MEDIUM"; eventDate="2024-12-05"; locationText="Avenida de América";  city="Madrid"; province="Madrid"; contactName="Ana López";        contactPhone="+34 634 567 890"; contactEmail="ana@example.com";    description="Perro mestizo encontrado en la calle. No tiene collar. Muy tranquilo y obediente.";                              distinctiveFeatures=$null }
    @{ id=9;  imageFile="09-nala.jpg";    status="LOST";  animalType="CAT";  name="Nala";  breed="Persa";              color="Blanco";          size="MEDIUM"; eventDate="2024-12-06"; locationText="Barrio de Lavapiés";  city="Madrid"; province="Madrid"; contactName="Pedro Martínez";   contactPhone="+34 645 678 901"; contactEmail="pedro@example.com";  description="Gata persa muy asustadiza. Salió al patio y no ha vuelto. Tiene las vacunas al día.";                             distinctiveFeatures="Pelo largo, lazo rosa en el cuello" }
    @{ id=10; imageFile="10-negro.jpg";   status="FOUND"; animalType="CAT";  name=$null;   breed="Europeo";            color="Negro";           size="SMALL";  eventDate="2024-12-07"; locationText="Calle Fuencarral";    city="Madrid"; province="Madrid"; contactName="Laura Sánchez";    contactPhone="+34 656 789 012"; contactEmail="laura@example.com";  description="Gato negro encontrado mojado bajo un coche. Está en buen estado. Busca dueño.";                                   distinctiveFeatures="Sin collar, muy sociable" }
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
