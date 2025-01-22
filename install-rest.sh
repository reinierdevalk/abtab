





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