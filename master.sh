#!/bin/bash

# Function to perform calculations
calculate() {
  read -p "Enter expression (e.g., 2 + 2): " expression
  result=$(bc <<< "$expression")
  echo "Result: $result"
}

# Function to inspect files
inspect_file() {
  read -p "Enter the path to the file you want to inspect: " file
  if [ -f "$file" ]; then
    echo "Options:"
    echo "1. Count characters"
    echo "2. Count words"
    echo "3. Count lines"
    echo "4. Count sentences"
    read -p "Enter your choice: " choice

    case $choice in
      1) char_count=$(awk '{print length}' "$file" | paste -sd+ - | bc)
         echo "Character count: $char_count";;
      2) word_count=$(awk '{print NF}' "$file" | paste -sd+ - | bc)
         echo "Word count: $word_count";;
      3) line_count=$(wc -l < "$file")
         echo "Line count: $line_count";;
      4) sentence_count=$(grep -oE '\. |! |\? ' "$file" | wc -l)
         echo "Sentence count: $sentence_count";;
      *) echo "Invalid choice";;
    esac
  else
    echo "File not found."
  fi
}

# Function to encrypt files
encrypt_file() {
  read -p "Enter the path to the file you want to encrypt: " file
  read -s -p "Enter a password for encryption: " password
  echo
  openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" -k "$password"
  echo "File encrypted as $file.enc"
}

# Function to decrypt files
decrypt_file() {
  read -p "Enter the path to the encrypted file: " file
  read -s -p "Enter the decryption password: " password
  echo
  openssl enc -d -aes-256-cbc -in "$file" -out "${file%.enc}" -k "$password"
  echo "File decrypted as ${file%.enc}"
}

# Function for file format conversion (e.g., txt to pdf)
convert_file_format() {
  read -p "Enter the path to the source file (Markdown): " source_file
  read -p "Enter the path for the converted file (PDF): " converted_file

  # Check if pandoc is installed
  if ! command -v pandoc &>/dev/null; then
    echo "Error: pandoc is not installed. Please install pandoc and try again."
    return
  fi

  # Perform the conversion
  pandoc "$source_file" -o "$converted_file"

  echo "File converted."
}

# Function for date and time calculations
date_time_calculations() {
  read -p "Enter a date (YYYY-MM-DD): " input_date
  read -p "Enter the number of days to add: " days_to_add

  # Calculate the future date by adding days
  calculated_date=$(date -d "$input_date + $days_to_add days" "+%Y-%m-%d")

  echo "Calculated date: $calculated_date"
}

# Function to retrieve system information
system_information() {
  echo "System Information:"
  uname -a  # Display system kernel version
  df -h     # Display disk space usage
}

# Function for password management (To be implemented)
password_management() {
  # Add password management functionality here
  echo "Password management feature not implemented."
}

# Function for file and directory management (To be implemented)
file_directory_management() {
  # Add file and directory management functionality here
  echo "File and directory management feature not implemented."
}

# Function for file or directory removal
remove_file_directory() {
  read -p "Enter the path to the file or directory you want to remove: " target
  if [ -e "$target" ]; then
    read -p "Are you sure you want to remove $target? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
      rm -r "$target"
      echo "File/Directory removed: $target"
    else
      echo "Removal cancelled."
    fi
  else
    echo "File/Directory not found: $target"
  fi
}

# Function for file compression (ZIP format)
compress_file() {
  read -p "Enter the path to the file you want to compress: " source_file
  read -p "Enter the path for the compressed file (ZIP format): " compressed_file

  if [ -e "$source_file" ]; then
    # Use the 'zip' command to create a ZIP archive of the source file
    zip "$compressed_file" "$source_file"
    echo "File compressed as $compressed_file"
  else
    echo "Source file not found: $source_file"
  fi
}

# Function for file decompression (ZIP format)
decompress_file() {
  read -p "Enter the path to the compressed file (ZIP format): " compressed_file
  read -p "Enter the path for the decompressed file or directory: " decompressed_file

  if [ -e "$compressed_file" ]; then
    # Use the 'unzip' command to decompress the ZIP archive
    unzip -o "$compressed_file" -d "$decompressed_file"
    echo "File decompressed as $decompressed_file"
  else
    echo "Compressed file not found: $compressed_file"
  fi
}

# Function for file search and replace
search_replace() {
  read -p "Enter the path to the file you want to perform search and replace on: " file
  read -p "Enter the text to search for: " search_text
  read -p "Enter the text to replace with: " replace_text

  if [ -f "$file" ]; then
    # Use 'sed' to search and replace text in the file
    sed -i "s/$search_text/$replace_text/g" "$file"
    echo "Search and replace complete."
  else
    echo "File not found: $file"
  fi
}

# Main menu
while true; do
  echo "Task Menu:"
  echo "1. Calculate"
  echo "2. Inspect files"
  echo "3. Encrypt files"
  echo "4. Decrypt files"
  echo "5. Convert File Format"
  echo "6. Date and Time Calculations"
  echo "7. System Information"
  echo "8. Password Management"
  echo "9. File and Directory Management"
  echo "10. Remove File/Directory"
  echo "11. Compress File (ZIP)"
  echo "12. Decompress File (ZIP)"
  echo "13. Search and Replace"
  echo "14. Exit"
  read -p "Enter your choice: " task

  case $task in
    1) calculate;;
    2) inspect_file;;
    3) encrypt_file;;
    4) decrypt_file;;
    5) convert_file_format;;
    6) date_time_calculations;;
    7) system_information;;
    8) password_management;;
    9) file_directory_management;;
    10) remove_file_directory;;
    11) compress_file;;
    12) decompress_file;;
    13) search_replace;;
    14) echo "Goodbye!"; exit 0;;
    *) echo "Invalid choice";;
  esac
done
