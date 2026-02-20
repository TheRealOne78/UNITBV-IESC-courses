#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} NUM1" >&2
    echo "Prints the first NUM1 numbers of the Fibonacci series." >&2
}

# Check args
[ "$#" -ne 1 ] && { usage; exit 1; }

a=0
b=1
i=0

while [ "$i" -lt "$1" ]; do
    tmp=$b
    b=$(( a + b ))
    a=$tmp
    i=$(( i + 1 ))
done

echo "$a"
