#!/bin/bash

# Find the folder dynamically
folder_name="my-scripts"
found_folder=$(find / -type d -name "$folder_name" -print -quit 2>/dev/null)

# Check if the folder exists
if [ -z "$found_folder" ]; then
    echo "Folder '$folder_name' not found."
    exit 1
fi

cd "$found_folder" || exit 1

# List all shell scripts with index
echo "Available Shell Scripts:"
scripts=( *.sh )
for index in "${!scripts[@]}"; do
    echo "$index - ${scripts[index]}"
done

# Ask user for script execution
read -p "Enter the index of the script you want to execute (or 'exit' to quit): " script_index

if [ "$script_index" != "exit" ]; then
    # Check if the entered index is valid
    if [ "$script_index" -ge 0 ] && [ "$script_index" -lt "${#scripts[@]}" ]; then
        # Execute the script
        selected_script="${scripts[script_index]}"
        chmod +x "$selected_script"
        ./"$selected_script"
    else
        echo "Invalid index!"
    fi
else
    echo "Exiting..."
fi
