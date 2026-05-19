#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} N" >&2
}

[ "$#" -ne 1 ] && { usage; exit 1; }

N=$1
nums=$(seq 2 "$N")

for k in $(seq 2 "$N"); do
    # Check if k is still in nums
    echo "$nums" | grep -q "^$k$" || continue
    
    # Filter out multiples of k (except k itself)
    nums=$(echo "$nums" | awk -v k="$k" '$1 == k || $1 % k != 0')
done

echo "$nums" | xargs
