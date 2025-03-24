# Introduction
AbsoLutely Tabulous (`abtab`) is a toolbox for computational processing and analysis of music in lute tablature, written in Python, Java, and Bash. A prototype is currently being developed within the [E-LAUTE](https://e-laute.info/) project. `abtab` is extensible and multi-modular, builds on existing tools and research, and is designed as a portable command-line tool that runs on Windows and Unix-based (currently, macOS) operating systems. For more information, see [this poster](https://drive.google.com/file/d/14hKBHfRaqwZnS9KqpreFySfvTffAQ5PI/view?usp=sharing), which was presented at the 2nd International Conference on Computational and Cognitive Musicology (CCCM), Utrecht, the Netherlands, 17-18 October 2024.

# Dependencies
## Command-line interface
If you are using Windows, it is strongly recommended to install a Unix-like environment and command-line interface (CLI) such as [Cygwin](https://www.cygwin.com/), [Git Bash](https://gitforwindows.org/), or [MSYS2](https://www.msys2.org/). This `README` assumes the usage of such a CLI (Cygwin).

## Package manager
Installing and updating dependencies is done easiest and most efficiently using a command-line package manager.

Common native command-line package managers for macOS are [Homebrew](https://brew.sh/), [MacPorts](https://www.macports.org/), or [Anaconda](https://www.anaconda.com/)'s `conda`. In this `README`, Homebrew is used. 

Native command-line package managers for Windows, such as [Chocolatey](https://chocolatey.org/) or [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/), cannot be run from a Unix-emulating CLI -- so on Windows, you are restricted to the built-in package manager of your Unix-emulating CLI. Git Bash and MSYS2, for example, provide access to `pacman`, and Cygwin uses its own [`setup`](https://www.cygwin.com/install.html) tool, a package manager that is run independently of the CLI.

## External software dependencies
The current version of `abtab` requires Bash, GNU `getopt`, Python, Java, and `music21` to be installed on your system. Before proceeding to [Installing `abtab`](#installing-abtab), you must make sure that you have the mimimum required version of each of these installed. For detailed instructions on how to do that, see [Installing external software dependencies](#installing-external-software-dependencies).  

# Installing `abtab`
1. Create, on a path of choice on your computer, a directory called `abtab/`. The path up to and including this directory is referred to as `<root_path>`, and the directory itself is where you will be working from.

2. `cd` into `<root_path>` and clone the `abtab` GitHub repository into it (note the dot at the end of the `clone` command!).
    ```
    $ cd <root_path>
    $ git clone https://github.com/reinierdevalk/abtab.git .
    ```

3. Open `config.cfg` and adapt the paths. Always use Unix-style forward slashes (`/`) as separators.
   - Replace the default value of the `ROOT_PATH` variable with `<root_path>`; **make sure it ends with a `/`**. 
   - Replace the default value of the `LIB_PATH` variable with `<lib_path>`; **make sure it ends with a `/`**. `<lib_path>` is the location where the installer places the code. Recommended locations are
     - On Windows: `C:/Users/<Username>/lib/abtab/` . 
     - On Unix: `/usr/local/lib/abtab/`.
   - Replace the default value of the `EXE_PATH` variable with `<exe_path>`; **make sure it ends with a `/`**. `<exe_path>` is the location where the installer places the executable. Recommended locations are 
     - On Windows: `C:/Users/<Username>/bin/`.
     - On Unix: `/usr/local/bin/`.
    
    If the recommended `<lib_path>` and `<exe_path>` do not exist on your computer, you can still use them -- the directories will be created by the installer.

    To ensure that `abtab` is available in the CLI, confirm that `<exe_path>` is on the system `PATH` by running 

    ```
    $ echo $PATH
    ```

    If it is not, you must add it -- see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH).

    **Note for Windows users** On Windows, `<exe_path>` must be aptly formatted, i.e., it must be adapted to the Unix-style format that the CLI understands (see also [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH), **Note for Windows users**).

4. Run the installer, `install.sh`, from `<root_path>`.
    ```
    $ ./install
    ```

   If you encounter execute permission issues when running the script, see [Execute permission issues](#execute-permission-issues).  
    
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

# Troubleshooting
## Execute permission issues
If you encounter execute permission issues when running a script, ensure that Git tracks file permissions by running

    $ git config --global core.fileMode true

This is a one-time configuration that makes Git preserve file permissions across `clone`s and `pull`s. If you have already set this up, you do not need to do it again.

If the above command does not resolve the issues, you can manually set execute permissions for all scripts (`install.sh`, `classpath.sh`, and `abtab`) by running

    $ chmod +x install.sh classpath.sh abtab

Note that you may need to run this command after each `git pull` or `git clone` if the execute permissions are not preserved.

## Adding an installation path to the system `PATH`
To check whether an installation path is on the system `PATH`, run

    $ echo $PATH

If the installation path is not on the `PATH`, you can it them by adding it to the `.bash_profile` file. `.bash_profile` is usually located in your `HOME` directory (`~/`); you can check this by running

    $ cd ~/
    $ ls -a

If the file does not appear in the items listed, you must create it.

    $ touch ~/.bash_profile

Then, add the missing installation path to `.bash_profile` by opening it with your editor of choice, and then adding the following line to it (replacing `<installation_path>` with your actual installation path).

    export PATH="<installation_path>:$PATH"

Finally, save `.bash_profile` and `source` it to apply the changes. Alternatively, you can simply close and reopen the CLI terminal. (Sometimes, both actions are needed.)

    $ source ~/.bash_profile

If the `source` command results in one or more errors similar to `-bash: $'\r': command not found`, `.bash_profile` contains Windows-style CRLF line endings (`\r\n`) that must be replaced by Unix-style LF line endings (`\n`). Retry after running

    $ sed -i 's/\r//' ~/.bash_profile

Check if the path has been added to the system `PATH`.

    $ echo $PATH

**Note for Windows users** On Windows, the installation paths that are on the system `PATH` must be in the Unix-style format that the CLI understands. Cygwin, for example, uses the prefix `/cygdrive/c/` to replace the `C:/` in the Windows path -- meaning that every `C:/...` path becomes `/cygdrive/c/...`.

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

# Installing external software dependencies
## Bash
### 1. Verifying installation
The current version of `abtab` requires Bash 4.2 or higher. To verify whether Bash is installed and meets the minimum required version, run

    $ bash --version

You should see output similar to

    GNU bash, version x.y.z ...

### 2. Installing and updating
#### macOS
To install or update Bash, run  

    $ brew install bash

#### Windows
To install or update Bash, run the Cygwin `setup` tool.

### 3. Locating the installation path
`abtab` assumes the default installation path for Bash, i.e., `/usr/local/bin/bash` (macOS) or `/usr/bin/` (Windows). To confirm the installation path, run

    $ which bash

If this returns `/usr/local/bin/bash` (macOS) or `/usr/bin/bash` (Windows), Bash is correctly installed. If it returns `/opt/homebrew/bin/bash` (macOS), Bash is correctly installed, but you must create a symlink from `/opt/homebrew/bin/bash` to `/usr/local/bin/bash` by running

    $ sudo ln -s /opt/homebrew/bin/bash /usr/local/bin/bash

If it returns some other path (this is unlikely), you must re-install Bash, ensuring the appropriate installation path.

### 4. Adding the installation path to the system `PATH`
To ensure that Bash is available in the CLI, confirm that the installation path is on the system `PATH` by running

    $ echo $PATH

If it is not, you must add it -- see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH).

**Verify that Bash is now installed correctly by repeating Step 1 above.**

## GNU `getopt`
### 1. Verifying installation
The current version of `abtab` requires GNU `getopt` 2.40.2 or higher. To verify whether GNU `getopt` is installed and meets the minimum required version, run (macOS)

    $ /usr/local/opt/gnu-getopt/bin/getopt --version

or 

    $ /opt/homebrew/opt/gnu-getopt/bin/getopt --version

or (Windows)

    $ getopt --version

You should see output similar to

    getopt from util-linux x.y.z

### 2. Installing and updating
#### macOS
To install or update GNU `getopt`, run

    $ brew install gnu-getopt

#### Windows
To install or update GNU `getopt`, run the Cygwin `setup` tool.

### 3. Locating the installation path
`abtab` assumes the default installation path for GNU `getopt`, i.e., `/usr/local/opt/gnu-getopt/bin/` or `/opt/homebrew/opt/gnu-getopt/bin/` (macOS), or `/usr/bin/` (Windows). To confirm the installation path, run (macOS)

    $ which /usr/local/opt/gnu-getopt/bin/getopt

or 

    $ which /opt/homebrew/opt/gnu-getopt/bin/getopt

or (Windows)

    $ which getopt

If this returns `/usr/local/opt/gnu-getopt/bin/getopt` or `/opt/homebrew/opt/gnu-getopt/bin/getopt` (macOS), or `/usr/bin/getopt` (Windows), GNU `getopt` is correctly installed. If it returns some other path (this is unlikely), you must re-install GNU `getopt`, ensuring the appropriate installation path.

### 4. Adding the installation path to the system `PATH`
#### macOS
macOS comes with its own default version of `getopt`, BSD `getopt`. If GNU `getopt` is made the default `getopt` by adding it to the `PATH`, scripts that rely on BSD `getopt` may not work anymore on your machine. It is therefore recommended not to do this.

Instead, `abtab` has a built-in check that selects the `getopt` version based on the operating system that it detects -- ensuring that on macOS, the default BSD `getopt` is bypassed in favour of GNU `getopt`.

#### Windows
To ensure that GNU `getopt` is available in the CLI, confirm that the installation path is on the system `PATH` by running

    $ echo $PATH

If it is not, you must add it -- see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH).

**Verify that GNU `getopt` is now installed correctly by repeating Step 1 above.**

## Python
### 1. Verifying installation
The current version of `abtab` requires Python 3.12.0 or higher. To verify whether Python is installed and meets the minimum required version, run

    $ python --version

You should see output similar to

    Python x.y.z

**Note for macOS users** On older versions of macOS, the default installed version of Python is Python2. If the `python --version` command returns some version of Python2, you must use `python3` (and not `python`) in your commands.

### 2. Installing and updating
#### macOS
To install or update Python, run

    $ brew install python

To install or update to a specific version rather than the latest, add `@x.y.z` -- e.g., `python@3.12.0`.

#### Windows
To install or update Python, run the Cygwin `setup` tool.

**Note** Installing and updating Python can be done using a command-line package manager, but it generally not a bad idea to download and install [Python](https://www.python.org/downloads/) manually.

### 3. Locating the installation path
#### macOS, using Homebrew
Homebrew installs Python in `/usr/local/opt/`. To confirm the installation path, run

    $ brew --prefix python

Homebrew automatically adds a symlink to the Python executable in `/usr/local/bin/`. `/usr/local/bin/` is the installation path to be added to the system `PATH`.

#### macOS, other cases
If Python is installed through another package manager or manually, its installation path can vary. Common Python installation paths are `/Library/Frameworks/Python.framework/Versions/<version>/bin/`, `/usr/local/bin/`, or `/usr/bin/`. To locate the installation path, run

    $ which python

If this does not work, or the executable is not symlinked, you can check the typical installation paths as mentioned above manually, or you can use the `find` or `locate` commands.

#### Windows, using Cygwin
Cygwin installs Python in its own installation directory, `C:/cygwin64/bin/` or `C:/cygwin/bin/`. To confirm the installation path, run

    $ which python

#### Windows, other cases
If Python is installed through another package manager or manually, its installation path can vary. Common Python installation paths are `C:/Python<version>/`, or `C:/Users/<Username>/AppData/Local/Programs/Python/Python<version>/`. To locate the installation path, run

    $ which python

If this does not work, or the executable is not symlinked, you can check the typical installation paths as mentioned above manually, or you can use the `find` or `locate` commands.

### 4. Adding the installation path to the system `PATH`
To ensure that Python is available in the CLI, confirm that the installation path is on the system `PATH` by running 

    $ echo $PATH

If it is not, you must add it -- see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH).

**Verify that Python is now installed correctly by repeating Step 1 above.**

## Java
### 1. Verifying installation
The current version of `abtab` requires Java 11.0.1 or higher. To verify whether Java is installed and meets the minimum required version, run

    $ java -version

You should see output similar to (macOS)

    openjdk version "x.y.z" ...

or (Windows)

    java version "x.y.z" ...

### 2. Installing and updating
#### macOS
To install or update Java, run

    $ brew install openjdk
    $ brew link --force openjdk

In case the `brew link` command returns a message that it was not successful, you can ignore it -- this case is dealt with below.

To install or update to a specific version rather than the latest, add `@x.y.z` -- e.g., `openjdk@11.0.1`.

#### Windows
To install or update Java, run the Cygwin `setup` tool.

**Note** Installing and updating Java can be done using a command-line package manager, but it generally not a bad idea to download and install [Java](https://www.oracle.com/java/technologies/downloads/) manually.

### 3. Locating the installation path
#### macOS, using Homebrew
Homebrew installs Java in `/usr/local/opt/`. To confirm the installation path, run

    $ brew --prefix openjdk

Homebrew does not automatically add a symlink to the Java executable in `/usr/local/bin/`; that is why the additional `brew link` command (see above) is needed. `/usr/local/bin/` is the installation path to be added to the system `PATH`.

**Note** In case the `brew link` command returns a message that it was not successful, no symlink has been created -- in which case `/usr/local/opt/` is the installation path to be added to the system `PATH`.  

#### macOS, other cases
If Java is installed through another package manager or manually, its installation path can vary. Common Java installation paths are `/Library/Java/JavaVirtualMachines/` or `/usr/local/opt/`. To locate the installation path, run

    $ which java

If this does not work, or the executable is not symlinked, you can check the typical installation paths as mentioned above manually, or you can use the `find` or `locate` commands.

#### Windows, using Cygwin
Cygwin installs Java in its own installation directory, `C:/cygwin64/bin/` or `C:/cygwin/bin/`. To confirm the installation path, run

    $ which java

#### Windows, other cases
If Java is installed through another package manager or manually, its installation path can vary. A common Java installation path is `C:/Program Files/Java/jdk-<version>/bin/`. To locate the installation path, run

    $ which java

If this does not work, or the executable is not symlinked, you can check the typical installation path as mentioned above manually, or you can use the `find` or `locate` commands.

### 4. Adding the installation path to the system `PATH`
To ensure that Java is available in the CLI, confirm that the installation path is on the system `PATH` by running 

    $ echo $PATH

If it is not, you must add it -- see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH).

**Verify that Java is now installed correctly by repeating Step 1 above.**

## `music21`
### 1. Verifying installation
The current version of `abtab` requires `music21` 9.1.0 or higher. To verify whether `music21` is installed and meets the minimum required version, run

    $ python -c "import music21; print(music21.__version__)"

You should see output similar to

    9.1.0

If you have installed `music21` inside a virtual environment, you must activate it prior to running the above command (see [Using a virtual environment](#using-a-virtual-environment)).

**Note for macOS users** On older versions of macOS, the default installed version of Python is Python2. If the `python --version` command returns some version of Python2, you must use `python3` (and not `python`) in your commands.

### 2. Installing and updating
To install or update `music21`, run

    $ pip install --upgrade music21

**Note for macOS users** On older versions of macOS, the default installed version of Python is Python2. If the `python --version` command returns some version of Python2, you must use `pip3` (and not `pip`) in your commands.

#### Using a virtual environment
If you want to keep your `music21` installation separate from other installations, you can install it inside a virtual environment, using the same command as above. The virtual environment must first be created and activated. To create the virtual environment, run

    $ python -m venv ~/myenv

To activate the virtual environment, run

    $ source ~/myenv/bin/activate

You need to *create* the virtual environment (and install `music21` inside it) only once, but because `music21` will only be available inside the virtual environment, you will need to make sure that it is *activated* every time you run `abtab`. You can see that the virtual environment is activated when your CLI terminal prompt has changed to something similar to `(myenv)`.   

To deactivate the virtual environment, run

    $ deactivate       

When using a virtual environment, you can skip Steps 3 and 4 below.

### 3. Locating the installation path
`pip` installs Python packages such as `music21` in the Python installation path (see [Python](#python)). To confirm the installation path, run

    $ python -c "import music21; print(music21.__file__)"

### 4. Adding the installation path to the system `PATH`
To ensure that `music21` is available in the CLI, confirm that the installation path is on the system `PATH` by running

    $ echo $PATH

If it is not, you must add it -- see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH).

**Verify that `music21` is now installed correctly by repeating Step 1 above.**