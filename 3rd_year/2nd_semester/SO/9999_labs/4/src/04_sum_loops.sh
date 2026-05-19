#!/usr/bin/env sh

usage() {
    echo "Usage: ${0} N" >&2
    echo "Computes the sum of numbers from 1 to N using while and for loops." >&2
}

[ "$#" -ne 1 ] && { usage; exit 1; }

n="${1}"

sum_while=0
i=1
while [ "${i}" -le "${n}" ]; do
    sum_while=$((sum_while + i))
    i=$((i + 1))
done
echo "Sum 1..${n} (while): ${sum_while}"

sum_for=0
for i in $(seq 1 "$n"); do
    sum_for=$((sum_for + i))
done
echo "Sum 1..${n} (for):   ${sum_for}"
