#!/bin/sh

function log
{
    echo "$(date "+%Y-%m-%d %H:%M:%S") - $0 - $*"
}

log "I was called as: $0 $*"

# env export
export SCOPE="${SCOPE:-SCOPE_NAME}"
export BUCKET="${RCLONE_CONFIG_S3_BUCKET?Variable not set}"
export RCLONE_CONFIG_S3_TYPE="${RCLONE_CONFIG_S3_TYPE:-s3}"
export RCLONE_CONFIG_S3_PROVIDER="${RCLONE_CONFIG_S3_PROVIDER:-IDrive}"
export RCLONE_CONFIG_S3_NO_CHECK_BUCKET="${RCLONE_CONFIG_S3_NO_CHECK_BUCKET:-true}"
export RCLONE_CONFIG_S3_ACCESS_KEY_ID="${RCLONE_CONFIG_S3_ACCESS_KEY_ID?Variable not set}"
export RCLONE_CONFIG_S3_SECRET_ACCESS_KEY="${RCLONE_CONFIG_S3_SECRET_ACCESS_KEY?Variable not set}"
export RCLONE_CONFIG_S3_ENDPOINT="${RCLONE_CONFIG_S3_ENDPOINT?Variable not set}"

log "producing a new backup"
# nice will smoothen CPU usage
exec nice -n 5 sh -c 'tar -c backup | brotli -o backup.tar.br - && rclone copy backup.tar.br s3:"$BUCKET"/"$SCOPE" && rm -rf backup.tar.br && echo $(date "+%Y-%m-%d %H:%M:%S") - "backup successful!"'
