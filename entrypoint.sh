#!/bin/bash

set -e

config="$1"
args="$2"
root_directory="$3"
recursive="$4"
overwrite_original="$5"
output_log="$6"

biber_command=(biber --tool --validate-datamodel --nolog)

if [ -n "$config" ]; then
    biber_command+=(--configfile $config)
fi

if [ -n "$args" ]; then
    biber_command+=($args)
fi

if [ -n "$root_directory" ]; then
    cd ${root_directory}
fi

if [ "$recursive" = "True" ]; then
    to_check_files=$(find . -name '*.bib')
else
    to_check_files=$(find . -maxdepth 1 -name '*.bib')
fi

for file in ${to_check_files}
do
    if [ "$overwrite_original" = "True" ]; then
        "${biber_command[@]}" --output-file "$file" "$file" >> "$output_log"
    else
        "${biber_command[@]}" "$file" >> "$output_log"
    fi
done
