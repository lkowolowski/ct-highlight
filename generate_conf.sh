#!/bin/sh

files_to_include=$(ls -1 *.yml | grep -v chromaterm.yml)

out_dir="${HOME}/.config/chromaterm"

# chromaterm-colors.yml is the foundation. All of the others use the definitions
# provided
#
# Build the all-in-wonder file. This may have odd behavior if patterns across
# different platform overlap

# Start with the base
cat chromaterm-colors.yml >"${out_dir}/chromaterm.yml"
echo "rules:" >>"${out_dir}/chromaterm.yml"

# Add in all the other files we want to include
for file in ${files_to_include}; do
	# Check if the file exists, and if so, append it to our config file
	if [ -e "${file}" ]; then
		cat "${file}" >>"${out_dir}/chromaterm.yml"
	fi
done

# Build platform specific files
#
# Build Generic and colors only
cat chromaterm-colors.yml >"${out_dir}/generic.yml"
echo "rules:" >>"${out_dir}/generic.yml"
cat chromaterm-generic.yml >>"${out_dir}/generic.yml"

# Generic, colors, and platform specific patterns
for platform in juniper cisco unix; do
	cat chromaterm-colors.yml >"${out_dir}/${platform}.yml"
	echo "rules:" >>"${out_dir}/${platform}.yml"
	cat chromaterm-generic.yml >>"${out_dir}/${platform}.yml"
	# Check if the file exists, and if so, append it to our config file
	if [ -e "chromaterm-${platform}.yml" ]; then
		cat "chromaterm-${platform}.yml" >>"${out_dir}/${platform}.yml"
	fi
done
