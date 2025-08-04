param (
    [string]$sourceFile,   # Full path to .cpp file
    [string]$exeFile       # Filename like "B.exe"
)

#Write-Host "Parameter sourceFile: '$sourceFile'"
#Write-Host "Parameter exeFile: '$exeFile'"

# Compose full path to the executable, same folder as sourceFile
#$sourceDir = Split-Path $sourceFile
#$exePath = Join-Path $sourceDir $exeFile
$sourceDir = Split-Path $sourceFile
$vsCodeDir = Join-Path $sourceDir ".vscode"
$exePath = Join-Path $vsCodeDir $exeFile


#Write-Host "Computed exePath: '$exePath'"

# Check source file exists
if (-not (Test-Path $sourceFile)) {
    Write-Host "ERROR: Source file not found: $sourceFile"
    exit 1
}

# Determine if build is needed
$buildNeeded = $false

if (-not (Test-Path $exePath)) {
    #Write-Host "Executable does not exist. Build needed."
    $buildNeeded = $true
} else {
    $sourceTime = (Get-Item $sourceFile).LastWriteTimeUtc
    $exeTime = (Get-Item $exePath).LastWriteTimeUtc
   # Write-Host "Source last write time (UTC): $sourceTime"
   # Write-Host "Executable last write time (UTC): $exeTime"
    if ($sourceTime -gt $exeTime) {
        #Write-Host "Source is newer than executable. Build needed."
        $buildNeeded = $true
    } else {
        #Write-Host "Executable is up to date. No build needed."
    }
}

# Build if needed
if ($buildNeeded) {
    #Write-Host "Building executable..."
    # Run g++ and overwrite existing exe or create new one
    & g++ -std=c++20 "$sourceFile" -o "$exePath"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Build failed with exit code $LASTEXITCODE"
        exit 1
    }
    $newExeTime = (Get-Item $exePath).LastWriteTimeUtc
    #Write-Host "Build succeeded. New executable last write time: $newExeTime"
} else {
    #Write-Host "Skipping build."
}

# Run the executable using your existing run_time.ps1 script
$exeNameOnly = [System.IO.Path]::GetFileNameWithoutExtension($exeFile)
$runScript = "C:\\Users\\moofk\\Documents\\CPP\\.vscode\\run_time.ps1"

# Start run_time.ps1 in a new PowerShell window
Start-Process powershell -ArgumentList "-NoLogo", "-File", "`"$runScript`"", "`"$exeNameOnly`""
