#!/bin/bash
# This script requires supernote-tool from https://github.com/jya-dev/supernote-tool

# WARNING: paths must be absolute if using cron!

# Set the name for the folder where converted files will be stored
convertedFolderName="Supernote_converted"

# Set the absolute path to the directory containing the Supernote files
superNotePath="/mnt/g/Il mio Drive/Supernote/Note/"

# Set the path to the supernote-tool executable
superNoteToolPath="supernote-tool"

# Set the new extension for the converted files
superNoteNewExt="pdf"

# Command to mount Google Drive folder in wsl
mountGdriveCommand="sudo mount -t drvfs G: /mnt/g"

# If the Supernote path is not accessible, run command to mount Google Drive to wsl
if [[ ! -d "$superNotePath" ]]; then
    echo "The directory ${superNotePath} is not accessible. Mounting Google Drive..."
    eval "$mountGdriveCommand"
fi

# Find all .note files in the Supernote directory and its subdirectories
# The '-print0' option ensures that filenames containing spaces or special characters are handled correctly
find "${superNotePath}" -name "*.note" -print0 | while read -d $'\0' noteFile
do
    # Generate the filename for the converted file by replacing 'Supernote' with $convertedFolderName
    convertedFile="${noteFile/Supernote/$convertedFolderName}"

    # Change the file extension to the specified new extension
    convertedFile="${convertedFile%.*}.${superNoteNewExt}"

    # Check if the converted file doesn't exist or if the note file is newer than (-nt) the converted file
    if [[ ! -f $convertedFile ]] || [[ $noteFile -nt $convertedFile ]]
    then
        # Create the directory structure for the converted file if it doesn't exist
        newDir="$(dirname "${convertedFile}")"
        mkdir -p "${newDir}"

        # Output a message indicating the file being converted
        echo "Converting ${noteFile/$superNotePath/}"

        # Use supernote-tool to convert the .note file to the specified format
        eval "$superNoteToolPath convert -t pdf -a \"$noteFile\" \"$convertedFile\""
    fi
done

# Output final message
echo "All notes are up do date!"
