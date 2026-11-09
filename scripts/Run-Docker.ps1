param([ValidateSet('run','verify','stop')][string]$Action='run')
$ErrorActionPreference='Stop'
$taskProject=Split-Path $PSScriptRoot -Parent
Push-Location $taskProject
try {
 if(!(Test-Path -LiteralPath '.env')){ & (Join-Path $PSScriptRoot 'Start-Database.ps1') }
 switch($Action){
  'verify' { docker compose run --rm verify }
  'run' { docker compose up -d db web }
  'stop' { docker compose stop web }
 }
 if($LASTEXITCODE -ne 0){throw "Docker $Action failed"}
} finally {Pop-Location}
