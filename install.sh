#!/bin/bash

# Script that installs `abtab`. It must be called from the same
# folder that folds config.cfg, cp.sh, cp.txt, abtab, and paths.json.

config_file="config.cfg"
cp_file="cp.sh"
abtab_file="abtab"

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
echo "Installation process started ..."

# 1. Handle files
echo "... handling files ..."
handle_file "$config_file" false
handle_file "$cp_file" true
handle_file "$abtab_file" true

# 2. Configure paths 
# Source config.cfg (make PATHs available locally)
echo "... configuring paths ... "
source "$config_file"
root_path="$ROOT_PATH"
lib_path="$LIB_PATH"
exe_path="$EXE_PATH"
config_paths=("$root_path" "$lib_path" "$exe_path")
for path in "${config_paths[@]}"; do
    if [ ! -d "$path" ]; then
        mkdir -p "$path"
    fi
done

# Set ROOT_PATH_ and LIB_PATH_ in executable
# NB This requires forward slashes in root_ and lib_path to be escaped
rp_placeholder="rp_placeholder"
lp_placeholder="lp_placeholder"
root_path_esc=$(echo "$root_path" | sed 's/\//\\\//g')
lib_path_esc=$(echo "$lib_path" | sed 's/\//\\\//g')
sed -i "s/$rp_placeholder/$root_path_esc/g" "$abtab_file"
sed -i "s/$lp_placeholder/$lib_path_esc/g" "$abtab_file"

Also in dev case:
root_path = F:/research/computation/abtab/
root_path contains models/, templates/, and tool_data/ 
--> needs to be changed in paths.json, together with the four paths below TEMPLATES_PATH there
contents of templates/ and models/ needs to be copied to abtab/ repo every time a push is made

# Other paths needed on ROOT_PATHS
# models/ and templates/, both with contents, need to be copied from git
  "MODELS_PATH":                "models/",
  "TEMPLATES_PATH":             "templates/",
  "TABMAPPER_PATH":             "tool_data/tabmapper/",
  "DIPLOMAT_PATH":              "tool_data/transcriber/diplomatic/",
  "POLYPHONIST_PATH":           "tool_data/transcriber/polyphonic/",
  "ANALYSER_PATH":              "tool_data/analyser/",