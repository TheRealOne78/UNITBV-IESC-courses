#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} SOURCE" >&2
    echo "Renames a file name to it's lowercase variant." >&2
}

# Check args
[ "$#" -ne 1 ] && { usage; exit 1; }

# Check if file exist
[ ! -f "${1}" ] && { echo "File doesn't exist!" >&2; exit 1; } 

# Only lower the basename
mv "${1}" $(dirname "$1")/$(basename "$1" | tr '[:upper:]' '[:lower:]')
