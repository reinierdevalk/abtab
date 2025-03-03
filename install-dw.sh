#!/bin/bash

# Script that installs `abtab`. It must be called from the same
# folder that folds config.cfg, classpath.sh, repositories.txt, 
# abtab, and paths.json.
#
# NB: When editing this file with Sublime, set the line endings to Unix: 
#     View > Line endings > Unix


# Check OS: Windows or Linux-like
IS_WIN=false
if [[ -n "$WINDIR" || "$os_type" == "CYGWIN"* || "$os_type" == "MINGW"* || "$os_type" == "MSYS"* ]]; then
    IS_WIN=true
fi

config="config.cfg"
repositories="repositories.txt"
abtab="abtab"
ex_tab="rore-anchor_che_col_1-10.tc"
ex_mid="rore-anchor_che_col_1-10.mid"


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
        if [[ "$make_executable" == "true" ]]; then
            chmod +x "$file"
        fi
    # If not, return error
    else
        echo "File not found: $file."
        exit 1
    fi
}


echo "Installation started ..."

# 1. Handle files
echo "... handling files ..."
handle_file "$config" false
handle_file "$repositories" true
handle_file "$abtab" true

# 2. Configure and create paths 
# Source config (make PATHs available locally)
echo "... configuring paths ... "
source "$config"
root_path="$ROOT_PATH"
lib_path="$LIB_PATH"
exe_path="$EXE_PATH"
config_paths=("$root_path" "$lib_path" "$exe_path")
for path in "${config_paths[@]}"; do
    if [ ! -d "$path" ]; then
        echo "    ... creating $path ..."
        mkdir -p "$path"
    else 
        echo "    ... creating $path -- path already exists ..."
    fi
done

# 3. Set ROOT_PATH_ and LIB_PATH_ in executable
rp_placeholder="rp_placeholder"
lp_placeholder="lp_placeholder"
if $IS_WIN; then
    # Escape forward slashes in root_ and lib_path
    root_path_esc=$(echo "$root_path" | sed 's/\//\\\//g')
    lib_path_esc=$(echo "$lib_path" | sed 's/\//\\\//g')
    sed -i "s/$rp_placeholder/$root_path_esc/g" "$abtab"
    sed -i "s/$lp_placeholder/$lib_path_esc/g" "$abtab"
else
    # dw
    sed -i "" "s|$rp_placeholder|$root_path|g" "$abtab"
    sed -i "" "s|$lp_placeholder|$lib_path|g" "$abtab"
#    root_path_esc="/var/git/abtab/"
#    lib_path_esc="/var/git/abtab/lib/abtab/"
#    sed -i "" "s|$rp_placeholder|$root_path_esc|g" "$abtab"
#    sed -i "" "s|$lp_placeholder|$lib_path_esc|g" "$abtab"
fi



# 4. Add exe_path (as cygpath) to the end of ~/.bash_profile (i.e., add it to $PATH) 
# Create ~/.bash_profile if it doesn't exist
# NB On Windows using Cygwin, it is in C:/cygwin64/home/<Name>/
bp_file="$HOME/.bash_profile" # ~/.bash_profile
if [ ! -f "$bp_file" ]; then
  touch "$bp_file"
fi
# Create exe_path_cyg without trailing slash; if it has not been added,
# add to ~/.bash_profile and source ~/.bash_profile (apply the changes) 
# rdv
exe_path_cyg=$(cygpath -u "$exe_path")
# dw
exe_path_cyg=$exe_path
exe_path_cyg=$(echo "$exe_path_cyg" | sed 's:/*$::') # remove trailing slash
to_add="PATH=\$PATH:$exe_path_cyg" # PATH=$PATH:/cygdrive/c/Users/Reinier/bin
if ! grep -qxF "$to_add" "$bp_file"; then
  echo "$to_add" >> "$bp_file" 
  source "$bp_file"
fi

# 5. Handle any existing version of abtab
echo "... handling existing version of abtab ... "
# a. Clear abtab/ folder on lib_path
# Make sure that lib_path is set
if [ -z "$lib_path" ]; then
    echo "Error: lib_path is not set." >&2
    exit 1
fi
# Make sure lib_path is a valid directory
if [ ! -d "$lib_path" ]; then
    echo "Error: lib_path '$lib_path' is not a valid directory." >&2
    exit 1
fi
# Make sure that lib_path is not a dangerous or root directory
if [ "$lib_path" = "/" ] || [ "$lib_path" = "/usr" ] || [ "$lib_path" = "/home" ]; then
    echo "Error: lib_path '$lib_path' is a critical system path." >&2
    exit 1
