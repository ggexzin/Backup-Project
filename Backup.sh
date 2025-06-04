#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <container> <db>"
  exit 1
fi

# Credentials import from the .conf file
if [ ! -f "credentials.conf" ]; then
  echo "credentials.conf not found!"
  exit 1
fi
source credentials.conf

CONTAINER="$1"
DB="$2"
FOLDER="backup"
FILE="$FOLDER/backup.sql"

if [ ! -d "$FOLDER" ]; then
  echo "The folder '$FOLDER' does not exist. Creating..."
  mkdir "$FOLDER"
fi

echo "Starting the database backup..."
docker exec "$CONTAINER" sh -c "mysqldump -u$USER -p$PASS $DB" > "$FILE"

if [ $? -eq 0 ]; then
  echo "Backup successfully saved in '$FILE'."
else
  echo "Error while performing the backup."
fi
