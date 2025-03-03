# Introduction

AbsoLutely Tabulous (`abtab`) is a toolbox for computational processing and analysis of music in lute tablature, written in Java, Python, and Bash. A prototype is currently being developed within the [E-LAUTE]() project. `abtab` is extensible and multi-modular, builds on existing tools and research, and is designed as a portable command-line tool that runs on Windows and Unix-based operating systems. For more information, see [this poster](https://drive.google.com/file/d/14hKBHfRaqwZnS9KqpreFySfvTffAQ5PI/view?usp=sharing), which was presented at the 2nd International Conference on Computational and Cognitive Musicology (CCCM), Utrecht, the Netherlands, 17-18 October 2024.

# Dependencies
Currently, `abtab` has only been tested on a Windows machine, using [Cygwin](https://www.cygwin.com/), a free Unix-like environment and command-line interface (CLI) for Windows. If you are using Windows, it is recommended to install this CLI, or a similar Unix-emulating CLI such as the ones provided by [Git](https://git-scm.com/) or [Git for Windows](https://gitforwindows.org/).

Furthermore, in order to be able to run `abtab`, you must have [Java](https://www.java.com/) and [Python](https://www.python.org/downloads/) installed on your computer. The current version of `abtab` uses Python `3.12.0`; for Java, any version >= `11.0.1` will do. You can check which version you have installed as follows.

    $ python --version
    $ java -version 

## Adding the Python and Java path to the system `PATH` (Windows only)

If Python and Java are installed on your system, you must make sure that they are available in your Unix-emulating CLI -- i.e., that the Python path and Java path are on the system `PATH`. The Python path is usually something like `C:/Users/<Username>/AppData/Local/Programs/Python/Python<version>/` or `C:/Python<version>/`, while the Java path is usually something like `C:/Program Files/Java/jdk-<version>/bin/` (64-bit systems) or `C:/Program Files (x86)/Java/jdk-<version>/bin/` (32-bit systems). You can check the exact paths on your own machine.

You can check which paths are on the system `PATH` as follows.

    $ echo $PATH 

Note that the paths listed have been adapted to the Unix-style format that the CLI understands. Cygwin, for example, uses the prefix `/cygdrive/c/` to replace the `C:/` in the Windows path -- meaning that every `C:/...` path becomes `/cygdrive/c/...`. If your Python and Java path are not among the paths listed, you must add them to the system `PATH`. You do this by adding them to `.bash_profile`. `.bash_profile` is usually located in your `HOME` directory (`~/`); you can check this as follows.

    $ cd ~/
    $ ls -a

If the file does not appear in the items listed, you must create it.

    $ touch ~/.bash_profile

Add the (aptly formatted) paths to `.bash_profile` by opening the latter with your editor of choice, and then adding the following lines to it (replacing `<formatted_python_path>` and `<formatted_java_path>`with your actual paths).

    export PATH="$PATH:<formatted_python_path>"
    export PATH="$PATH:<formatted_java_path>"

e.g., 

    export PATH="$PATH:/c/cygdrive/<Username>/AppData/Local/Programs/Python/Python<version>/"
    export PATH="$PATH:/c/cygdrive/Program Files/Java/jdk-<version>/bin/"

Finally, `source` `.bash_profile` to apply the changes. Alternatively, you can simply close and reopen the CLI terminal. (Sometimes, both actions are needed.)

    $ source ~/.bash_profile

# Installation

1. Create, on a path of choice on your computer, a directory called `abtab/`. The path up to and including this directory is referred to as `<root_path>`, and the directory itself is where you will be working from.

2. `cd` into `<root_path>` and clone the `abtab` GitHub repository into it (note the dot at the end of the `clone` command!).
    ```
    $ cd <root_path>
    $ git clone https://github.com/reinierdevalk/abtab.git .
    ```

3. Open `config.cfg` and adapt the paths. Always use Unix-style forward slashes (`/`) as separators.
   - Replace the default value of the `ROOT_PATH` variable with `<root_path>`; make sure it ends with a `/`. 
   - Replace the default value of the `LIB_PATH` variable with `<lib_path>`; make sure it ends with a `/`. `<lib_path>` is the location where the installer places the code. Recommended locations are
     - On Windows: `C:/Users/<Username>/lib/abtab/` . 
     - On Unix: `/usr/local/lib/abtab/`.
   - Replace the default value of the `EXE_PATH` variable with `<exe_path>`; make sure it ends with a `/`. `<exe_path>` is the location where the installer places the executable. Recommended locations are 
     - On Windows: `C:/Users/<Username>/bin/`.
     - On Unix: `/usr/local/bin/`.
    
    If the recommended `<lib_path>` and `<exe_path>` do not exist on your computer, you can still use them -- the directories will be created by the installer.

    If the specified `<exe_path>` is not on the system `PATH`, you must add it. The procedure for doing this is exactly the same as the one for adding the Python and Java path (as described above under `Adding the Python and Java path to the system PATH`).  

4. Run the installer, `install.sh`, from `<root_path>`.
    ```
    $ ./install.sh
    ```
   The installer 
   - Checks whether `lib_path` and `exe_path` exist, and creates them if they do not.
   - Sets `root_path` and `lib_path` in the executable.
   - Handles any previously installed version of `abtab`: removes any old executable from `<exe_path>`, and clears `<lib_path>`.
   - Creates, in `<root_path>`, the `data/` directory structure, and moves the example `.tc` and `.mid` files into the `data/<tool>/in/` subdirectories.
   - Clones the required repositories from `https://github.com/reinierdevalk/` into `<root_path>`. These include
       - Code repositories, as listed in `repositories.txt` (before the empty line).
       - Non-code repositories, as listed in `repositories.txt` (after the empty line).
   - Installs `abtab`: moves all code to `<lib_path>`, and the executable to `<exe_path>`.

   When the installation process has finished, `<root_path>` contains
   - The `data/` directory. Contains, for each tool, the directories from which the input files are read (`in/`) and to which the output files are stored (`out/`). Apart from the example files moved into them during the installation process, these directories are empty.  
   - The `models/` directory. Contains the trained machine learning models called by the `transcriber` tool.
   - The `templates/` directory. Contains a high-level template of an MEI file, whose `<header>` can be adapted at will. 

5. Run `abtab`. This can be done from any directory on your computer. Use the help (`-h` or `--help`) option to get started; this lists all the currently available tools in the toolbox.
    ``` 
    $ abtab -h 
    $ abtab --help 
   ```

# Example usage
You can use the provided example files to experiment with the various tools. 
    
## `converter`
The `converter` tool opens a simple editor, the `tab+Editor`, originally written to edit and view files in `abtab`'s native encoding format, tab+. It allows you to
  - Open a file in one of four different tablature encoding formats: tab+ (`.tbp`); TabCode (`.tc`); MEI (`.mei`); and ASCII (`.tab`). 
  - View and adapt the file contents. 
  - Save the file in one of the four encoding formats.
 
`converter` is called as follows.

    $ abtab converter

 Use `File` > `Open` to open a file in the tab+ format, and `File` > `Import` to import a file in one of the other formats. The file contents are shown in the `Encoding` window and can be edited at will there, and viewed in the `Tablature` window by clicking the `View` button. Note that the file contents -- also those of imported files -- are always shown in the tab+ format.  

Use `File` > `Save` (or `File` > `Save as`) to save the file in the tab+ format; use `File` > `Export` to save it in one of the other formats. By default, files are loaded from and saved to the `data/converter/` directory -- but the source and destination directories are selectable.

Alternatively, if both a source and a destination file are provided when `converter` is called, the editor is not opened, and the file in the source format is converted directly into the file in the destination format -- without any editing or viewing options.

    $ abtab converter source.<ext> destination.<ext>

## `analyser`

[TODO]

## `tabmapper`

[TODO]

## `transcriber`

[TODO]
