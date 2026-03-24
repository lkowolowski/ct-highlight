#!/usr/bin/env bash
# Install FILES into DEST, stripping the chromaterm- prefix
set -euo pipefail
files=$1 dest=$2
for f in $files; do
    base=$(basename "$f")
    newname=${base#chromaterm-}
    echo "Installing $f as $newname"
    install -m 644 "$f" "$dest/$newname"
done
