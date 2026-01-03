$SCM_BACKUP_SOURCE_PATH = "/usr/local/src/scm-backup"
$SCM_BACKUP_DOCKERFILE_PATH = Join-Path $SCM_BACKUP_SOURCE_PATH "Dockerfile"
$TAG = "1.10.1" # Leave empty to use 'latest' tag - otherwise specify a tag like '1.10.1'
if ($TAG -ne "") {
    $COLONEDTAG = ":$TAG"
} else {
    $COLONEDTAG = ""
}
docker build -f $SCM_BACKUP_DOCKERFILE_PATH $SCM_BACKUP_SOURCE_PATH --force-rm -t scmbackup$COLONEDTAG --build-arg BUILD_CONFIGURATION=Debug --label "com.microsoft.created-by=visual-studio" --label "com.microsoft.visual-studio.project-name=ScmBackup"