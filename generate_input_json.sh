#!/bin/bash

# Define paths
circom_file_path="./circuit.circom"
output_file_path="./input.json"

# Check if the circom file exists
if [ ! -f "$circom_file_path" ]; then
    echo -e "\033[91mThe file $circom_file_path does not exist.\033[0m"
    exit 1
fi

# Function to extract inputs and prepare JSON content
prepare_json_content() {
    local circom_file=$1
    local json_content="{"
    local first_entry=true
    
    while IFS= read -r line; do
        if [[ $line =~ signal\ input\ ([a-zA-Z0-9_]+)(\[([0-9]+)\])?\; ]]; then
            local input_name="${BASH_REMATCH[1]}"
            local array_size="${BASH_REMATCH[3]}"
            
            if [ "$first_entry" = true ]; then
                json_content+="\n"
                first_entry=false
            else
                json_content+=",\n"
            fi
            
            if [ -n "$array_size" ]; then
                # Handle array inputs
                json_content+="\t\"$input_name\": [$(printf '0,'%.0s $(seq 1 $((array_size-1))))0]"
            else
                # Handle single inputs
                json_content+="\t\"$input_name\": 0"
            fi
        fi
    done < "$circom_file"
    
    json_content+="\n}"
    
    echo -e "$json_content"
}

# Check if the output file already exists
if [ -f "$output_file_path" ]; then
    echo -n "input.json already exists. Do you want to override it? (y/n): "
    read -r choice
    case "$choice" in
        y|Y )
            ;;
        n|N )
            echo "Exiting without changes."
            exit 0
            ;;
        * )
            echo "Invalid option. Exiting."
            exit 1
            ;;
    esac
fi

# Prepare JSON content
json_content=$(prepare_json_content "$circom_file_path")

# Write to the output file
echo -e "$json_content" > "$output_file_path"
echo "$output_file_path has been updated."
