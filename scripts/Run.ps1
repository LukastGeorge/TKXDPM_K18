param([ValidateSet('run','test','verify','package')][string]$Action='run')
$ErrorActionPreference='Stop'
$taskProject=Split-Path $PSScriptRoot -Parent
$taskEnv=Join-Path $taskProject '.env'
if(Test-Path -LiteralPath $taskEnv){Get-Content -LiteralPath $taskEnv | ForEach-Object {if($_ -match '^([A-Z_]+)=(.*)$'){[Environment]::SetEnvironmentVariable($Matches[1],$Matches[2],'Process')}}}
Push-Location $taskProject
try {
 if($Action -eq 'run'){mvn spring-boot:run} else {mvn $Action}
 if($LASTEXITCODE -ne 0){throw "Maven $Action failed; see output above"}
} finally {Pop-Location}
