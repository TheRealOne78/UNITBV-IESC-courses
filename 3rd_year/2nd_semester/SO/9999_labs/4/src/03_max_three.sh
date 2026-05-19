#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} NUM1 NUM2 NUM3" >&2
    echo "Prints the maximum of the three given numbers." >&2
}

[ "$#" -ne 3 ] && { usage; exit 1; }

max="${1}"
[ "${2}" -gt "${max}" ] && max="${2}"
[ "${3}" -gt "${max}" ] && max="${3}"

echo "Numbers: ${1}, ${2}, ${3}"
echo "Maximum: ${max}"