fi
# If lib_path is not empty: clear abtab/ folder
if [ "$(find "$lib_path" -mindepth 1 -print -quit)" ]; then
	echo "    ... clearing $lib_path ..."
	rm -rf "$lib_path"/*
else
    echo "    ... clearing $lib_path -- path already clear ..."
fi
# b. Remove executable from exe_path
# Make sure that exe_path and abtab are set
if [ -z "$exe_path" ] || [ -z "$abtab" ]; then
    echo "Error: exe_path or abtab is not set." >&2
    exit 1
fi
# Make sure exe_path is a valid directory
if [ ! -d "$exe_path" ]; then
    echo "Error: exe_path '$exe_path' is not a valid directory." >&2
    exit 1
fi
# Make sure that file_path is set
file_path="$exe_path$abtab"
if [ -z "$file_path" ]; then
    echo "Error: file_path is not set." >&2
    exit 1
fi
# Make sure that file_path starts with exe_path
if [[ "$file_path" != "$exe_path"* ]]; then
    echo "Error: file_path '$file_path' is outside the expected directory '$exe_path'." >&2
    exit 1
fi
# If file_path exists: remove executable
if [ -f "$file_path" ]; then
    echo "    ... removing existing version of $abtab from $exe_path ..."
    rm -f "$file_path" 
else
    echo "    ... removing existing version of $abtab from $exe_path -- no existing version found ..."
fi

# 6. Create data dirs on root_path
echo "... creating data directories ..."
paths=(
       "analyser/in/" "analyser/out/"
       "converter/"
       "tabmapper/in/tab/" "tabmapper/in/MIDI/" "tabmapper/out/"
       "transcriber/diplomatic/in/" "transcriber/diplomatic/out/"
       "transcriber/polyphonic/in/" "transcriber/polyphonic/out/"
      )
data_dir="data/"
for dir_ in "${paths[@]}"; do
    full_dir="$root_path""$data_dir""$dir_"
    if [ ! -d "$full_dir" ]; then
        echo "    ... creating $data_dir$dir_ ..."
        mkdir -p "$full_dir"
    else
        echo "    ... creating $data_dir$dir_ -- directory already exists ..."
    fi
done
# Copy example files; then delete them
cp "$ex_tab" "$root_path""$data_dir""analyser/in/"
cp "$ex_tab" "$root_path""$data_dir""converter/"
cp "$ex_tab" "$root_path""$data_dir""tabmapper/in/tab/"
cp "$ex_mid" "$root_path""$data_dir""tabmapper/in/MIDI/"
#cp "$ex_tab" "$root_path""$data_dir""transcriber/diplomatic/in/" # TODO: currently accepts only .mei
cp "$ex_tab" "$root_path""$data_dir""transcriber/polyphonic/in/"
rm -f "$ex_tab"
rm -f "$ex_mid"

# 7. Clone repos into pwd
echo "... cloning repositories ... "
# Collect contents of repositories in repos
repos=""
is_blank=false
while IFS= read -r line || [[ -n $line ]]; do
    # Trim leading and trailing whitespace
    trimmed_line=$(echo "$line" | xargs)

    # Skip emtpy line (which divides cp- and non-cp repos)
    if [[ -z "$trimmed_line" ]]; then
        continue
    fi

    # If the trimmed line does not start with a dot: add the 
    # part before the first slash
    if [[ ! $trimmed_line == .* ]]; then
        [[ -n "$repos" ]] && repos+=" " # if str is non-empty, add space
        repos+="${trimmed_line%%/*}"
    fi
done < "$repositories"
## a. Add repos that go on the class path (listed in repos)
## Extract parts before first slash | exclude items starting with a dot | sort | get unique values 
#repos=$(cut -d '/' -f 1 "$repos" | grep -v '^\.' | sort | uniq)
## b. Add repos that do not go on the class path (listed in config)
#repos="${repos} ${add_repos}" # add_repos is from config
for repo in $repos; do
    repo_url="https://github.com/reinierdevalk/$repo.git"
    if [[ ! -d "$repo" ]]; then
        echo "    ... cloning $repo_url ..."
        git clone "$repo_url"
    else
        echo "    ... cloning $repo_url -- repository already exists ..."
    fi
done

# 8. Install abtab
echo "... installing abtab ..."
# Move executable to exe_path
cp "$abtab" "$exe_path" && rm "$abtab" # NB use cp ... && rm ...; mv gives permissions error
# Move contents of pwd to lib_path
skip=("models" "templates" "data" "bin" "lib")
for item in *; do
    # Move only files/folders that are not in skip
    if [[ ! " ${skip[@]} " =~ " ${item} " ]]; then # the spaces around skip/item avoid partial match
#    if [ "$item" != "models" ]; then
        cp -r "$item" "$lib_path" && rm -rf "$item" # NB use cp && rm; mv gives permissions error
    fi
done

echo "... installation complete!"


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

#Also in dev case:
#root_path = F:/research/computation/abtab/
#root_path contains models/, templates/, and tool_data/ 
#--> needs to be changed in paths.json, together with the four paths below TEMPLATES_PATH there
#contents of templates/ and models/ needs to be copied to abtab/ repo every time a push is made
#
## Other paths needed on ROOT_PATHS
## models/ and templates/, both with contents, need to be copied from git
#  "MODELS_PATH":                "models/",
#  "TEMPLATES_PATH":             "templates/",
#  "TABMAPPER_PATH":             "tool_data/tabmapper/",
#  "DIPLOMAT_PATH":              "tool_data/transcriber/diplomatic/",
#  "POLYPHONIST_PATH":           "tool_data/transcriber/polyphonic/",
#  "ANALYSER_PATH":              "tool_data/analyser/",