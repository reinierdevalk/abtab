ABTABNAME="abtab"
example1="judenkuenig-elslein_liebes_elslein"
example2="rore-anchor_che_col_1-10"
GITHUB_USER="reinierdevalk"
GITHUB_URL="https://github.com/$GITHUB_USER/"
DATA_DIR="data/"
EXAMPLES_DIR="examples/"
MODELS_DIR="models/"
SCRIPTS_DIR="scripts/"
TEMPLATES_DIR="templates/"
TMP_DIR="tmp/"
abtabfile="$ABTABNAME"
classpathfile="classpath.sh"
configfile="config.cfg"
gitignorefile=".gitignore"
installfile="install"
pathsfile="paths.json"
repositoriesfile="repositories.txt"
requirementsfile="requirements.txt"
templatefile="template-MEI.mei"
updatefile="update"
versionfile="VERSION"


if [[ -n "$WINDIR" || "$os_type" == CYGWIN* || "$os_type" == MINGW* || "$os_type" == MSYS* ]]; then
    IS_WIN=true
else
	IS_WIN=false
fi

if command -v python3 &> /dev/null; then
    PYTHON="python3"
else
    PYTHON="python"
fi

handle_file() {
    local file="$1"
    local make_executable="$2"
    # If the file exists, handle it
    if [[ -f "$file" ]]; then
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
        _remove_carriage_returns "$file"

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

_remove_carriage_returns() {
    local file="$1"
    if grep -q $'\r' "$file"; then
        tr -d '\r' <"$file" >file.new && mv file.new "$file"
    fi
}

check_pathname() {
    # Checks that the given path name is not unset/empty, 
    # and that it ends with a slash.
    
    local pathname="$1"
    declare -n ref="$pathname" # nameref to the actual variable

    # Check that variable is set and non-empty
    if [[ -z "$ref" ]]; then
        echo "Error: $pathname is not set or empty." >&2
        exit 1
    fi

    # Ensure that variable ends with a slash
    if [[ "${ref: -1}" != "/" ]]; then
        ref="${ref}/"
    fi
}