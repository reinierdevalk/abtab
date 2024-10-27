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