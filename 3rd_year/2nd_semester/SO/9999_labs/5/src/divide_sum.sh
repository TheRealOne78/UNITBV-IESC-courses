#!/usr/bin/env sh

divide_sum() {
    [ $# -eq 0 ] && { echo 0; return; }
    [ $# -eq 1 ] && { echo "$1"; return; }
    
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
    
    s1=$(divide_sum $left & wait $!)
    s2=$(divide_sum $right & wait $!)
    
    echo $((s1 + s2))
}

divide_sum "$@"
