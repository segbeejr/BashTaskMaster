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

# Function for file and directory management (To be implemented)
file_directory_management() {
  while true; do
    clear
    echo "File and Directory Management Menu:"
    echo "1. Create a new file"
    echo "2. Create a new directory"
    echo "3. Rename a file or directory"
    echo "4. Move a file or directory"
    echo "5. Delete a file or directory"
    echo "6. List files and directories"
    echo "7. Return to main menu"
    read -p "Enter your choice: " choice

    case $choice in
      1)
        read -p "Enter the name of the new file: " file_name
        touch "$file_name"
        echo "File '$file_name' created."
        read -p "Press Enter to continue..."
        ;;
      2)
        read -p "Enter the name of the new directory: " dir_name
        mkdir "$dir_name"
        echo "Directory '$dir_name' created."
        read -p "Press Enter to continue..."
        ;;
      3)
        read -p "Enter the current name of the file or directory: " current_name
        read -p "Enter the new name: " new_name
        mv "$current_name" "$new_name"
        echo "Renamed '$current_name' to '$new_name'."
        read -p "Press Enter to continue..."
        ;;
      4)
        read -p "Enter the name of the file or directory to move: " source_name
        read -p "Enter the destination directory: " destination_dir
        mv "$source_name" "$destination_dir"
        echo "Moved '$source_name' to '$destination_dir'."
        read -p "Press Enter to continue..."
        ;;
      5)
        read -p "Enter the name of the file or directory to delete: " delete_name
        rm -r "$delete_name"
        echo "Deleted '$delete_name'."
        read -p "Press Enter to continue..."
        ;;
      6)
        clear
        echo "List of files and directories in the current directory:"
        ls
        read -p "Press Enter to continue..."
        ;;
      7)
        break
        ;;
      *)
        echo "Invalid choice"
        read -p "Press Enter to continue..."
        ;;
    esac
  done
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

# Main menu
while true; do
  echo "Task Menu:"
  echo "1. Calculate"
  echo "2. Inspect files"
  echo "3. Encrypt files"
  echo "4. Decrypt files"
  echo "5. File and Directory Management"
  echo "6. Remove File/Directory"
  echo "7. Exit"
  read -p "Enter your choice: " task

  case $task in
    1) calculate;;
    2) inspect_file;;
    3) encrypt_file;;
    4) decrypt_file;;
    5) file_directory_management;;
    6) remove_file_directory;;
    7) echo "Goodbye!"; exit 0;;
    *) echo "Invalid choice";;
  esac
done
