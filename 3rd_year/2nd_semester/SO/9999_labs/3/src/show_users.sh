#!/usr/bin/env sh

usage() {
    echo "Usage: ${0}" >&2
    echo "Prints logged users and their logtime" >&2
}

# Check args
[ "$#" -ne 0 ] && { usage; exit 1; }

for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
    session=$(last -n 1 "$user" | head -n 1)
    # Extract duration (the last field in parentheses)
    duration=$(echo "$session" | awk '{print $NF}')
    printf "%-10s %s\n" "$user" "$duration"
done
