#!/bin/bash

# Script that constructs the classpath from cp.txt. This
# script is called by abtab every time it is run.

lib_path=$1
is_win=$2

# Read each line from cp.txt, prepend lib_path, add
# semicolon, and append to classpath
# NB: for the last line to be read, cp.txt must end with
#     a line break
classpath=""
while IFS= read -r line; do
    # Trim any leading/trailing whitespace and unexpected characters
    clean_line=$(echo "$line" | tr -d '\r\n' | sed 's/[^[:print:]]//g')
    # Windows case
    if "$is_win"; then
#    if [ "$is_win" -eq 1 ]; then
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
done < "$lib_path""cp.txt"

# Read each line from cp.txt, prepend lib_path, add
# semicolon, and append to classpath
# NB: for the last line to be read, cp.txt must end with
#     a line break
#classpath=""
#while IFS= read -r line; do
##    classpath+="$line;"
#    if "$is_win"; then
#
#        a="$lib_path$line""\\bin\\;"
##        a="$(cygpath -w "$lib_path$line")"";"
#        classpath+=$a
#        echo "JAJAJA"
#        echo $a
#
##        echo $(cygpath -w "$lib_path$line")
##        classpath+="$lib_path$line;"
#    else
#        classpath+="$lib_path$line;"
#    fi
#done < "$lib_path""cp.txt"

# Remove any carriage returns; remove trailing semicolon
classpath=$(echo "$classpath" | tr -d '\r')
classpath=${classpath%;}

# Return the constructed classpath
echo "$classpath"