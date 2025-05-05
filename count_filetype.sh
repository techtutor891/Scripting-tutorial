#!/bin/bash

# Check if directory is provided and valid
if [[ -z "$1" || ! -d "$1" ]]; then
        echo "Usage: $0 /path/to/directory"
        exit 1
fi

declare -A ext_counts  # Create an associative array
for file in "$1"/*; do
        if [[ -f "$file" ]]; then
                filename=$(basename -- "$file")
                extension="${filename##*.}"

                if [[ "$filename" == "$extension" ]]; then
                        extension="(no extension)"
                fi

                ((ext_counts["$extension"]++))
        fi
done

# Print results
for ext in "${!ext_counts[@]}"; do
    echo "$ext: ${ext_counts[$ext]}"
done
