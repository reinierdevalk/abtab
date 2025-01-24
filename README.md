# Introduction

AbsoLutely Tabulous (`abtab`) is a toolbox for computational processing and analysis of music in lute tablature, written in Java, Python, and Bash. A prototype is currently being developed within the [E-LAUTE]() project. `abtab` is extensible and multi-modular, builds on existing tools and research, and is designed as a portable command-line tool that runs on Windows and Unix-based operating systems. For more information, see [this poster](), which was presented at the 2nd International Conference on Computational and Cognitive Musicology (CCCM), Utrecht, the Netherlands, 17-18 October 2024.  

# Installation

1. Create, on a path of choice on your computer, a directory called `abtab`. The path up to and including this directory is the `<root_path>`.

2. Clone the `abtab` repository in `<root_path>` (note the dot at the end of the `clone` command!).
    ```
    $ cd <root_path>/ 
    $ git clone https://github.com/reinierdevalk/abtab.git .
    ```
3. Open `config.cfg` and
   - Replace the default value of the `ROOT_PATH` variable with `<root_path>`.
   - Replace the default value of the `LIB_PATH` variable with `<lib_path>`, i.e., the location where the installer should place the code. Suggested locations are
     - On Windows: `C:/Users/<Name>/lib/abtab/` . 
     - On Unix: `/usr/local/lib/abtab/`.
   - Replace the default value of the `EXE_PATH` variable with `<exe_path>`, i.e., the location where the installer should place the executable. Suggested locations are 
     - On Windows: `C:/Users/<Name>/bin/`.
     - On Unix: `/usr/local/bin/`.
   
   Always use Unix-style (forward) slashes as separators.

4. Run the installer, `install.sh`, from `<root_path>`.
    ```
    $ bash install.sh
    ```

   The installer 
   - Checks whether `lib_path` and `exe_path` exist, and creates them if they do not.
   - Sets `root_path` and `lib_path` in the executable `abtab`.
   - Adds `<exe_path>` to the `$PATH` variable if it is not on it yet. You can check which paths are on the `$PATH` variable as follows
   ```
       $ echo $PATH
   ```
   - Handles any previously installed version of `abtab`: removes any old executable from `<exe_path>`, and clears `<lib_path>`.
   - Creates the `data/` directories and moves the example `.tc` and `.mid` files into the `in/` subdirectories.  
   - Clones the necessary repositories from GitHub into `<root_path>`.
   - Installs `abtab`: moves all code to `<lib_path>`, and the executable to `<exe_path>`.

   When the installation process is finished, `<root_path>` contains
   - The `data/` directory (with the example files): contains, for each tool, the directories from which the input files are read, and to which the output files are stored.
   - The `models/` directory: contains trained machine learning models, called by the `transcriber` tool.
   - The `templates/` directory: contains a high-level template of an MEI file, whose `<header>` can be adapted at will. 

6. Run `abtab`. This can be done from any directory on your computer. Use the help (`-h` or `--help`) option to get started.
    ``` 
    $ abtab -h 
    $ abtab --help 
   ```

# Dependencies

In order to be able to run `abtab`, you must have [Java](https://www.java.com/) and [Python](https://www.python.org/downloads/) installed on your computer. The current version of `abtab` uses Python 3.12.0.  

Currently, `abtab` has only been tested on a Windows machine, using [`Cygwin`](https://www.cygwin.com/), a free Unix-like environment and command-line interface (CLI) for Windows. It is recommended to install this, or a similar Unix-emulating CLI.