#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change to directory
cd "$DIR"

# Check if /overleaf folder exists
if [ ! -d "$DIR/overleaf" ]; then
    echo "The /overleaf folder does not exist. Please run overleaf_export.sh first."
    exit 1
fi

# Remove html directory
if [ -d "$DIR/html" ]; then
    rm -r "$DIR/html"
fi

# Create html directory
mkdir "$DIR/html"

# Function to convert Markdown to HTML
convert_to_html() {
    local markdown_file="$1"
    local html_file="$2"
    pandoc "$markdown_file" -o "$html_file"
    if [ $? -eq 0 ]; then
        echo "Converted $markdown_file to $html_file"
    else
        echo "Conversion of $markdown_file failed."
    fi
}

# Export to HTML from the /overleaf folder
for file in $DIR/overleaf/*.md; do
    if [[ -f "$file" ]]; then
        filename_noext=$(basename "$file" .md)
        html_output="$DIR/html/$filename_noext.html"
        convert_to_html "$file" "$html_output"
    fi
done
