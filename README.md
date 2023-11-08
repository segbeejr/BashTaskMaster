# Bash-Tasks-Manager
A Bash application that makes possible the execution of multiple tasks, based on a user's selection. When the program is ran, a drop-down menu is displayed that shows the user multiple options of tasks they could perform and based on the user's choice from the options provided, a task is executed if and when the instructions are followed carefully.

## Key Features

+ Perform calculations
  ```
    Addition(+), Subtraction(-), Multiplication(*), and Division(/)
  ```

+ Strip off a file extension
  ```
    Using the basename command: basename filename.txt .txt
  ```

+ Display file contents
  ```
    Using awk and cat commands to show the contents of the file: awk '{print $0}' filename or cat filename
  ```

+ Display the last column in a file
  ```
    Using the awk command: awk '{print NF}' filename; NF stores the number of fields or columns in the row allowing us to see and get the last one in a file with thousands of     columns
  ```

+ Tell which level in education can read contents within a file
  ```
    This is a mini program within a function that has tons of commands being used, but most importantly, the calculations are done using the Coleman-Liau index principle
  ```

+ Create nested directories(directory in directory)
  ```
    Using the mkdir -p command: mkdir -p dir_name
  ```
  
+ Remove or delete a file
  ```
    Using the rm command: rm filename
  ```

+ Remove or delete a directory
  ```
    Using the rm -r command: rm -r dir_name; specifically for diectories with contents within them
  ```
  
+ Print a million numbers; display it page by page
  ```
    Using the for loop and piping the output to less: for loop | less
  ```
More...


## Use
+ Run the TaskManager script in your terminal.
   ```
    $ bash script.sh
   ```
   
+ Choose a task from the provided menu by entering the corresponding number.
  ```
    $ Select a task to execute: 1
    $ What calculation would you like to perform? Addition
  ```
  
+ When an option is selected, follow all other instructions to execute that task.
  ```
    $ Enter a number: 1
    $ Now the second: 2
  ```
    
+ When the task is executed, the result is displayed
  ```
    Result is 3
  ```
