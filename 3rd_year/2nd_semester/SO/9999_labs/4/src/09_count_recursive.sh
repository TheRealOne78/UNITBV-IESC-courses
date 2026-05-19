#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} DIR" >&2
    echo "Recursively counts files and subdirectories inside DIR." >&2
}

[ "$#" -ne 1 ] && { usage; exit 1; }
[ ! -d "${1}" ] && { echo "Error: '${1}' is not a directory." >&2; exit 1; }

dir="${1}"

file_count=$(find "${dir}" -type f | wc -l)
dir_count=$(find "${dir}" -mindepth 1 -type d | wc -l)

echo "Directory: ${dir}"
echo "> Files:          ${file_count}"
echo "> Subdirectories: ${dir_count}"
