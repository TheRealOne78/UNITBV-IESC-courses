#!/usr/bin/env sh

usage() {
    echo "Usage: $0" >&2
    echo "Compute the total memory percentage used by ssh processes."
}

ssh_mem_values=$(top -bn1 | awk '
    NR == 7 {
        for (i = 1; i <= NF; i++)
            if ($i == "%MEM") { col = i }
    }
    NR > 7 && col && $NF ~ /^ssh/ { print $col }
')
 
total_mem="0"
for mem in ${ssh_mem_values}; do
    total_mem=$(echo "${total_mem} + ${mem}" | bc)
done
 
printf "Used memory: %.2f\n" "${total_mem}"
