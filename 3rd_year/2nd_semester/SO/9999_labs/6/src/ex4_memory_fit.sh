#!/usr/bin/env sh

usage() {
    echo "Usage: ${0}" >&2
    echo "Computes RFF and Best-Fit allocations." >&2
}

# Check args
[ "$#" -ne 0 ] && { usage; exit 1; }

alloc_rotating_first_fit() {
    free_list="6 12 10 22 19 7"
    reqs="10 14 12 8 6"
    start_idx=1
    out=""
    steps_total=0

    for r in $reqs; do
        set -- $free_list
        n=$#
        i=1
        pos=$start_idx
        found=0
        steps=0
        while [ "$i" -le "$n" ]; do
            steps=$((steps + 1))
            eval "b=\${$pos}"
            if [ "$b" -ge "$r" ]; then
                found=1
                break
            fi
            pos=$((pos + 1))
            [ "$pos" -gt "$n" ] && pos=1
            i=$((i + 1))
        done
        steps_total=$((steps_total + steps))

        if [ "$found" -eq 1 ]; then
            rem=$((b - r))
            out="$out$r->$b "
            new=""
            k=1
            for x in $free_list; do
                if [ "$k" -eq "$pos" ]; then
                    if [ "$rem" -gt 0 ]; then
                        new="$new $rem"
                    fi
                else
                    new="$new $x"
                fi
                k=$((k + 1))
            done
            free_list="$new"
            set -- $free_list
            n2=$#
            if [ "$n2" -eq 0 ]; then
                start_idx=1
            else
                if [ "$rem" -gt 0 ]; then
                    start_idx=$pos
                else
                    start_idx=$pos
                    if [ "$start_idx" -gt "$n2" ]; then
                        start_idx=1
                    fi
                fi
            fi
        fi
    done

    echo "RFF alloc: $out"
    echo "RFF free :$free_list"
    echo "RFF steps:$steps_total"
}

alloc_best_fit() {
    free_list="6 12 10 22 19 7"
    reqs="10 14 12 8 6"
    out=""
    steps_total=0

    for r in $reqs; do
        best=0
        best_pos=0
        pos=1
        for b in $free_list; do
            steps_total=$((steps_total + 1))
            if [ "$b" -ge "$r" ]; then
                if [ "$best_pos" -eq 0 ] || [ "$b" -lt "$best" ]; then
                    best=$b
                    best_pos=$pos
                fi
            fi
            pos=$((pos + 1))
        done

        if [ "$best_pos" -ne 0 ]; then
            rem=$((best - r))
            out="$out$r->$best "
            new=""
            pos=1
            for b in $free_list; do
                if [ "$pos" -eq "$best_pos" ]; then
                    [ "$rem" -gt 0 ] && new="$new $rem"
                else
                    new="$new $b"
                fi
                pos=$((pos + 1))
            done
            free_list="$new"
        fi
    done

    echo "BF alloc:  $out"
    echo "BF free :$free_list"
    echo "BF steps:$steps_total"
}

alloc_rotating_first_fit
alloc_best_fit
