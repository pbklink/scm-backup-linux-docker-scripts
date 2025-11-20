# SCM Backup on Linux with Docker

## About

[SCM Backup](https://scm-backup.org/) is a handy .NET application which backs up GIT (and Mercurial) repositories at GitHub, BitBucket (and possibly others) to your local computer.

A compiled version for Windows can be downloaded from the website. However for Linux, the application needs to be compiled from source.  Alternatively it can compiled within a Docker image and run via Docker.

## Contents

This repository contains 2 PowerShell scripts which assist with creating a Docker image and then running that image:

* **build-image.ps1**: Builds a Docker Image containing SCM Backup
* **start-backup.ps1**: Creates the destination folder for the backup and runs the Docker Image to perform the backup.

## Using

Steps for using are:

1. Ensure that Docker and PowerShell are installed.
1. Create a folder under `/usr/local/src` called `scm-backup`.
1. Download the latest SCM Backup [source](https://github.com/christianspecht/scm-backup/releases/latest)
1. Unzip the downloaded source file and copy the files and folders under the top level version folder, into the `scm-backup` folder under `/usr/local/src`.  That is `scm-backup`, should contain (amongst others), various batch and powershell files (eg. `build-release.ps1`) and a `src` folder.
1. In `.../scm-backup/src/ScmBackup` folder, there may be a file called `Dockerfile`.  If so, move this up 2 levels into the `.../scm-backup` folder. (It needs to be with the other script files that create releases). Future releases of SCM Backup may already have `Dockerfile` in this location.
1. Create a folder into which the backups will be placed.  For example `~/backups/`
1. Place the `build-image.ps1` and `start-backup.ps1` scripts into this backup folder.
1. Place your SCM Backup `settings.yml` into this backup folder.
1. Set the permissions on `settings.yml` to `644`
    ```bash
    chmod 644 settings.yml
    ```
1. Ensure that `localFolder` in `settings.yml` is set to `'./backups'`
    ```yaml
    localFolder: './backups'
    ```
    The script will map the actual destination folder for backups onto `./backups`.
1. Run the `build-image.ps1` script. This will generate the Docker image containing SCM Backup.  It only needs to be run once (unless the image is deleted).
1. Run the `start-backup.ps1` script. It will create a sub folder with a name reflecting the current date and time and then start SCM Backup which will carry out a backup according to settings in `settings.yml` and place the backup files in the created sub folder.

The scripts are quite simple so should be easy to customise to your needs.

## Acknowlegements

* **[lessismore-sparkvision](https://github.com/lessismore-sparkvision)** - Developer of the Docker file and [scripts](https://github.com/christianspecht/scm-backup/pull/78#issuecomment-2160204165) upon which the scripts in this repository are based.
* **[Christian Specht](https://christianspecht.de/)** - Developer of SCM Backup



