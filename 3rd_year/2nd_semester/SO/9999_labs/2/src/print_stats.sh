#!/usr/bin/env sh

usage() {
    echo "Usage: ${0}" >&2
    echo "Prints current datetime, user and current directory" >&2
}

# Check args
[ "$#" -ne 0 ] && { usage; exit 1; }

echo "Current datetime: $(date)"
echo "Logged user name: $(whoami)"
echo "Current working directory $(pwd)"
