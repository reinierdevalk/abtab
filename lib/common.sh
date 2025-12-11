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