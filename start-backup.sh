#!/bin/bash

# ***********************************************************************************************
# Backup Bitbucket repos using SCM Backup docker image.
# ***********************************************************************************************

# set -euxo pipefail  # Enable debugging mode
set -euo pipefail # Enable exit immediately on error

# Print input variables
echo "Input variables..."
echo ""

# Get current date in YYYY-MM-DD format
CURRENT_DATE=$(date +%Y-%m-%d)
echo "CURRENT DATE: $CURRENT_DATE"

# Get current time in HHMM format without the colon character
CURRENT_TIME=$(date +%H%M)
echo "CURRENT TIME: $CURRENT_TIME"

# Get timestamp as short date and short time
SHORT_DATE_AND_TIME="${CURRENT_DATE}_${CURRENT_TIME}"
echo "SHORT DATE AND TIME: $SHORT_DATE_AND_TIME"

# Get current directory
CURRENT_DIR=$(pwd)
echo "CURRENT_DIR: $CURRENT_DIR"

# Define backup directory path
BACKUP_DIR="${CURRENT_DIR}/${SHORT_DATE_AND_TIME}"
echo "BACKUP_DIR: ${BACKUP_DIR}"

# Create the backup directory if it doesn't already exist
if [[ ! -d "${BACKUP_DIR}" ]]; then
    mkdir -p "${BACKUP_DIR}"
    chmod 777 "${BACKUP_DIR}"
fi

if ! docker run --rm \
    -v "${CURRENT_DIR}/settings.yml:/app/settings.yml" \
    -v "${BACKUP_DIR}:/app/backups" \
    scmbackup:1.10.1; then
    echo "ERROR: Failed to start SCM Backup." >&2
    exit 1
fi

