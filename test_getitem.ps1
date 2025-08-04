param([string]$src, [string]$exe)

Write-Host "Checking source file: $src"
try {
    $si = Get-Item -LiteralPath $src -ErrorAction Stop
    Write-Host "Source last write (UTC): $($si.LastWriteTimeUtc)"
} catch {
    Write-Host "ERROR: Cannot access source file"
}

Write-Host "Checking executable file: $exe"
try {
    $ei = Get-Item -LiteralPath $exe -ErrorAction Stop
    Write-Host "Executable last write (UTC): $($ei.LastWriteTimeUtc)"
} catch {
    Write-Host "Executable not found."
}
