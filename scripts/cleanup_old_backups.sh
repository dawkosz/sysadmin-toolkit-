#!/bin/bash

# === CONFIG ===
BACKUP_DIR="/opt"
DAYS=7
PATTERN="*.tar.gz"
LOG_FILE="/var/log/backup-cleanup.log"

# === START ===
echo "[`date`] Backup cleanup started" >> $LOG_FILE

find "$BACKUP_DIR" -type f -name "$PATTERN" -mtime +$DAYS -print -delete >> $LOG_FILE 2>&1

echo "[`date`] Cleanup finished" >> $LOG_FILE
echo "" >> $LOG_FILE
