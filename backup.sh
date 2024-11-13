#!/bin/bash

# Define the source directory and the mounted destination directory
SOURCE_DIR="/root/.local/share/Terraria/Worlds"
BRIDGE_DIR="/terraria-server/worlds"
DEST_DIR="mind@machinemindcore.cloud:~/data/terraria-worlds/"  # This directory should be mounted to a local path on the host


# Get the current datetime in the format YYYYMMDD_HHMMSS
CURRENT_DATETIME=$(date +"%Y%m%d_%H%M%S")

# Define the name of the zip file
ZIP_FILENAME="worlds_backup_$CURRENT_DATETIME.zip"

# Create the zip archive
zip -r "$BRIDGE_DIR/$ZIP_FILENAME" "$SOURCE_DIR"
scp "$BRIDGE_DIR/$ZIP_FILENAME" "$DEST_DIR"

