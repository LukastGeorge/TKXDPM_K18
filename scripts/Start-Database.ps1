$ErrorActionPreference='Stop'
$taskProject=Split-Path $PSScriptRoot -Parent
$taskEnv=Join-Path $taskProject '.env'
if (!(Test-Path -LiteralPath $taskEnv)) {
 $taskBytes=New-Object byte[] 24
 [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($taskBytes)
 $taskPassword=([BitConverter]::ToString($taskBytes)).Replace('-','').ToLowerInvariant()
 [IO.File]::WriteAllText($taskEnv,"BOOK_DB_USER=bookshop`nBOOK_DB_PASSWORD=$taskPassword`nBOOK_DB_URL=jdbc:postgresql://127.0.0.1:55432/bookshop`nBOOK_HTTP_PORT=8080`n",[Text.UTF8Encoding]::new($false))
}
Push-Location $taskProject
try { docker compose --env-file .env up -d --wait db; if($LASTEXITCODE -ne 0){throw 'PostgreSQL did not become healthy'} } finally { Pop-Location }
