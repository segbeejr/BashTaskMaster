#!/bin/bash

echo "What would you like to do? "
echo
echo -e "1. Perform calculations\n2. Read a file\n3. Delete a file\n4. Rename a file\n5. Search through a file for specific words\n6. Display the last column in a file using awk\n7. Display which grade can read the contents in a given file\n8. Copy file to a remote server\n9. Generate random number every 3 seconds\n10. Display any given column in a file\n11. Check the length of a file\n12. Create a nested directory\n13.Print a million numbers but it should display page by page\n14. Print lines with specified words in a file\n15. See processes\n16. Strip off a file extension\n17. Delete a directory\n18. Create the three basic files in a directory\n19. Show ssh key\n20. Customize with cpufetch\n21. customize with neofetch\n22. Exit program"

read -p "Select a task to execute: " select

function addition() {
    result=$(( $1 + $2 ))
    echo "The result is: $result"
}

function substraction() {
    result=$(( $1 - $2 ))
    echo "The result is: $result"
}

function division() {
    result=$(( $1 / $2 ))
    echo "The result is: $result"
}

function multiply() {
    result=$(( $1 * $2 ))
    echo "The result is: $result"
}

function basic_calculation() {
    echo -e "1. Addition\n2. Subtraction\n3. Division\n4. Multiplication"
    read -p "Which calculation would you like to perform? " choice

    read -p "Enter the first number: " num1
    read -p "Now the second: " num2

    if [ "$choice" == 1 ]
    then
        addition $num1 $num2
    elif [ "$choice" == 2 ]
    then
        substraction $num1 $num2
    elif [ "$choice" == 3 ]
    then
        division $num1 $num2
    elif [ "$choice" == 4 ]
    then
        multiply $num1 $num2
    else
        echo "Invalid option"
    fi
}

function read_file() {
    read -p "file name: " file
    if [ -f "$file" ]
    then   
        awk '{print $0}' "$file"
    else
        echo "Cannot read a file that doesn't exist. $file does not exist"
    fi
}

function delete_file() {
    read -p "Name of the file: " file
    if [ -f "$file" ]
    then
        rm "$file"
    else
        echo "Can't delete a file that doesn't exist. $file does not exist"
    fi
}

function rename_file() {
    read -p "The current name of the file: " current_name
    read -p "The name you want it to be changed to: " new_name
    if [ -f "$current_name" ]
    then
        mv "$current_name" "$new_name"
    else
        echo "Can't rename a file that doesn't exist. $current_name does not exist"
    fi
}

function search_file() {
    read -p "File name: " file_name
    read -p "Word you want to search for: " word
    if [ -f "$file_name" ]
    then    
        grep -n -w -i -v "$word" "$file_name"
    else
        echo "Can't search through a file that doesn't exist. $file_name does not exist"
    fi
}

function display_last_column() {
    read -p "Name of file: " file_name
    if [ -f "$file_name" ]
    then 
        awk '{print NF}' "$file_name"; awk '{print "This line has",NF,"columns. The last one contains",$NF}' "$file_name"
    else
        echo "can't display column of a file that doesn't exist. $file_name does not exist"
    fi
}

function grade_reader() {
    read -p "File name: " file_to_read
    if [ -f "$file_to_read" ]
    then
        cat "$file_to_read"
        words=$(wc -w "$file_to_read" | cut -d ' ' -f 1)
        char=$(cat "$file_to_read" | tr -d '[:punct:] [:space:]' | wc -m)
        sentences=$(cat "$file_to_read" | grep -oE '[.!?]' | grep -c .)

        L=$(echo "$char / $words * 100" | bc -l)
        S=$(echo "100 * $sentences / $words" | bc -l)
        CLI=$(bc <<< "0.0588 * $L - 0.296 * $S - 15.8")
        roundup_CLI=$(printf "%.0f" "$CLI")

        if [ "$roundup_CLI" -ge 16 ]
        then    
            echo "Grade 16+"
        elif [ "$roundup_CLI" -lt 1 ]
        then
            echo "Before grade 1"
        else
            echo "Grade $roundup_CLI"
        fi
    else
        echo "$file_to_read does not exist"
    fi
}

