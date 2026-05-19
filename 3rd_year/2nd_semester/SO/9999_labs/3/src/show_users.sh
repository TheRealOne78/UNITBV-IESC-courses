#!/usr/bin/env sh

usage() {
    echo "Usage: ${0}" >&2
    echo "Prints logged users and their logtime" >&2
}

awk -F: '$7 ~ /(sh)$/ {print $1}' /etc/passwd | while read -r user; do
    session=$(last "$user" 2>/dev/null | grep -m 1 -E 'logged in|\([0-9:+]+\)')

    printf "%s\t\t %s\n" "$user" "$session"
done
