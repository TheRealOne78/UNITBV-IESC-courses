#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} NUM1" >&2
    echo "Prints numbers from NUM1 to 0, in descending order." >&2
    echo "The number must be positive." >&2
}

# Check args
[ "$#" -ne 1 ] && { usage; exit 1; }

num=$1;
while [ "$num" -ge 0 ]; do
    echo $num
    num=$(( "$num" - 1 ))
done
