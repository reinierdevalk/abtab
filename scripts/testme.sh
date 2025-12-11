# a. Set automatically (by sourcing commonfile)
IS_WIN=
PYTHON=
# NB Using SCRIPT_PATH ensures that no matter from which directory the user 
#    runs the script, it will always find commonfile relative to the script
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)""/" # get the absolute path of the current script
#source "$SCRIPT_PATH$commonfile"
REPO_PATH="$(cd "$SCRIPT_PATH/.." && pwd)"

echo $SCRIPT_PATH
echo $REPO_PATH


REPO_PATH_WIN="$(windows_path "$REPO_PATH")"

echo $REPO_PATH_WIN

#LIB_PATH_="path/lib/"
#EXE_PATH_="path/bin/"
#for pathvar in LIB_PATH_ EXE_PATH_; do
#	path="${!pathvar}"
#	echo "Error: $pathvar $path is a critical system path." >&2
#done



#for item in *; do
#	[[ -e "$item" ]] || continue # if item does not exist
# 
#    # Move only files/folders that are not in skip
#    if [[ ! " ${skip[@]} " =~ " ${item} " ]]; then # the spaces around skip/item avoid partial match
#        # NB use cp && rm; mv gives permissions error
#        cp -r -- "$item" "$LIB_PATH_"
#        if [[ -d "$item" ]]; then 
#        	rm -rf -- "$item"
#    	elif [[ -f "$item" ]]; then 
#        	rm -- "$item"
#        fi 
##        cp -r "$item" "$LIB_PATH_" && rm -rf "$item" # NB use cp && rm; mv gives permissions error
#    fi
#done