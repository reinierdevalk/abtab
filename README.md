# Introduction

AbsoLutely Tabulous (`abtab`) is a toolbox for computational processing and analysis of music in lute tablature, written in Java, Python, and Bash. A prototype is currently being developed within the [E-LAUTE]() project. `abtab` is extensible and multi-modular, builds on existing tools and research, and is designed as a portable command-line tool that runs on Windows and Unix-based operating systems. For more information, see [this poster](https://drive.google.com/file/d/14hKBHfRaqwZnS9KqpreFySfvTffAQ5PI/view?usp=sharing), which was presented at the 2nd International Conference on Computational and Cognitive Musicology (CCCM), Utrecht, the Netherlands, 17-18 October 2024.

# Dependencies
Currently, `abtab` has only been tested on a Windows machine, using [`Cygwin`](https://www.cygwin.com/), a free Unix-like environment and command-line interface (CLI) for Windows. It is recommended to install this CLI, or a similar Unix-emulating CLI such as the ones provided by [Git](https://git-scm.com/) or [Git for Windows](https://gitforwindows.org/).

Furthermore, in order to be able to run `abtab`, you must have [Java](https://www.java.com/) and [Python](https://www.python.org/downloads/) installed on your computer. The current version of `abtab` uses Python `3.12.0`; for Java, any version >= `11.0.1` will do. You can check which version you have installed as follows.

    $ python --version
    $ java -version 

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
     - On Windows: `C:/Users/<Name>/lib/abtab/` . 
     - On Unix: `/usr/local/lib/abtab/`.
   - Replace the default value of the `EXE_PATH` variable with `<exe_path>`; make sure it ends with a `/`. `<exe_path>` is the location where the installer places the executable. Recommended locations are 
     - On Windows: `C:/Users/<Name>/bin/`.
     - On Unix: `/usr/local/bin/`.
    
    If the `lib/` and `bin/` directories do not exist on your computer, you can still use the recommended locations -- the directories will be created by the installer.  

4. Run the installer, `install.sh`, from `<root_path>`.
    ```
    $ bash install.sh
    ```
   The installer 
   - Checks whether `lib_path` and `exe_path` exist, and creates them if they do not.
   - Sets `root_path` and `lib_path` in the executable.
   - Adds `<exe_path>` to the `$PATH` variable if it is not on it yet. You can check which paths are on the `$PATH` variable as follows.
       ```
       $ echo $PATH
       ```
   - Handles any previously installed version of `abtab`: removes any old executable from `<exe_path>`, and clears `<lib_path>`.
   - Creates, in `<root_path>`, the `data/` directory structure, and moves the example `.tc` and `.mid` files into the `data/<tool>/in/` subdirectories.
   - Clones the required repositories from `https://github.com/reinierdevalk/` into `<root_path>`. Thse include
       - Code repositories, as listed in `cp.txt`.
       - Non-code repositories, as specified in `config.cfg`.
   - Installs `abtab`: moves all code to `<lib_path>`, and the executable to `<exe_path>`.

   When the installation process is finished, `<root_path>` contains
   - The `data/` directory. Contains, for each tool, the directories from which the input files are read (`in/`) and to which the output files are stored (`out/`). Apart from the example files moved into them during the installation process, these directories are empty.  
   - The `models/` directory. Contains the trained machine learning models called by the `transcriber` tool.
   - The `templates/` directory. Contains a high-level template of an MEI file, whose `<header>` can be adapted at will. 

6. Run `abtab`. This can be done from any directory on your computer. Use the help (`-h` or `--help`) option to get started.
    ``` 
    $ abtab -h 
    $ abtab --help 
   ```

    You can use the provided example files to experiment. 
    [ADD EXAMPLES]