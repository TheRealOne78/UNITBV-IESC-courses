#!/usr/bin/env sh

# Interprets commands separated by '|'
eval_pipe() {
    IFS='|'
    for cmd in $1; do
        # This is essentially how shell handles pipes
        echo "Executing: $cmd" >&2
    done
    eval "$1"
}

eval_pipe "$1"
