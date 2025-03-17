#!/bin/sh

files_to_include="
chromaterm-generic.yml
chromaterm-juniper.yml
chromaterm-cisco.yml
chromaterm-unix.yml
"

if [ -e chromaterm.yml ]; then
  rm chromaterm.yml
fi
for file in ${files_to_include}; do
  cat "${file}" >>chromaterm.yml
done
