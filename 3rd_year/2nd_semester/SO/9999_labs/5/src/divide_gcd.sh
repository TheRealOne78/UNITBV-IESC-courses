#!/usr/bin/env sh

gcd() {
    a=$1; b=$2
    while [ "$b" -ne 0 ]; do
        t=$b
        b=$((a % b))
        a=$t
    done
    echo "$a"
}

divide_gcd() {
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
    
    g1=$(divide_gcd $left & wait $!)
    g2=$(divide_gcd $right & wait $!)
    
    gcd "$g1" "$g2"
}

divide_gcd "$@"
