#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} COMMAND [ARG ...]" >&2
    echo "Checks whether COMMAND contains the '*' character." >&2
}

[ "$#" -lt 1 ] && { usage; exit 1; }

command -v "${1}" >/dev/null 2>&1 || {
    echo "Error: command '${1}' not found." >&2
    exit 1
}

cmd="${*}"

case "${cmd}" in
    *\**)
        echo "The command contains '*': ${cmd}"
        ;;
    *)
        echo "The command does NOT contain '*': ${cmd}"
        ;;
esac
