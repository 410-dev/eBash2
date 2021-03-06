# eBash 2

### Easier Bash functions



#### Overview

eBash 2 is a successor of eBash, with better readability and naming conventions. eBash is meant to make Bash easier for people who are new or who are maintaining programs written in Bash. Number of functions increased tremendously, so a simple scripting could be done with the functions from eBash 2.


#### Installation

```bash 
curl -Ls "https://raw.githubusercontent.com/410-dev/eBash2/main/installer.bash" -o "/tmp/installer.bash"; chmod +x /tmp/installer.bash; /bin/bash /tmp/installer.bash latest
```


#### Temproary Installation

Some programs may require eBash 2 temporarily. Developers may use temporary installation for such case.

```bash 
export EBHOME="/tmp/eBash2"
curl -Ls "https://raw.githubusercontent.com/410-dev/eBash2/main/installer.bash" -o "/tmp/installer.bash"
chmod +x /tmp/installer.bash
/bin/bash /tmp/installer.bash latest "$EBHOME"
source "$EBHOME/eblinker"
```



#### Examples

The following code is the example of eBash 2. This code will automatically package the source code as a zip file for release tab.

```bash
#!/bin/bash

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

