#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} ARG1 ..." >&2
    echo "Checks if the provided arguments contain a \`*' character." >&2
}

# Check args
[ "$#" -eq 0 ] && { usage; exit 1; }

for s in "$@"; do
    case $s in
        *"*"*) echo "Found \`*' character." && exit 0;;
    esac
done

echo "No \`*' character found."
