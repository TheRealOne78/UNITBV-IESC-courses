#!/usr/bin/env sh

# Sums two vectors from files, one process per element
vector_sum() {
    f1=$1
    f2=$2
    
    count=$(wc -w < "$f1")
    for i in $(seq 1 "$count"); do
        (
            v1=$(cut -d' ' -f"$i" "$f1")
            v2=$(cut -d' ' -f"$i" "$f2")
            echo $((v1 + v2))
        ) &
    done
    wait
}

# Example usage with temp files if called directly
[ "$#" -eq 2 ] && vector_sum "$1" "$2"
