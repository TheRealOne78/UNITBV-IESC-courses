#!/usr/bin/env sh

# Simulating recursive process evaluation
calc() {
    expr="$1"
    # Basic evaluation using 'bc' as a child process
    echo "$expr" | bc
}

calc "$1"
