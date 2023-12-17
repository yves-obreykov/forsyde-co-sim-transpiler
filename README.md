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


# Steps to build and run the compiler for a toy SDF sequence example - single thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sequence_example.fiodl ../fiodl-files/body_0_ForSyDeDesignModel_ForSyDeIOScalaModule.fiodl singlethread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (one integers at a time) from the input file automatically and it will produce outputs (one integers at a time) to stdout. On my system it takes about 35 seconds to run this example.

# Steps to build and run the compiler for a toy SDF sequence example - multi thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sequence_example.fiodl ../fiodl-files/body_0_ForSyDeDesignModel_ForSyDeIOScalaModule.fiodl multithread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (one integers at a time) from the input file automatically and it will produce outputs (one integers at a time) to stdout. On my system it takes about 45 seconds to run this example.

# Steps to build and run the compiler for a toy SDF sequence example - multi core
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sequence_example.fiodl ../fiodl-files/body_0_ForSyDeDesignModel_ForSyDeIOScalaModule.fiodl multicore"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (one integers at a time) from the input file automatically and it will produce outputs (one integers at a time) to stdout. On my system it takes about 15 seconds to run this example.

# Steps to build and run the toy sequence example using GHC for single thread/ multi thread/ multi core
1. Open a powershell terminal
2. go to haskell-files directory
3. "D:\ghcup\ghc\9.6.3\bin\ghc.exe -O2 -threaded --make -main-is SDF_System_Model .\toy_sequence_example.hs"
4. Run the executable to use one core using ".\toy_sequence_example.exe +RTS -N1"
5. Time the executable to use one core using "Measure-Command {.\toy_sequence_example.exe +RTS -N1}". This takes about 27 seconds on my system.
6. Run the executable to use two cores using ".\toy_sequence_example.exe +RTS -N2"
7. Time the executable to use two cores using "Measure-Command {.\toy_sequence_example.exe +RTS -N2}". This takes about 20 seconds on my system.
8. Run the executable to use four cores using ".\toy_sequence_example.exe +RTS -N4"
9. Time the executable to use four cores using "Measure-Command {.\toy_sequence_example.exe +RTS -N4}". This takes about 18 seconds on my system.
