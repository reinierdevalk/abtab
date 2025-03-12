#!/bin/bash

# Script that constructs the classpath from repositories.txt. This
# script is called by abtab every time it is run.

# Ensure the script has executable permission
if [ ! -x "$0" ]; then
    chmod +x "$0"
fi

lib_path=$1
is_win=$2
repositories="repositories.txt"

# Read each line from repositories, prepend lib_path, add semicolon,
# and append to classpath. Break as soon as an empty line  
# (dividing classpath- and non-classpath repos) is encountered 
# NB: for the last line to be read, cp.txt must end with
#     a line break
classpath=""
while IFS= read -r line; do
    # Trim any leading/trailing whitespace and unexpected characters
    clean_line=$(echo "$line" | tr -d '\r\n' | sed 's/[^[:print:]]//g')

    # If clean_line is empty: break
    if [[ -z "$clean_line" ]]; then
        break
    # If not: add to classpath 
    else
        # Windows case
        if "$is_win"; then
            # If line is a dot (i.e., starts with a dot)
            if [[ "$clean_line" == .* ]]; then
                # First make win_path; then add dot (is removed by cygpath)
                win_path=$(cygpath -w "$lib_path")
                classpath+="$win_path$clean_line;"
            else
                win_path=$(cygpath -w "$lib_path$clean_line")
                classpath+="$win_path"bin";"
                classpath+="$win_path"lib\\*";"
            fi
        # Unix case
        else
            unix_path="$lib_path$clean_line"
            # If line is a dot (i.e., starts with a dot)
            if [[ "$clean_line" == .* ]]; then
                classpath+="$unix_path;"
            else
                classpath+="$unix_path"bin";"
                classpath+="$unix_path"lib/*";"
            fi
        fi
    fi
done < "$lib_path""$repositories"

# Remove any carriage returns; remove trailing semicolon
classpath=$(echo "$classpath" | tr -d '\r')
classpath=${classpath%;}

# Return the constructed classpath
echo "$classpath"