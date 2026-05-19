#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} DIR1 [DIR2 ...]" >&2
    echo "Computes the total size of files in the given directories." >&2
}

[ "$#" -lt 1 ] && { usage; exit 1; }

total=0

for dir; do
    if [ ! -d "${dir}" ]; then
        echo "Warning: '${dir}' is not a directory, skipping." >&2
        continue
    fi

    for entry in $(ls -l "${dir}" | awk 'NR>1 && /^-/ {print $5}'); do
        total=$((total + entry))
    done
done

echo "Total file size: ${total} bytes"
