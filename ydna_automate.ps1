
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
        return $false
    }
}

function Copy-SafeFile {
    param ([string]$Source, [string]$Destination)
    if ((Test-SafePath $Source) -and (Test-SafePath $Destination) -and (Test-Path $Source)) {
        Copy-Item -Path $Source -Destination $Destination -Force
        Write-Output "File copied to: $Destination"
    } else {
        Write-Warning "File copy failed: Invalid source or destination."
    }
}

# Workflow
try {
    if (-not (Test-SafePath $config.CsvOutput)) { throw "Invalid output file path." }
    Copy-SafeFile -Source $config.CsvOutput -Destination $config.TableauPath
    Write-Output "Workflow completed successfully."
} catch {
    Write-Error "Error occurred: $_"
}
