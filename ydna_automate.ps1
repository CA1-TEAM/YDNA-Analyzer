# Configuration
$config = @{
    BasePath = "C:\MyScripts"
    TableauPath = "C:\Users\$env:USERNAME\Documents\My Tableau Repository\Datasources"
    CsvOutput = Join-Path -Path $config.BasePath -ChildPath "cleaned_ydna.csv"
}

# Functions

function Test-SafePath {
    param ([string]$Path)
    try {
        [System.IO.Path]::GetFullPath($Path) | Out-Null
        return $true
    } catch {
        Write-Warning "Invalid path detected: $Path"
        return $false
    }
}


function Copy-SafeFile {
    
    param ([string]$Source, [string]$Destination)
   
    if ((Test-SafePath $Source) -and (Test-SafePath $Destination) -and (Test-Path $Source)) {
        try {
            Copy-Item -Path $Source -Destination $Destination -Force
            Write-Output "File securely copied to: $Destination"
        } catch {
            Write-Warning "File copy failed: $_"
        }
    } else {
        Write-Warning "Invalid source or destination path. Copy operation aborted."
    }
}


function Verify-FileIntegrity {
    param ([string]$FilePath)
    if (Test-Path $FilePath) {
        $hash = Get-FileHash -Path $FilePath -Algorithm SHA256
        Write-Output "File hash: $($hash.Hash)"
        # Optionally, compare the hash with a trusted reference
        return $true
    } else {
        Write-Warning "File not found for integrity check: $FilePath"
        return $false
    }
}


function Validate-Destination {
    param ([string]$Destination)
    if (-not (Test-Path $Destination)) {
        try {
            New-Item -ItemType Directory -Path $Destination | Out-Null
            Write-Output "Destination directory created: $Destination"
        } catch {
            Write-Warning "Failed to create destination directory: $Destination"
        }
    }
}

# Workflow

try {
    if (-not (Test-SafePath $config.CsvOutput)) { throw "Invalid output file path." }
    if (-not (Verify-FileIntegrity $config.CsvOutput)) { throw "File integrity check failed." }
    Validate-Destination -Destination $config.TableauPath
    Copy-SafeFile -Source $config.CsvOutput -Destination $config.TableauPath
    Write-Output "Workflow completed successfully."
} catch {
    Write-Error "Workflow error: $_"
}

