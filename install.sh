#!/bin/bash

# Script that installs `abtab`. It must be called from the same
# folder that folds config.cfg, cp.sh, cp.txt, abtab, and paths.json.

remove_carriage_returns() {
    local file="$1"
    if grep -q $'\r' "$file"; then
        tr -d '\r' <"$file" >file.new && mv file.new "$file"
    fi
}

handle_file() {
    local file="$1"
    local make_executable="$2"
    # If the file exists, handle it
    if [ -f "$file" ]; then
        # Remove any carriage returns
        # All line endings in a script called by bash must be Unix style ('\n') 
        # and not Windows style ('\r\n'), which cause the following error:
        # 
        #   ./<my_script>.sh: line <n>: $'\r': command not found
        #    
        # Any carriage returns ('\r') must therefore be removed.
        #
        # NB: Carriage returns can be avoided by creating the file in Sublime 4,
        # after adding the following in the right field at Preferences > Settings:
        #
        #   {
        #    "default_line_ending": "unix"
        #   }
        remove_carriage_returns "$file"

        # Make executable (if applicable)
        if [ "$make_executable" -eq 1 ]; then
            chmod +x "$file"
        fi
    # If not, return error
    else
        echo "File not found: $file."
        exit 1
    fi
}

echo "Installing ..."

# 1. Handle files TODO what about cp.txt, paths.json, and this file (install.sh)?
config_file="config.cfg"
#config_file="$(pwd)""/config.cfg"
handle_file "$config_file" 0
cp_file="cp.sh"
handle_file "$cp_file" 1
abtab_file="abtab"
handle_file "$abtab_file" 1

# 2. Source config.cfg to make *_PATHs available locally
echo "... reading configuration file ... "
source "$config_file"
root_path="$ROOT_PATH"
lib_path="$LIB_PATH"
#lib_path_parent=$(dirname "$lib_path")"/" # code path without abtab/ dir
exe_path="$EXE_PATH"
# Set root_path and lib_path in executable
TODO: 
replace ROOT_PATH_="" with ROOT_PATH_=" + root_path_esc + "
replace LIB_PATH_="" with LIB_PATH_=" + lib_path_esc + "
lp_placeholder="lp_placeholder"
rp_placeholder="rp_placeholder"
# Escape forward slashes and replace placeholder with result
lib_path_esc=$(echo "$lib_path" | sed 's/\//\\\//g')
sed -i "s/$lp_placeholder/$lib_path_esc/g" "$abtab_file"
root_path_esc=$(echo "$root_path" | sed 's/\//\\\//g')
sed -i "s/$rp_placeholder/$root_path_esc/g" "$abtab_file"

# 3. Handle config paths
echo "... handling paths ... "
# If paths don't exist, make them
config_paths=("$root_path" "$lib_path" "$exe_path")
for path in "${config_paths[@]}"; do
    if [ ! -d "$path" ]; then
        mkdir -p "$path"
    fi
done

# 4. Add exe_path (as cygpath) to the end of ~/.bash_profile  
# Create ~/.bash_profile if it doesn't exist
bp_file="$HOME/.bash_profile" # ~/.bash_profile
if [ ! -f "$bp_file" ]; then
  touch "$bp_file"
fi
# Create exe_path_cyg without trailing slash; if it has not been added,
# add to ~/.bash_profile and source ~/.bash_profile (apply the changes) 
exe_path_cyg=$(cygpath -u "$exe_path")
exe_path_cyg=$(echo "$exe_path_cyg" | sed 's:/*$::')
to_add="PATH=\$PATH:$exe_path_cyg" # PATH=$PATH:/cygdrive/c/Users/Reinier/bin
if ! grep -qxF "$to_add" "$bp_file"; then
  echo "$to_add" >> "$bp_file" 
  source "$bp_file"
fi

# 5. If needed: clear last folder (abtab/) on lib_path; remove executable from exe_path
# a. lib_path
echo "    ... clearing $lib_path ..."
# If lib_path is not empty: remove all contents from last folder (abtab/)
if [ ! -z "$(ls -A "$lib_path")" ]; then
    rm -rf "$lib_path"/*
fi
#if [ -d "$lib_path" ]; then
#    rm -r "$lib_path" # remove the last dir (abtab/) on lib_path 
#fi
#mkdir -p $lib_path
# b. exe_path
echo "    ... removing $exe_path$abtab_file ..."
# If the executable exists
if [ -f "$exe_path""$abtab_file" ]; then
    rm -f "$exe_path""$abtab_file" 
fi

## 6. Clone repos into pwd
## Extract parts before first slash; sort; get unique values
#repos=$(cut -d '/' -f 1 "cp.txt" | sort | uniq)
#for repo in $repos; do
#    # Ignore elements starting with a dot
#    if [[ ! "$repo" =~ ^\. ]]; then
#        repo_url="https://github.com/reinierdevalk/$repo.git"
#        echo "... cloning $repo_url ..."
#        git clone "$repo_url"
#    fi
#done

## 6. Make dirs on root_path
#echo "... creating directories on $root_path ..."
#paths=(
#       "templates/" 
#       "tabmapper/in/tab/" "tabmapper/in/MIDI/" "tabmapper/out/"
#       "transcriber/in/" "transcriber/out/"
#       "polyphonist/models/" "polyphonist/in/" "polyphonist/out/"
#       )
#for path in "${paths[@]}"; do
#    if [ ! -d "$root_path""$path" ]; then
#        mkdir -p "$root_path""$path"
#    fi
#done

# 7. Install abtab
echo "... installing abtab ..."
# Copy executable to exe_path
cp "$abtab_file" "$exe_path"
# Copy contents of pwd (excluding executable) to lib_path
for item in *; do
    if [ "$item" != "$abtab_file" ]; then
        cp -r "$item" "$lib_path"
    fi
done
#rsync -av --exclude="$abtab_file" ./ "$lib_path"

echo "done!"


## 4. Create folders
#echo "... creating folders ... "
#tabmapper_path="$full_path""tabmapper/"
#data_in="$tabmapper_path""data/in/"
#data_in_tab="$tabmapper_path""data/in/tab/"
#data_in_MIDI="$tabmapper_path""data/in/MIDI/"
#data_out="$tabmapper_path""data/out/"
#if [ ! -d "$data_in" ]; then
#    mkdir -p "$data_in"
#fi
#if [ ! -d "$data_in_tab" ]; then
#    mkdir -p "$data_in_tab"
#fi
#if [ ! -d "$data_in_MIDI" ]; then
#    mkdir -p "$data_in_MIDI"
#fi
#if [ ! -d "$data_out" ]; then
#    mkdir -p "$data_out"
#fi