these files will make visual code very similar to CODE::BLOCKS

external terminal windows that shows the output similar to CODE::BLOCKS

only  builds the file again if it was edited

**1** Place these files inside .vscode file 


**2** change the default terminal to powershell


**3** change the default  execuator of code runner to

"cpp": "powershell -NoLogo -File C:\\Users\\super\\Documents\\CPP\\.vscode\\build_and_run.ps1 $fullFileName $fileNameWithoutExt.exe",

**change the  specified path to your path**

**change the specified path of run_time.ps1 inside build_and_run.ps1 to your path**

**run code with ctrl+alt+n**
