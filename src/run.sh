#! /bin/sh

set -eu

# Set default values
if [ "$S3_S3V4" = "yes" ]; then
  aws configure set default.s3.signature_version s3v4
fi

# Run backup
sh backup.sh

# If heartbeat url is set call it
if [ -n "${HEARTBEAT_URL:-}" ]; then
  echo "Calling heartbeat url"
  curl -sSf -XPOST "${HEARTBEAT_URL}"
fi