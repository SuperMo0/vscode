param([string]$exeName)

$exeDir = $PSScriptRoot
$exePath = Join-Path $exeDir "$exeName.exe"

if (-not (Test-Path $exePath)) {
    Write-Host "ERROR: Executable not found at $exePath"
    exit 1
}

$start = Get-Date
& $exePath
$end = Get-Date
$duration = ($end - $start).TotalSeconds

Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ("{0:N3} seconds elapsed" -f $duration)
Write-Host ""
Write-Host -NoNewline "Press any key to exit..."
[void][System.Console]::ReadKey($true)
exit
