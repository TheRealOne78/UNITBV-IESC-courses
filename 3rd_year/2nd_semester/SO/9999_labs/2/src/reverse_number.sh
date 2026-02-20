#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} NUM1" >&2
    echo "Prints numbers in reverse order." >&2
}

# Check args
[ "$#" -ne 1 ] && { usage; exit 1; }

n=$1
rev=0

while [ "$n" -gt 0 ]; do
    rev=$(( rev * 10 + n % 10 ))
    n=$(( n / 10 ))
done

echo "$rev"
