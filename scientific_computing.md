[matlab](#matlab)

### Matlab

You can use the following command to run a MATLAB __script__ in batch mode from the Windows Command Prompt:
```cmd
matlab -nosplash -noFigureWindows -nodesktop -r "try; run('C:\Users\Path-To-My-Matlab-Script.m'); catch; end; quit"
```
To be safe, "Path-To-My-Matlab-Script.m" should have instructions to cd() to the directory it is to work in.
The command "run" cannot be used with functions but only with scripts.

For __functions__ please use the following syntax:
```cmd
matlab -nosplash -noFigureWindows -r "try; cd('C:\Path\To\'); YourFunctionName(); catch; end; quit"
```
The above commands could be put into a BAT file and invoked from any directory.

