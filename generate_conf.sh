#!/bin/sh

files_to_include="
chromaterm-generic.yml
chromaterm-unix.yml
chromaterm-juniper.yml
"

# Start with the base
cat chromaterm-colors.yml >chromaterm.yml
echo "rules:" >>chromaterm.yml

# Add in all the other files we want to include
for file in ${files_to_include}; do
  # Check if the file exists, and if so, append it to our config file
  if [ -e "${file}" ]; then
    cat "${file}" >>chromaterm.yml
  fi
done
