# eBash 2

### Easier Bash functions

# This project is no longer maintained. Please use Zlang instead.

## WARNING: Linux and ZSH users
eBash 2 is originally designed for bash on macOS. This branch (zsh-compatible) is currently experimental and may not run as fluently as bash on macOS using the one from master branch.


#### Overview

eBash 2 is a successor of eBash, with better readability and naming conventions. eBash is meant to make Bash easier for people who are new or who are maintaining programs written in Bash. Number of functions increased tremendously, so a simple scripting could be done with the functions from eBash 2.


#### Installation
#### DO NOT CLOSE THE TERMINAL! READ THE WARNING BELOW
```bash 
curl -Ls "https://raw.githubusercontent.com/410-dev/eBash2/main/installer.bash" -o "/tmp/installer.bash"; chmod +x /tmp/installer.bash; /bin/bash /tmp/installer.bash latest
```

## WARNING: IF YOU ARE USING ZSH-COMPATIBLE, READ THIS!

The installer may have installed non-compatible version of eBash2, and may cause error on terminal launch. Please follow the steps below to fix it.

1. Download the current repository as zip file, and unpack it.
2. Open /usr/local/eBash2 with Nautilus (Gnome) or Finder (macOS).
3. Overwrite 'eblinker' file, 'base', 'lib' directories in /usr/local/eBash2 with the compatible version which is in current repository. If you are using zsh, please continue the instruction below. If you are running bash on linux, you may stop here.
4. Open Terminal.
5. Open ~/.zshrc with any text editor you want.
6. Append the following code.
```bash
export EBHOME="/usr/local/eBash2"
if [[ -f "/usr/local/eBash2/eblinker" ]]; then source /usr/local/eBash2/eblinker; fi
```
7. Restart terminal
8. Enjoy!

If you are writing code, you MUST prepend this code to the script file in order to fully load eBash2 library.
```bash
source $EBHOME/eblinker $EBHOME
```


<br>
<br>

#### Temproary Installation

~~Some programs may require eBash 2 temporarily. Developers may use temporary installation for such case.~~

```bash 
```
This feature is not supported in zsh-compatible eBash.


#### Examples

The following code is the example of eBash 2. This code will automatically package the source code as a zip file for release tab.

```bash
#!/bin/bash

source $EBHOME/eblinker $EBHOME
@import Foundation
@import File
@script

input "Version: " buildVersion

println "Compressing: ${buildVersion}"

println "Copying source directory..."

WORKSPACE="/Volumes/Codespace"

File.createDirectory "${WORKSPACE}/buildtmp"
File.copyDirectory "${WORKSPACE}/eBash2/" "${WORKSPACE}/buildtmp"
File.removeDirectory "${WORKSPACE}/buildtmp/builds"
File.removeFile "${WORKSPACE}/buildtmp/latest"
File.removeFile "${WORKSPACE}/buildtmp/installer.bash"

File.compress "${WORKSPACE}/buildtmp"
File.relocate "${WORKSPACE}/buildtmp.zip" "${WORKSPACE}/eBash2/builds/eBash2-${buildVersion}.zip"
File.removeDirectory "${WORKSPACE}/buildtmp"
println "Done!"

@nscript

```


#### Native Translator (WIP)

Since the mechanism of eBash2 runtime is not as efficient as the native bash script, an eBash2 to native bash translator using Java is currently under development.
It dramatically increases the script size for sure, but is uncertain about the performance.

[Check it out from here.](https://github.com/410-dev/eBash2-translator)

