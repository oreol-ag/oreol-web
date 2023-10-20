#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change to directory
cd "$DIR"

# Remove rtf directory
if [ -d "$DIR/rtf" ]; then
    rm -r "$DIR/rtf"
fi

# Create rtf directory
mkdir "$DIR/rtf"

# Function to convert Markdown to RTF
convert_to_rtf() {
    local markdown_file="$1"
    local rtf_file="$2"
    pandoc -s "$markdown_file" -o "$rtf_file"
    if [ $? -eq 0 ]; then
        echo "Converted $markdown_file to $rtf_file"
    else
        echo "Conversion of $markdown_file failed."
    fi
}

# Export to RTF
for file in *.md; do
    if [[ -f "$file" ]]; then
        filename_noext="${file%.md}"
        rtf_output="$DIR/rtf/$filename_noext.rtf"
        convert_to_rtf "$file" "$rtf_output"
    fi
done