#!/usr/bin/env sh

usage() {
    echo "Usage: ${0}" >&2
    echo "Computes page faults for FIFO, OPT, LRU, MRU." >&2
}

# Check args
[ "$#" -ne 0 ] && { usage; exit 1; }

seq_pages="1 2 0 2 7 5 2 4 3 2 5"
frames_n=3

contains() {
    for x in $1; do
        [ "$x" = "$2" ] && return 0
    done
    return 1
}

fifo_pf() {
    frames=""
    queue=""
    pf=0
    for p in $seq_pages; do
        if contains "$frames" "$p"; then
            continue
        fi
        pf=$((pf + 1))
        count=$(set -- $frames; echo $#)
        if [ "$count" -lt "$frames_n" ]; then
            frames="$frames $p"
            queue="$queue $p"
        else
            set -- $queue
            old="$1"
            shift
            queue="$* $p"
            new_frames=""
            for f in $frames; do
                if [ "$f" = "$old" ]; then
                    new_frames="$new_frames $p"
                else
                    new_frames="$new_frames $f"
                fi
            done
            frames="$new_frames"
        fi
    done
    echo "$pf"
}

opt_pf() {
    set -- $seq_pages
    total=$#
    i=1
    frames=""
    pf=0
    for p in $seq_pages; do
        if contains "$frames" "$p"; then
            i=$((i + 1))
            continue
        fi
        pf=$((pf + 1))
        count=$(set -- $frames; echo $#)
        if [ "$count" -lt "$frames_n" ]; then
            frames="$frames $p"
        else
            victim=""
            victim_pos=-1
            for f in $frames; do
                pos=999999
                j=1
                for q in $seq_pages; do
                    if [ "$j" -gt "$i" ] && [ "$q" = "$f" ]; then
                        pos=$j
                        break
                    fi
                    j=$((j + 1))
                done
                if [ "$pos" -gt "$victim_pos" ]; then
                    victim_pos=$pos
                    victim="$f"
                fi
            done
            new_frames=""
            for f in $frames; do
                if [ "$f" = "$victim" ]; then
                    new_frames="$new_frames $p"
                else
                    new_frames="$new_frames $f"
                fi
            done
            frames="$new_frames"
        fi
        i=$((i + 1))
    done
    echo "$pf"
}

last_used_pos() {
    target="$1"
    up_to="$2"
    j=1
    last=0
    for q in $seq_pages; do
        [ "$j" -gt "$up_to" ] && break
        [ "$q" = "$target" ] && last=$j
        j=$((j + 1))
    done
    echo "$last"
}

lru_pf() {
    frames=""
    pf=0
    i=1
    for p in $seq_pages; do
        if contains "$frames" "$p"; then
            i=$((i + 1))
            continue
        fi
        pf=$((pf + 1))
        count=$(set -- $frames; echo $#)
        if [ "$count" -lt "$frames_n" ]; then
            frames="$frames $p"
        else
            victim=""
            min_pos=999999
            for f in $frames; do
                pos=$(last_used_pos "$f" "$((i - 1))")
                if [ "$pos" -lt "$min_pos" ]; then
                    min_pos=$pos
                    victim="$f"
                fi
            done
            new_frames=""
            for f in $frames; do
                if [ "$f" = "$victim" ]; then
                    new_frames="$new_frames $p"
                else
                    new_frames="$new_frames $f"
                fi
            done
            frames="$new_frames"
        fi
        i=$((i + 1))
    done
    echo "$pf"
}

mru_pf() {
    frames=""
    pf=0
    i=1
    for p in $seq_pages; do
        if contains "$frames" "$p"; then
            i=$((i + 1))
            continue
        fi
        pf=$((pf + 1))
        count=$(set -- $frames; echo $#)
        if [ "$count" -lt "$frames_n" ]; then
            frames="$frames $p"
        else
            victim=""
            max_pos=-1
            for f in $frames; do
                pos=$(last_used_pos "$f" "$((i - 1))")
                if [ "$pos" -gt "$max_pos" ]; then
                    max_pos=$pos
                    victim="$f"
                fi
            done
            new_frames=""
            for f in $frames; do
                if [ "$f" = "$victim" ]; then
                    new_frames="$new_frames $p"
                else
                    new_frames="$new_frames $f"
                fi
            done
            frames="$new_frames"
        fi
        i=$((i + 1))
    done
    echo "$pf"
}

echo "FIFO: $(fifo_pf)"
echo "OPT:  $(opt_pf)"
echo "LRU:  $(lru_pf)"
echo "MRU:  $(mru_pf)"
