1. Create, on a path of choice on your computer a directory called `abtab`. The path up to and including this directory is the `<root_path>`, and it will hold the input files read and output files created by `abtab`.
   (rdv: in dev mode, this is F:/research/computation/)

2. Open `config.cfg` and
   - Replace the default value of the `ROOT_PATH` variable with the `<root_path>`.
   - Replace the default value of the `LIB_PATH` variable with the `<lib_path>`, i.e., the location where the installer should place the code. Suggested locations are
     - On Windows: `C:/Users/<Name>/lib/abtab/`   
     - On Unix: `/usr/local/lib/abtab/`
   Use Unix-style (forward) slashes as separators in both cases. 
   - Replace the default value of the `EXE_PATH` variable with the `<exe_path>`, i.e., the location where the installer should place the executable. Suggested locations are 
     - On Windows: `C:/Users/<Name>/bin/`
     - On Unix: `/usr/local/bin/`
   Again, use Unix-style (forward) slashes as separators in both cases.

   The installer will create any of these paths if they do not yet exist; it will also add the `<exe_path>` to the `$PATH` variable if it is not on it yet.     

   You can check which paths are on the `$PATH` variable as follows:

      $ echo $PATH

3. `cd` into the `<code_path>` directory

       $ cd <root_path>/<code_path>/

4. Run the installation script, `install.sh`:

       $ bash install.sh

   This script will 
   - Clone the necessary code repositories from GitHub.
   - Create the necessary directory structure in `<root_path>`.
   - Install the command line tool `abtab` on your computer. 


1. Clone the following repositories into the `<code_path>` directory:
   - https://github.com/reinierdevalk/formats/
   - https://github.com/reinierdevalk/machine_learning/
   - https://github.com/reinierdevalk/melody_models/
   - https://github.com/reinierdevalk/representations/
   - https://github.com/reinierdevalk/tabmapper/
   - https://github.com/reinierdevalk/utils/
   - https://github.com/reinierdevalk/voice_separation/
  




5. Run `abtab`. This can be done from any directory on your computer.
   `abtab` takes ...


 

 
5. When running TabMapper for the first time, the folder tabmapper/data/ and 
   its subfolders are created. Any of the folders in this folder structure are 
   recreated whenever they have been deleted and TabMapper is run again. 
   tabmapper/data/in/tab/	holds the tablature input files
   tabmapper/data/in/MIDI/	holds the MIDI input files (vocal models)
   tabmapper/data/out/		holds the output files


boolean

path to code = 	code_path/				F:/research/software/code/eclipse/
contains	code_path/tabmapper
		code_path/utils
		code_path/format-representations

path to data = 	data_path/
contains	data_path/in/tab/
		data_path/in/MIDI/
		data_path/out/ 




java -cp '.;../../utils/bin;../../utils/lib/*;../../formats-representations/bin;../../formats-representations/lib/*' tabmapper.TabMapper

does the same as

java -cp $(for p in ../../* ; do echo -n $p"/bin"";"$p"/lib/*"";" ; done) tabmapper.TabMapper

this works from any folder

java -cp $(for p in F:/research/software/code/eclipse/* ; do echo -n $p"/bin"";"$p"/lib/*"";" ; done) tabmapper.TabMapper

i.e., 

java -cp $(for p in <code_path>* ; do echo -n $p"/bin"";"$p"/lib/*"";" ; done) tabmapper.TabMapper

java -cp '.;F:/research/software/code/eclipse/utils/bin;F:/research/software/code/eclipse/utils/lib/*;F:/research/software/code/eclipse/formats-representations/bin;F:/research/software/code/eclipse/lib/*;F:/research/software/code/eclipse/tabmapper/bin' tabmapper.TabMapper



============

java -cp $(for p in F:/research/software/code/eclipse/* ; do echo -n $p"/bin"";"$p"/lib/*"";" ; done) ui.UI N-bwd-thesis-int-4vv . '' '' user/in/4465_33-34_memor_esto-2.tbp '-k=-2|-m=0'
java -cp $(for p in ../../* ; do echo -n $p"/bin"";"$p"/lib/*"";" ; done) ui.UI N-bwd-thesis-int-4vv . '' '' user/in/4465_33-34_memor_esto-2.tbp '-k=-2|-m=0'