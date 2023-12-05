# forsyde-co-sim-transpiler
The Forsyde co-sim transpiler is an open source project which aims to be a source-to-source compiler for ForSyDe IO models and generate C code. It also aims to enable Co-simulations between the generated C implementations and the related ForSyDe-Shallow model. 

# Current status: Takes an .fiodl input file, prints AST and IR to terminal, makes a C file called "output.c"

# Steps to install OCaml on your system
1. Use the graphical installation from https://fdopen.github.io/opam-repository-mingw/installation/ 
2. Install the VSCode extension and follow its instructions https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform
3. Add this to your settings.json of vscode to open a terminal which has ocaml available
 "terminal.integrated.profiles.windows": {
        "Cygwin": {
        "path": "D:/OCaml64/Cygwin.bat",
        "args": ["-"]
        }
    } 
4. It is recommended that you execute the following steps using this newly installed "Cygwin" terminal inside VSCode


# Steps to build and run the compiler for a toy SDF example - single thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sdf_small_cycle_extended.fiodl ../fiodl-files/body_0_ForSyDeDesignModel_Orchestrator.txt"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run the executable using "./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (two integers at a time) from the input file automatically and it will produce outputs (three integers at a time) to stdout

# Steps to build and run the compiler for a toy SDF example - multi thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sequence_example.fiodl ../fiodl-files/body_0_ForSyDeDesignModel_ForSyDeIOScalaModule.fiodl"
4. This will make a c file called "../example-c-implementation/output.c" which uses 2 pthreads
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run the executable using "./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (one integer at a time) from the input file automatically and it will produce outputs (one integer at a time) to stdout


# Changes
Added multi thread support using pthreads

# Pending Tasks
1. ~~Implement exact buffer sizes for each channel - currently this is hardcoded to 2~~
2. ~~Implement schedule in which to call the actors - currently it just calls each actor once~~
3. ~~Both of the above needs to come from IDeSyDe which I have not be able to understand yet. UPDATE: current version of iDeSyDe gives schedule but not buffer size.~~
4. ~~Implement reading of input channel from stdin, printing of output channel to stdout~~
5. Test with more SDF examples
6. ~~Try multi thread and multi core implementations~~
