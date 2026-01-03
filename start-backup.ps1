# ***********************************************************************************************
# Backup GIT / Mercurial repos using SCM Backup docker image.
# See build-image.ps1 for building the Docker image.
# ***********************************************************************************************

# Enable strict error handling
$ErrorActionPreference = "Stop"

# Print input variables
Write-Host "Input variables..."
Write-Host ""

# Get current date in YYYY-MM-DD format
$CURRENT_DATE = Get-Date -Format "yyyy-MM-dd"
Write-Host "CURRENT DATE: $CURRENT_DATE"

# Get current time in HHMM format without the colon character
$CURRENT_TIME = Get-Date -Format "HHmm"
Write-Host "CURRENT TIME: $CURRENT_TIME"

# Get timestamp as short date and short time
$SHORT_DATE_AND_TIME = "${CURRENT_DATE}_${CURRENT_TIME}"
Write-Host "SHORT DATE AND TIME: $SHORT_DATE_AND_TIME"

# Get current directory path (PowerShell natively handles Windows paths)
$CURRENT_DIR = $PWD.Path
Write-Host "CURRENT_DIR: $CURRENT_DIR"

# Define backup directory path
$BACKUP_DIR = Join-Path $CURRENT_DIR ${SHORT_DATE_AND_TIME}
Write-Host "BACKUP_DIR: $BACKUP_DIR"

# Create the backup directory if it doesn't already exist
if (!(Test-Path $BACKUP_DIR)) {
    New-Item -ItemType Directory -Path $BACKUP_DIR -Force | Out-Null
    chmod 777 $BACKUP_DIR
}

# Run Docker container to perform backup
try {
    docker run --rm `
        -v "${CURRENT_DIR}/settings.yml:/app/settings.yml" `
        -v "${BACKUP_DIR}:/app/backups" `
        scmbackup:1.10.1
}
catch {
    Write-Error "ERROR: Failed to start SCM Backup."
    exit 1
}
