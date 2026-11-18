param(
    [int]$Repeticiones = 200,
    [long]$SolicitudId = 1,
    [string]$Base = "http://localhost:8090",
    [string]$Correo = "jperez@uteq.edu.ec",
    [string]$Clave = "admin123",
    [string]$Salida = "resultado-medicion.txt"
)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Net.Http
$cliente = New-Object System.Net.Http.HttpClient

$datosLogin = @{ email = $Correo; password = $Clave } | ConvertTo-Json
$contenidoLogin = New-Object System.Net.Http.StringContent($datosLogin, [System.Text.Encoding]::UTF8, "application/json")
$respuestaLogin = $cliente.PostAsync("$Base/api/auth/login", $contenidoLogin).Result
$token = ($respuestaLogin.Content.ReadAsStringAsync().Result | ConvertFrom-Json).token
$cliente.DefaultRequestHeaders.Authorization = New-Object System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", $token)

$sobre = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:est="http://uteq.edu.ec/presustentaciones/estado"><soapenv:Header/><soapenv:Body><est:ConsultarEstadoSolicitudRequest><est:solicitudId>' + $SolicitudId + '</est:solicitudId></est:ConsultarEstadoSolicitudRequest></soapenv:Body></soapenv:Envelope>'
$bytesSobre = [System.Text.Encoding]::UTF8.GetByteCount($sobre)

function Invocar-Rest {
    $respuesta = $cliente.GetAsync("$Base/api/estado/solicitud/$SolicitudId").Result
    return ,$respuesta.Content.ReadAsByteArrayAsync().Result
}

function Invocar-Soap {
    $contenido = New-Object System.Net.Http.StringContent($sobre, [System.Text.Encoding]::UTF8, "text/xml")
    $respuesta = $cliente.PostAsync("$Base/ws", $contenido).Result
    return ,$respuesta.Content.ReadAsByteArrayAsync().Result
}

function Resumir($nombre, $tiempos, $bytesPeticion, $bytesRespuesta) {
    $orden = @($tiempos | Sort-Object)
    $n = $orden.Count
    [pscustomobject]@{
        Estilo              = $nombre
        "Peticion (bytes)"  = $bytesPeticion
        "Respuesta (bytes)" = $bytesRespuesta
        "Promedio (ms)"     = [math]::Round(($orden | Measure-Object -Average).Average, 2)
        "Mediana (ms)"      = [math]::Round($orden[[int][math]::Floor($n / 2)], 2)
        "P95 (ms)"          = [math]::Round($orden[[int][math]::Ceiling($n * 0.95) - 1], 2)
    }
}

$ejemploRest = [System.Text.Encoding]::UTF8.GetString((Invocar-Rest))
$ejemploSoap = [System.Text.Encoding]::UTF8.GetString((Invocar-Soap))

for ($i = 0; $i -lt 20; $i++) { Invocar-Rest | Out-Null; Invocar-Soap | Out-Null }

$tiemposRest = New-Object System.Collections.Generic.List[double]
$tiemposSoap = New-Object System.Collections.Generic.List[double]
$reloj = New-Object System.Diagnostics.Stopwatch
$bytesRest = 0
$bytesSoap = 0
for ($i = 0; $i -lt $Repeticiones; $i++) {
    $reloj.Restart(); $cuerpo = Invocar-Rest; $reloj.Stop()
    $tiemposRest.Add($reloj.Elapsed.TotalMilliseconds); $bytesRest = $cuerpo.Length
    $reloj.Restart(); $cuerpo = Invocar-Soap; $reloj.Stop()
    $tiemposSoap.Add($reloj.Elapsed.TotalMilliseconds); $bytesSoap = $cuerpo.Length
}

$tabla = @(
    Resumir "REST (JSON)" $tiemposRest 0 $bytesRest
    Resumir "SOAP (XML)" $tiemposSoap $bytesSobre $bytesSoap
)

$informe = @()
$informe += "Medicion REST frente a SOAP - PresustentacionesAWPS"
$informe += "Fecha: " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + "   Equipo: " + $env:COMPUTERNAME + "   Usuario: " + $env:USERNAME
$informe += "Consulta: estado de la solicitud $SolicitudId   Repeticiones por estilo: $Repeticiones (alternadas, tras 20 de calentamiento)"
$informe += ""
$informe += "Respuesta REST  GET $Base/api/estado/solicitud/$SolicitudId"
$informe += $ejemploRest
$informe += ""
$informe += "Respuesta SOAP  POST $Base/ws  (operacion ConsultarEstadoSolicitud)"
$informe += $ejemploSoap
$informe += ""
$informe += ($tabla | Format-Table -AutoSize | Out-String).TrimEnd()
$informe += ""
$informe += "Relacion de tamano de la respuesta SOAP/REST: " + [math]::Round($bytesSoap / [math]::Max($bytesRest, 1), 2)

$informe | ForEach-Object { Write-Output $_ }
$informe | Out-File -FilePath $Salida -Encoding utf8
$cliente.Dispose()
