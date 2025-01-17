# Define base path and configuration

$config = @{
    BasePath = "C:\MyScripts"
    TableauPath = "C:\Users\$env:USERNAME\Documents\My Tableau Repository\Datasources"
}

# Define paths using Join-Path

$paths = @{
    
    Script = Join-Path -Path $config.BasePath -ChildPath "ydna.py"
    CsvInput = Join-Path -Path $config.BasePath -ChildPath "sample_ydna.csv"
    CsvOutput = Join-Path -Path $config.BasePath -ChildPath "cleaned_ydna.csv"
    Plot = Join-Path -Path $config.BasePath -ChildPath "scatter_plot.png"
    Project = Join-Path -Path $config.BasePath -ChildPath "Project"
}

function Test-WorkspacePaths {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [hashtable]$Paths
    )
    foreach ($path in $Paths.Values) {
        if (-not (Test-Path $path)) {
            Write-Warning "Invalid path: $path"
        } else {
            Write-Output "Path exists: $path"
        }
    }
}

function New-ProjectWorkspace {
   
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -ItemType Directory | Out-Null
        Write-Output "Created project folder: $Path"
    }
}

function Export-ToTableau {
   
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$SourcePath,
        [string]$DestinationPath
    )
    Copy-Item -Path $SourcePath -Destination $DestinationPath -Force
}

function Open-CsvInExcel {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )
    Start-Process -FilePath "excel.exe" -ArgumentList $Path
}

# Main workflow

try {
    
    # Create Project Folder
    New-ProjectWorkspace -Path $paths.Project
    Write-Output "Project folder verified or created."

    # Validate paths
    
    Test-WorkspacePaths -Paths $paths
    Write-Output "All paths have been validated."

    # Export CSV to Tableau and open in Excel
    
    xport-ToTableau -SourcePath $paths.CsvOutput -DestinationPath $config.TableauPath
    Write-Output "CSV exported to Tableau."

    Open-CsvInExcel -Path $paths.CsvOutput
    Write-Output "CSV opened in Excel."

    Write-Output "Workflow completed successfully."

} catch {
    Write-Error "Workflow failed: $_"
}

Automat Tasks:

Create Project Folder (if doesn't exist):

Checks if the specified project folder exists. If not true it creates folder.
Validate Paths:

Validates the paths for  script, input CSV, output CSV, scatter plot, and project directory. If any of these paths are invalid, it will warn the user.

Export Cleaned CSV to Tableau:

Exports the cleaned CSV to the Tableau  directory for integration.
Open Cleaned CSV in Excel:

Opens the cleaned CSV in Excel for manual inspection,

We appreciate all feedback 

