#!/bin/bash

# Set the paths to the source and destination folders
source_folder="/run/media/daniel/EOS_DIGITAL/DCIM/100CANON"
selects_folder="/run/media/daniel/EOS_DIGITAL/Selects"
raws_folder="/run/media/daniel/Photostore/Masters/Import/"

# Check if the RAWs folder exists, create it if not
if [ ! -d "$raws_folder" ]; then
    mkdir -p "$raws_folder"
fi

# Loop through .cr3 files in the source folder
for cr3_file in "$source_folder"/*.CR3; do
    if [ -e "$cr3_file" ]; then
        # Extract the filename without extension
        filename=$(basename "$cr3_file" .CR3)

        # Check if a corresponding .jpg file exists in the Selects folder
        if [ -e "$selects_folder/$filename.JPG" ]; then
            # Copy the .cr3 file to the RAWs folder
            cp "$cr3_file" "$raws_folder"
            echo "Copied: $filename.CR3"
        fi
    fi
done

echo "Script completed."
