#!/usr/bin/env bash
# Remove DEST if it exists and is empty
set -euo pipefail
dest=$1
if [ -d "$dest" ] && [ -z "$(ls -A "$dest")" ]; then
    echo "Removing empty directory $dest"
    rmdir "$dest"
else
    echo "$dest not empty or does not exist, skipping"
fi
