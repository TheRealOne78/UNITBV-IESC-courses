#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} PARAM1 PARAM2 [...]" >&2
    echo "Requires at least two parameters." >&2
}

[ "$#" -lt 2 ] && { usage; exit 1; }

echo "Received ${#} parameters:"
for param; do
    echo "  - ${param}"
done
