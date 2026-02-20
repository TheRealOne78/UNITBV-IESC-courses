#!/usr/bin/env sh

usage() {
    echo "Usage: ${0}" >&2
    echo "Simple text-based browser using links and wget" >&2
}

# Check args
[ "$#" -ne 0 ] && { usage; exit 1; }

# Create a unique temporary history file
HISTORY_FILE=$(mktemp) || exit 1

while :; do
    echo
    printf "Enter a URL, \`b' for back, or \`q' to quit: "
    read input

    case "$input" in
        q)
            echo "Exiting browser ..."
            break
            ;;
        b)
            # Check if last page
            COUNT=$(wc -l < "$HISTORY_FILE")
            if [ "$COUNT" -lt 2 ]; then
                echo "No previous page"
                continue
            fi

            # Remove last URL
            head -n $(($COUNT - 1)) "$HISTORY_FILE" > "${HISTORY_FILE}.tmp"
            mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
             
            # Get the last URL
            url=$(tail -n 1 "$HISTORY_FILE")
            ;;
        *)
            url="$input"

            # Append URL to history
            echo "$url" >> "$HISTORY_FILE"

            # Keep only last 10 URLs
            tail -n 10 "$HISTORY_FILE" > "${HISTORY_FILE}.tmp"
            mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
            ;;
    esac

    # Fetch and display page
    if command -v links >/dev/null 2>&1; then
        links -dump "$url"
    else
        wget -q -O - "$url"
    fi
done
