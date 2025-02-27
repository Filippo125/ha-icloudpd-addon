#!/bin/sh

OPTIONS_FILE="/data/options.json"

if [ -f "$OPTIONS_FILE" ]; then
  DEBUG=$(jq -r '.DEBUG // false' "$OPTIONS_FILE")
  DRY_RUN=$(jq -r '.DRY_RUN // true' "$OPTIONS_FILE")
  MFA_PROVIDER=$(jq -r '.MFA_PROVIDER // "webui"' "$OPTIONS_FILE")
  PASSWORD_PROVIDER=$(jq -r '.PASSWORD_PROVIDER // "webui"' "$OPTIONS_FILE")
  ICLOUD_DIRECTORY=$(jq -r '.ICLOUD_DIRECTORY // empty' "$OPTIONS_FILE")
  ICLOUD_USERNAME=$(jq -r '.ICLOUD_USERNAME // empty' "$OPTIONS_FILE")
  ICLOUD_PASSWORD=$(jq -r '.ICLOUD_PASSWORD // empty' "$OPTIONS_FILE")
  ICLOUD_AUTH_ONLY=$(jq -r '.ICLOUD_AUTH_ONLY // empty' "$OPTIONS_FILE")
  ICLOUD_WATCH_INTERVAL_SECONDS=$(jq -r '.ICLOUD_WATCH_INTERVAL_SECONDS // 3600' "$OPTIONS_FILE")
  ICLOUD_ALBUM=$(jq -r '.ICLOUD_ALBUM // empty' "$OPTIONS_FILE")
  ICLOUD_SKIP_VIDEOS=$(jq -r '.ICLOUD_SKIP_VIDEOS // empty' "$OPTIONS_FILE")
  ICLOUD_SKIP_LIVE_PHOTOS=$(jq -r '.ICLOUD_SKIP_LIVE_PHOTOS // empty' "$OPTIONS_FILE")
  ICLOUD_FOLDER_STRUCTURE=$(jq -r '.ICLOUD_FOLDER_STRUCTURE // empty' "$OPTIONS_FILE")
  ICLOUD_SET_EXIF_DATETIME=$(jq -r '.ICLOUD_SET_EXIF_DATETIME // empty' "$OPTIONS_FILE")
  ICLOUD_LOG_LEVEL=$(jq -r '.ICLOUD_LOG_LEVEL // empty' "$OPTIONS_FILE")
  ICLOUD_NO_PROGRESS_BAR=$(jq -r '.ICLOUD_NO_PROGRESS_BAR // empty' "$OPTIONS_FILE")
  ICLOUD_DELETE_AFTER_DOWNLOAD=$(jq -r '.ICLOUD_DELETE_AFTER_DOWNLOAD // empty' "$OPTIONS_FILE")
  if [ "$DEBUG" = "true" ]; then
    # Debug: print value
    echo "DEBUG: $DEBUG"
    echo "DRY_RUN: $DRY_RUN"
    echo "PASSWORD_PROVIDER: $PASSWORD_PROVIDER"
    echo "ICLOUD_DIRECTORY: $ICLOUD_DIRECTORY"
    echo "ICLOUD_USERNAME: $ICLOUD_USERNAME"
    echo "ICLOUD_PASSWORD: $ICLOUD_PASSWORD"
    echo "ICLOUD_AUTH_ONLY: $ICLOUD_AUTH_ONLY"
    echo "ICLOUD_WATCH_INTERVAL_SECONDS: $ICLOUD_WATCH_INTERVAL_SECONDS"
    echo "ICLOUD_ALBUM: $ICLOUD_ALBUM"
    echo "ICLOUD_SKIP_VIDEOS: $ICLOUD_SKIP_VIDEOS"
    echo "ICLOUD_SKIP_LIVE_PHOTOS: $ICLOUD_SKIP_LIVE_PHOTOS"
    echo "ICLOUD_FOLDER_STRUCTURE: $ICLOUD_FOLDER_STRUCTURE"
    echo "ICLOUD_SET_EXIF_DATETIME: $ICLOUD_SET_EXIF_DATETIME"
    echo "ICLOUD_LOG_LEVEL: $ICLOUD_LOG_LEVEL"
    echo "ICLOUD_NO_PROGRESS_BAR: $ICLOUD_NO_PROGRESS_BAR"
    echo "ICLOUD_DELETE_AFTER_DOWNLOAD: $ICLOUD_DELETE_AFTER_DOWNLOAD"
  fi
else
  echo "File $OPTIONS_FILE non trovato!"
  exit 1
fi

COMMAND="/app/icloudpd_ex icloudpd"
#[ "$DRY_RUN"  = "true" ] && COMMAND="$COMMAND --dry-run"
[ -n "$PASSWORD_PROVIDER" ] && COMMAND="$COMMAND --password-provider \"$PASSWORD_PROVIDER\""
[ -n "$MFA_PROVIDER" ] && COMMAND="$COMMAND --mfa-provider \"$MFA_PROVIDER\""
[ -n "$ICLOUD_DIRECTORY" ] && COMMAND="$COMMAND --directory \"$ICLOUD_DIRECTORY\""
[ -n "$ICLOUD_USERNAME" ] && COMMAND="$COMMAND --username \"$ICLOUD_USERNAME\""
[ -n "$ICLOUD_PASSWORD" ] && COMMAND="$COMMAND --password \"$ICLOUD_PASSWORD\""
[ "$ICLOUD_AUTH_ONLY" = "true" ] && COMMAND="$COMMAND --auth-only"
[ -n "$ICLOUD_WATCH_INTERVAL_SECONDS" ] && COMMAND="$COMMAND --watch-with-interval $ICLOUD_WATCH_INTERVAL_SECONDS"
[ -n "$ICLOUD_ALBUM" ] && COMMAND="$COMMAND --album \"$ICLOUD_ALBUM\""
[ "$ICLOUD_SKIP_VIDEOS" = "true" ] && COMMAND="$COMMAND --skip-videos"
[ "$ICLOUD_SKIP_LIVE_PHOTOS" = "true" ] && COMMAND="$COMMAND --skip-live-photos"
[ -n "$ICLOUD_FOLDER_STRUCTURE" ] && COMMAND="$COMMAND --folder-structure \"$ICLOUD_FOLDER_STRUCTURE\""
[ "$ICLOUD_SET_EXIF_DATETIME" = "true" ] && COMMAND="$COMMAND --set-exif-datetime"
[ -n "$ICLOUD_LOG_LEVEL" ] && COMMAND="$COMMAND --log-level \"$ICLOUD_LOG_LEVEL\""
[ "$ICLOUD_NO_PROGRESS_BAR" = "true" ] && COMMAND="$COMMAND --no-progress-bar"
[ "$ICLOUD_DELETE_AFTER_DOWNLOAD" = "true" ] && COMMAND="$COMMAND --delete-after-download"

echo "Esecuzione del comando: $COMMAND"
eval "$COMMAND"