#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} STRING1 STRING2" >&2
    echo "Checks whether STRING1 and STRING2 are equal." >&2
}

[ "$#" -ne 2 ] && { usage; exit 1; }

if [ "${1}" = "${2}" ]; then
    echo "Strings are equal: '${1}'"
else
    echo "Strings are NOT equal: '${1}' != '${2}'"
fi
