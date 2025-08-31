#!/bin/bash
# Usage: ./backup-to-gcs.sh <user> <bucket_name>
USER="$1"
BUCKET="$2"
SOURCE="/usr/local/apache2/htdocs/webdav/$USER"
gsutil -m rsync -r "$SOURCE" "gs://$BUCKET"
