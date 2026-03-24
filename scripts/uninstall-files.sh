#!/usr/bin/env bash
# Remove previously installed FILES from DEST
set -euo pipefail
files=$1 dest=$2
for f in $files; do
    base=$(basename "$f")
    target="$dest/${base#chromaterm-}"
    if [ -f "$target" ]; then
        echo "Removing $target"
        rm -f "$target"
    else
        echo "Skipping $target (not found)"
    fi
done
