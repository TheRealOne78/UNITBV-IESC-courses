#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} NUM1 NUM2" >&2
    echo "Prints the sum of NUM1 and NUM2." >&2
}

# Check args
[ "$#" -ne 2 ] && { usage; exit 1; }

echo $(( $1 + $2 ))
