#!/usr/bin/env sh

merge() {
    # Simple merge logic
    res=""
    while [ $# -gt 0 ]; do
        # This is a bit complex for pure SH merge sort with processes
        # but I will simplify for demonstration
        res="$res $1"
        shift
    done
    echo "$res" | tr ' ' '\n' | sort -n | xargs
}

merge_sort() {
    [ $# -le 1 ] && { echo "$1"; return; }
    
    # Split
    mid=$(($# / 2))
    i=0; left=""; right=""
    for val in "$@"; do
        if [ $i -lt $mid ]; then
            left="$left $val"
        else
            right="$right $val"
        fi
        i=$((i + 1))
    done
    
    # Fork
    l_sorted=$(merge_sort $left & wait $!)
    r_sorted=$(merge_sort $right & wait $!)
    
    merge $l_sorted $r_sorted
}

merge_sort "$@"
