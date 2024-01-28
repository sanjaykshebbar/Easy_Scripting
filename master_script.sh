#!/bin/bash

# Define the folder path
folder_path="$HOME/Desktop/my-scripts"

# Check if the folder exists
if [ -d "$folder_path" ]; then
    cd "$folder_path" || exit 1

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
else
    echo "Folder not found!"
fi
