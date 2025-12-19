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
The current version of `abtab` requires Bash, GNU `getopt`, Python, and Java to be installed on your system. Before proceeding to [Installing `abtab`](#installing-abtab), complete [Appendix I: Installing external software dependencies](#appendix-i-installing-external-software-dependencies) to make sure that you have the mimimum required version of each of these installed. Once you have completed Appendix I, return here by following the link at the end of it.  

>:warning: **Note** Project-specific Python packages (such as `music21`) are not installed system-wide, but in a virtual environment; this is covered in [Installing `abtab`](#installing-abtab). 

# Installing `abtab`
1. Create, on a path of choice on your computer, a directory called `abtab/`. The path up to and including this directory is referred to as `<root_path>`, and the directory itself is where you will be working from.

2. `cd` into `<root_path>` and clone the `abtab` GitHub repository into it (note the dot at the end of the `clone` command!).
    ```
    $ cd <root_path>
    $ git clone https://github.com/reinierdevalk/abtab.git .
    ```

   >:warning: **Note** Make sure not to `cd` out of `<root_path>` during the installation process.

   If you do not have `git` installed, you can simply download the repository manually by clicking the drop-down arrow on the green 'Code' button at the top of this page, and then clicking 'Download ZIP'.

3. Open `lib/config.cfg` and adapt the paths.

   >:warning: **Note** On Windows, all paths must be Windows-style absolute paths **starting with an uppercase drive letter and using Unix-style forward slashes (`/`)**; on macOS, all paths must be POSIX-style absolute paths **starting with a forward slash** (see examples below). Always make sure that a path **ends with a forward slash**.

   - Replace the default value of the `ROOT_PATH` variable with `<root_path>`; **make sure it ends with a `/`**. 
   - Replace the default value of the `LIB_PATH` variable with `<lib_path>`; **make sure it ends with a `/`**. `<lib_path>` is the location where the installation script places the code. Recommended locations are
     - On Windows: `C:/Users/<Username>/lib/abtab/` . 
     - On Unix: `/Users/<Username>/.local/lib/abtab/`.
   - Replace the default value of the `EXE_PATH` variable with `<exe_path>`; **make sure it ends with a `/`**. `<exe_path>` is the location where the installation script places the executable. Recommended locations are 
     - On Windows: `C:/Users/<Username>/bin/`.
     - On Unix: `/Users/<Username>/.local/bin/`.
    
   If the recommended `<lib_path>` and `<exe_path>` do not exist on your computer, you can still use them -- the missing directories will be created by the installation script.

   >:warning: **Note** If you prefer to package everything together and locate `lib_path` and `exe_path` on `root_path`, you must **avoid making the `lib/` and `bin/` directories direct children of `<root_path>`** (e.g., `<root_path>/lib/abtab/` or `<root_path>/bin/`), as this causes problems during installation. Instead, use a wrapper directory, and place the `lib/` and `bin/` directories inside it (e.g., `<root_path>/user/lib/abtab/` and `<root_path>/user/bin/`).  

   >:warning: **Note for macOS users** If your GNU `getopt` installation path deviates from its typical installation paths (see [GNU `getopt`](#gnu-getopt)), replace the default value of the `GETOPT_PATH` variable with the path that you noted down; **make sure it ends with a `/`**.

   To ensure that `abtab` is available in the CLI, confirm that `<exe_path>` is on the system `PATH` by running 

    ```
    $ echo $PATH
    ```

   If it is not, you must add it (see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH)).

<!--
   >:warning: **Note for Windows users** On Windows, `<exe_path>` must be aptly formatted, i.e., it must be adapted to the Unix-style format that the CLI understands (see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH), Note for Windows users).
-->

4. Run the installation script, `scripts/install`, from `<root_path>`.
    ```
    $ ./scripts/install
    ```

   If you encounter execute permission issues when running the script, see [Execute permission issues](#execute-permission-issues).

   >:warning: **Note for Windows users** If the installation process exits with an error like `Python was not found; run without arguments to install from the Microsoft Store, or disable this shortcut` Windows is trying to use a Microsoft Store 'app execution alias' for Python that is misconfigured. To disable this alias, see [Disabling the Microsoft Store Python alias](#disabling-the-microsoft-store-python-alias).

   The installation script 
   - Checks whether `lib_path` and `exe_path` exist. If not, creates them; if so, it handles any previously installed version of `abtab`: clears `<lib_path>` and removes any old `abtab` executable from `<exe_path>`.
   - Sets `<root_path>` and `<lib_path>` in the `abtab` executable. 
   - Creates, in `<root_path>`, the `examples/` directory.
   - Creates, in `<root_path>`, the `data/` directory structure.<!--, and moves the example files in the `examples/` directory into the appropriate `data/<tool>/` subdirectories.-->
   - Clones the required repositories from `https://github.com/reinierdevalk/`. These include
       - Code repositories, as listed in `lib/repositories.txt` (before the empty line); these are cloned into `<lib_path>`'s `lib/` directory.
       - Non-code repositories, as listed in `lib/repositories.txt` (after the empty line); these are cloned into `<root_path>`. 
   - Creates, in `<lib_path>`'s `lib/` directory, a virtual environment, and installs project-specific Python packages in it. By using a virtual environment, project-specific Python package installations are isolated from system-wide installations, ensuring a clean and conflict-free environment.
   - Installs `abtab`: moves the executable in `bin/` to `<exe_path>`; moves all files in the `lib/` directory to `<lib_path>` and its `lib/` directory; moves the `docs/` and  `scripts/` directories to `<lib_path>`, and cleans up `<root_path>`.

   When the installation process has finished, `<root_path>` contains
   - The `data/` directory. Contains, for each tool, the directories from which the input files are read (`in/`) and to which the output files are stored (`out/`). After initial installation, these directories are empty.<!--Apart from the example files moved into them during the installation process, these directories are empty.--> NB: the `converter` tool does not have the `in/` and `out/` subdirectories.  
   - The `examples/` directory. Contains default example files that you can use to try out the different tools. You can freely modify the contents of this directory, or even delete it.
   - The `models/` directory. Contains the trained machine learning models called by the `transcriber` tool. **This directory is read-only; do not modify its contents.**
   - The `templates/` directory. Contains a high-level template of an MEI file; whose `<header>` can be customised freely. 

<!--
5. It is recommended to use a virtual environment to isolate project-specific Python package installations from system-wide
   installations, ensuring a clean and conflict-free environment. It is good practice to have the virtual environment for a specific project inside the project's directory -- i.e., here, inside `<root_path>`. 

   To create the virtual environment (by convention called `venv` or `.venv`), run
    ```
    $ cd <root_path>
    $ python3 -m venv venv
    ```
 
   This creates a fourth directory, called `venv`, in `<root_dir>`. 

   To activate the virtual environment, run (macOS)
    ```
    $ source <root_path>/venv/bin/activate
    ```

   or (Windows)
    ```
    $ source <root_path>/venv/Scripts/activate
    ```

   You can see that the virtual environment is activated when your CLI terminal prompt has changed to something similar to `(venv)`. 

   Once the virtual environment is activated, complete [Appendix II: Installing project-specific Python packages in the virtual environment](#appendix-ii-installing-project-specific-Python-packages-in-the-virtual-environment) to install all project-specific Python packages in it. Once you have completed Appendix II, return here by following the link at the end of it.

   To deactivate the virtual environment, run
    ```
    $ deactivate 
    ```
-->

`abtab` is now installed and ready to use. It can be run from any directory on your computer.

Use the help (`-h` or `--help`) option to get started; among other things, this lists the currently available tools in the toolbox.
 
    $ abtab -h 
    $ abtab --help 

For examples of how to use the different tools, see [Example usage](#example-usage).

# Updating `abtab`
Use the update (`-u` or `--update`) option to update `abtab` to the latest available version.

    $ abtab -u 
    $ abtab --update 

When updating, all user data in `<root_path>` is retained. The `data/` directory and its entire contents are left untouched, and while the default template file for the latest version is added to the `templates/` directory (the file may have changed), the existing pre-update template file is kept with the suffix `-pre-x.y.z` added to its name. If you did not customise the default template file, you can safely delete this backup file. If you did, and you want to keep using your customisation, you must transfer the backup file's contents to the newly added default template file -- accounting for any changes to the latter -- before deleting the backup file. Similarly, the default example files for the latest version are added to the `examples/` directory (the files may have changed), and any existing pre-update example files are kept with the aforementioned suffix added to their names. In case you have added your own files to the `examples/` directory, these are left untouched.

>:warning: **Note** If you have added any other content to `<root_path>` manually, this will also be left untouched.

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

# Appendix I: Installing external software dependencies
## Bash
### 1. Verifying installation
The current version of `abtab` requires Bash 4.3 or higher. To verify whether Bash is installed and meets the minimum required version, run

    $ bash --version

You should see output similar to

    GNU bash, version x.y.z ...

If the output shows a version that is too old, or an error like `bash: command not found`, indicating that Bash is not installed, proceed to Steps 2 and 3.

### 2. Installing and updating
>:warning: **Note** Keep track of the installation path during installation, as you may need it in Step 3.

#### macOS
To install or update Bash, run

    $ brew install bash

#### Windows
To install or update Bash, run the Cygwin `setup` tool.

### 3. Confirming installation
Once Bash is installed, repeat Step 1. If the output does not show the version you just installed, you must add the installation path to the system `PATH` (preferred; see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH)) or create a symlink to the executable (alternative option; see [Creating a symlink](#creating-a-symlink)).

## GNU `getopt`
### 1. Verifying installation
>:warning: **Note for macOS users** macOS comes with its own default variant of `getopt`, BSD `getopt` (`/usr/bin/getopt`), which will be called when using the `getopt` command. To call GNU `getopt`, you need to use an extended command that includes the prefix (`<gnu-getopt-prefix>/`) to the GNU `getopt` installation directory (`bin/`): `<gnu-getopt-prefix>/bin/getopt`. To find this prefix, run 

    $ brew --prefix gnu-getopt

<!--If the output shows an error like `Error: No available formula with the name "gnu-getopt"`, indicating that GNU `getopt` is not installed, proceed to Steps 2 and 3.--> 
>In the unlikely case where the output is a path that is neither `/opt/homebrew/opt/gnu-getopt/` nor `/usr/local/opt/gnu-getopt/` (the typical GNU `getopt` installation directory prefixes), you must note it down -- you will need it again during the installation of `abtab`.

The current version of `abtab` requires GNU `getopt` 2.35.2 or higher. To verify whether GNU `getopt` is installed and meets the minimum required version, run (macOS)

    $ <gnu-getopt-prefix>/bin/getopt --version

or directly 

    $ $(brew --prefix gnu-getopt)/bin/getopt --version

or (Windows)

    $ getopt --version

You should see output similar to

    getopt from util-linux x.y.z

If the output shows a version that is too old, or an error like `bash: getopt: command not found`, indicating that GNU `getopt` is not installed, proceed to Steps 2 and 3.

### 2. Installing and updating
>:warning: **Note for Windows users** Keep track of the installation path during installation, as you may need it in Step 3.

#### macOS
To install or update GNU `getopt`, run

    $ brew install gnu-getopt

#### Windows
To install or update GNU `getopt`, run the Cygwin `setup` tool.

### 3. Confirming installation
Once GNU `getopt` is installed, repeat Step 1. **On Windows**, if the output does not show the version you just installed, you must add the installation path to the system `PATH` (preferred; see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH)) or create a symlink to the executable (alternative option; see [Creating a symlink](#creating-a-symlink)). **On macOS**, it is recommended not to do this: if GNU `getopt` is made the default `getopt` by adding it to the system `PATH`, scripts that depend on BSD `getopt` may not work anymore on your computer. `abtab` has a built-in mechanism that calls the `getopt` variant based on the operating system that it detects, and that ensures that on macOS, the default BSD `getopt` is bypassed in favour of GNU `getopt` by using the extended command mentioned in Step 1.

## Python
### 1. Verifying installation
The current version of `abtab` requires Python 3.12.0 or higher. To verify whether Python is installed and meets the minimum required version, run

    $ python3 --version

You should see output similar to

    Python 3.x.y

If the output shows a version that is too old, or an error like `bash: python3: command not found`, indicating that Python is not installed, proceed to Steps 2 and 3. If you are on Windows, first read the note below.

>:warning: **Note for Windows users** If the command `python3 --version` returns a `command not found` error, try running `python --version` instead. If you see the expected output (`Python3.x.y`), Python3 has been installed, but no symlink to it has been created. You can either just use `python` (and not `python3`) in your commands, or create a symlink. To create the symlink, run

    $ ln -s $(which python) /usr/bin/python3

### 2. Installing and updating
>:warning: **Note** Keep track of the installation path during installation, as you may need it in Step 3.

#### macOS
To install or update Python, run

    $ brew install python

To install or update to a specific version rather than the latest, add `@x.y.z` -- e.g., `python@3.12.0`.

#### Windows
To install or update Python, download and install [Python](https://www.python.org/downloads/) manually.

>:warning: **Note** Installing and updating Python can be done using a command-line package manager, but to avoid compatibility issues and ensure better integration with Windows, manual installation is preferred.

### 3. Confirming installation
Once Python is installed, repeat Step 1. If the output does not show the version you just installed, you must add the installation path to the system `PATH` (preferred; see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH)) or create a symlink to the executable (alternative option; see [Creating a symlink](#creating-a-symlink)).

## Java
### 1. Verifying installation
The current version of `abtab` requires Java 11.0.1 or higher. To verify whether Java is installed and meets the minimum required version, run

    $ java --version

You should see output similar to (macOS)

    openjdk x.y.z yyyy-mm-dd

or (Windows)

    java x.y.z yyyy-mm-dd ...

If the output shows a version that is too old, or an error like `bash: java: command not found`, indicating that Java is not installed, proceed to Steps 2 and 3.

### 2. Installing and updating
>:warning: **Note** Keep track of the installation path during installation, as you may need it in Step 3.

#### macOS
To install or update Java, run

    $ brew install openjdk

To install or update to a specific version rather than the latest, add `@x.y.z` -- e.g., `openjdk@11.0.1`.

#### Windows
To install or update Java, download and install [Java](https://www.oracle.com/java/technologies/downloads/) manually.

>:warning: **Note** Installing and updating Java can be done using a command-line package manager, but to avoid compatibility issues and ensure better integration with Windows, manual installation is preferred.

### 3. Confirming installation
Once Java is installed, repeat Step 1. If the output does not show the version you just installed, you must add the installation path to the system `PATH` (preferred; see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH)) or create a symlink to the executable (alternative option; see [Creating a symlink](#creating-a-symlink)).

[[Back to Dependencies]](#dependencies)

<!--
# Appendix II: Installing project-specific Python packages in the virtual environment
## `music21`
### 0. Activating the virtual environment
To activate the virtual environment, run (macOS)

    $ source <root_path>/venv/bin/activate

or (Windows)

    $ source <root_path>/venv/Scripts/activate

### 1. Verifying installation
The current version of `abtab` requires `music21` 9.1.0 or higher. To verify whether `music21` is installed in the virtual environment and meets the minimum required version, run

    $ python -c "import music21; print(music21.__version__)"

>:warning: **Note** Always use `python` (and not `python3`) in the command above. Inside a virtual environment, `python` always points to the environment's own Python interpreter, which only detects packages installed **inside that environment** (and not global or system packages).

You should see output similar to

    9.1.0

If the output shows a version that is too old, or an error like `ModuleNotFoundError: No module named 'music21'`, indicating that `music21` is not installed, proceed to Steps 2 and 3.

### 2. Installing and updating
To install or update `music21`, run

    $ pip install --upgrade music21

>:warning: **Note** Always use `pip` (and not `pip3`) in the command above -- see the note in Step 1. 

### 3. Confirming installation
Once `music21` is installed, repeat Step 1.

[[Back to Installing `abtab`]](#installing-abtab)
-->

# Appendix II: Troubleshooting
## Adding an installation path to the system `PATH`
To ensure that a software application is available system-wide in the CLI, you can add its installation path to the system `PATH`. To check whether an installation path is on the system `PATH`, run

    $ echo $PATH

If the installation path is not on the `PATH`, you can add it by adding it to the `.bash_profile` file. `.bash_profile` is usually located in your `HOME` directory (`~/`); you can check this by running

    $ cd ~/
    $ ls -a

>:warning: **Note for macOS users** If your default shell is `zsh` rather than `bash`, it is the `.zprofile` file, also located in your `HOME` directory, that must be adapted. In this case, replace `.bash_profile` with `.zprofile` in all commands below. You can check which shell you are using by running

    $ echo $SHELL 

If `.bash_profile` does not appear in the items listed under the `HOME` directory, you must create it.

    $ touch ~/.bash_profile

Then, add the missing installation path to `.bash_profile` by opening it and then adding the following line to it (replacing `<installation_path>` with your actual installation path).

    export PATH="<installation_path>:$PATH"

Finally, save `.bash_profile` and `source` it to apply the changes. Alternatively, you can simply close and reopen the CLI terminal. (Sometimes, both actions are needed.)

    $ source ~/.bash_profile

If the `source` command results in one or more errors similar to `-bash: $'\r': command not found`, `.bash_profile` contains Windows-style line endings. You must replace these before retrying (see [Replacing CRLF line endings](#replacing-CRLF-line-endings)).

Check if the path has been added to the system `PATH`.

    $ echo $PATH

>:warning: **Note for Windows users** On Windows, the installation paths added manually in shell startup files such as `.bash_profile` must be written in the Unix-style format that the CLI understands. <!--Cygwin, for example, uses the prefix `/cygdrive/c/` to replace the `C:/` in the Windows path -- meaning that every `C:/...` path becomes `/cygdrive/c/...`.--> In Cygwin, for example, the Windows drive `C:` is available under `/cygdrive/c/`, meaning that a Windows path like `C:/...` must be written as `/cygdrive/c/...`. Other CLIs may use a different prefix.

## Disabling the Microsoft Store Python alias 
To disable the Microsoft Store 'app execution alias' for Python, open **Settings**, go to **Apps** > **Advanced app settings** > **App execution aliases**, and turn off `python.exe` and `python3.exe`. After disabling the aliases, close and reopen the CLI terminal, so that the changes take effect.

For more information, see the [Windows documentation](https://learn.microsoft.com/en-us/windows/python/faqs#why-does-running-python-exe-open-the-microsoft-store-).

## Creating a symlink
As an alternative to adding an installation path to the system `PATH`, to ensure that a software application is available system-wide in the CLI, you can create a symbolic link (symlink) to its executable. To do so, identify the installation path of the executable (`<installation_path>`), as well as a path that is already on the system $PATH (`<PATH_path>`), and run

    $ ln -s <installation_path>/<executable> <PATH_path>/<executable>

## Execute permission issues
If you encounter execute permission issues when running a script, ensure that Git tracks file permissions by running

    $ git config --global core.fileMode true

This is a one-time configuration that makes Git preserve file permissions across `clone`s and `pull`s. If you have already set this up, you do not need to do it again.

If the above command does not resolve the issues, you can manually set execute permissions for all scripts (`install`, `classpath.sh`, and `abtab`) by running

    $ chmod +x install classpath.sh abtab

Note that you may need to run this command after each `git pull` or `git clone` if the execute permissions are not preserved.

## Replacing CRLF line endings
If `source`ing a file or running a Bash script returns one or more errors similar to `-bash: $'\r': command not found`, the file or script in question contains Windows-style CRLF line endings (`\r\n`) that must be replaced by Unix-style LF line endings (`\n`). To achieve this, run

    $ sed -i 's/\r//' <file>

<!-- OLD VERSION BASH
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
-->

<!-- OLD VERSION GETOPT
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
macOS comes with its own default version of `getopt`, BSD `getopt`. If GNU `getopt` is made the default `getopt` by adding it to the `PATH`, scripts that rely on BSD `getopt` may not work anymore on your computer. It is therefore recommended not to do this.

Instead, `abtab` has a built-in check that selects the `getopt` version based on the operating system that it detects -- ensuring that on macOS, the default BSD `getopt` is bypassed in favour of GNU `getopt`.

#### Windows
To ensure that GNU `getopt` is available in the CLI, confirm that the installation path is on the system `PATH` by running

    $ echo $PATH

If it is not, you must add it -- see [Adding an installation path to the system `PATH`](#adding-an-installation-path-to-the-system-PATH).

**Verify that GNU `getopt` is now installed correctly by repeating Step 1 above.**
-->

<!-- OLD VERSION PYTHON
## Python
### 1. Verifying installation
The current version of `abtab` requires Python 3.12.0 or higher. To verify whether Python is installed and meets the minimum required version, run

    $ python3 --version

You should see output similar to

    Python 3.x.y

**Note for Windows users** If the command `python3 --version` returns a `command not found error`, try running `python --version` instead. If you see the expected output (`Python3.x.y`), Python3 has been installed, but no symlink to it has been created. To create the symlink, run

    $ ln -s $(which python) /usr/bin/python3

Alternatively, you can just use `python` (and not `python3`) in your commands.

### 2. Installing and updating
#### macOS
To install or update Python, run

    $ brew install python

To install or update to a specific version rather than the latest, add `@x.y.z` -- e.g., `python@3.12.0`.

#### Windows
To install or update Python, run the Cygwin `setup` tool.

**Note** Installing and updating Python can be done using a command-line package manager, but it is generally not a bad idea to download and install [Python](https://www.python.org/downloads/) manually manually.

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
-->

<!-- OLD VERSION JAVA
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
--> 