function remote_server() {
    read -p "File: " file_name
    read -p "Server: " remote_server
    if [ -f "$file_name" ]
    then
        if [ -n "$file_name" ]
        then
            scp "$file_name" "$remote":/home/tracy
        else
            echo "Provide a proper remote server"
        fi
    else
        echo "$file_name does not exist"
    fi
}

function generate_random() {
    while true
    do
        random_num=$((RANDOM))
        echo "Random number is: $random_num"
        sleep 3
    done
}

function display_column() {
    read -p "File here: " file
    read -p "Desired column number: " column
    if [ -f "$file" ]
    then
        awk -v col="$column" '{print $col}' "$file"
    else
        echo "$file doesn't exist"
    fi
}

function file_length() {
    read -p "File name: " file_name
    if [ -f "$file_name" ]
    then
        du -b "$file_name" | cut -f1
        echo "File size is: $file_name"
    else
        echo "$file_name doesn't exist"
    fi
}

function nest_directory() {
    read -p "First directory name : " first_name
    read -p "Now second: " second_name
    read -p "Now third: " third_name

    if [ -z "$first_name" ] || [ -z "$second_name" ] || [ -z "$third_name" ]
    then   
        echo "Directory name cannot be empty"
        exit
    fi
    
    if [ -e "$first_name/$second_name/$third_name" ]
    then
        echo "Directory doesn't exist"
        exit
    fi

    mkdir -p "$first_name/$second_name/$third_name"

    if [ "$?" -eq 0 ]
    then
        echo "Successfully created"
    else
        echo "An error occured"
    fi
}

function print_numbers() {
    for i in {0..20000}
    do
        echo $i
    done | less
}

function print_lines() {
    read -p "Enter a file: " file
    read -p "Word you want to search for: " word
    if [ -f "$file" ]
    then
        awk -v word="$word" '$0 ~ word {print $0}' "$file"
    else
        echo "$file doesn't exist"
    fi
}

function process() {
    ps
}

function stripoff_extension() {
    read -p "File name: " file_name
    
    if [ -f "$file_name" ]
    then
        if [[ "$file_name" == *.* ]]
        then 
            stripped_file=$(basename "$file_name" .*)
            echo "The stripped file is now: $stripped_file"
        else
            echo "$file_name has no extension"
        fi
    else
        echo "$file_name does not exist"
    fi
}

function delete_dir() {
    read -p "Directory name: " dir_name
    if [ -d "$dir_name" ]
    then
        rm -r "$dir_name"
    else
        echo "$dir_name doesn't exist"
    fi
}

function create_files_in_dir() {
    read -p "What do you want to call your directory? " dir_name
	mkdir "$dir_name"
    touch index.html style.css app.js
	mv index.html style.css app.js "$dir_name"
}

function show_ssh() {
    cat ~/.ssh/id_rsa.pub
}

function customize_cpu() {
    cpufetch
}

function customize_neo() {
    neofetch
}

function exit_program() {
    exit
}

if [ "$select" == 1 ]
then
    basic_calculation
elif [ "$select" == 2 ]
then
    read_file
elif [ "$select" == 3 ]
then
    delete_file
elif [ "$select" == 4 ]
then
    rename_file
elif [ "$select" == 5 ]
then 
    search_file
elif [ "$select" == 6 ]
then
    display_last_column
elif [ "$select" == 7 ]
then
    grade_reader
elif [ "$select" == 8 ]
then
    remote_server
elif [ "$select" == 9 ] 
then
    generate_random
elif [ "$select" == 10 ]
then
    display_column
elif [ "$select" == 11 ]
then
    file_length
elif [ "$select" == 12 ]
then
    nest_directory
elif [ "$select" == 13 ]
then
    print_numbers
elif [ "$select" == 14 ]
then
    print_lines
elif [ "$select" == 15 ]
then
    process
elif [ "$select" == 16 ]
then
    stripoff_extension
elif [ "$select" == 17 ]
then
    delete_dir
elif [ "$select" == 18 ]
then
    create_files_in_dir
elif [ "$select" == 19 ]
then
    show_ssh
elif [ "$select" == 20 ]
then
    customize_cpu
elif [ "$select" == 21 ]
then
    customize_neo
elif [ "$select" == 22 ]
then
    exit_program
else
    echo "Invalid option"
fi

