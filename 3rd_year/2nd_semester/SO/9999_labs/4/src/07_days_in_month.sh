#!/usr/bin/env sh

usage() {
    echo "Usage: run the script and follow the prompts." >&2
}

printf "Enter month (1-12): "
read -r month

printf "Enter year: "
read -r year

# Validate month range
if [ "${month}" -lt 1 ] || [ "${month}" -gt 12 ]; then
    echo "Error: month must be between 1 and 12." >&2
    exit 1
fi

is_leap=0
if [ $((year % 4)) -eq 0 ]; then
    if [ $((year % 100)) -eq 0 ]; then
        [ $((year % 400)) -eq 0 ] && is_leap=1
    else
        is_leap=1
    fi
fi

case "${month}" in
    1|3|5|7|8|10|12)    days=31 ;;
    4|6|9|11)           days=30 ;;
    2) [ "${is_leap}" -eq 1 ] && days=29 || days=28 ;;
esac

echo "Month ${month}/${year} has ${days} days."

