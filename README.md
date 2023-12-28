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
3. run "./transpiler ../fiodl-files/toy_sequence_example.fiodl sdf ../fiodl-files/body_0_ForSyDeDesignModel_ForSyDeIOScalaModule.fiodl singlethread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (one integers at a time) from the input file automatically and it will produce outputs (one integers at a time) to stdout. On my system it takes about 35 seconds to run this example.

# Steps to build and run the compiler for a toy SDF sequence example - multi thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sequence_example.fiodl sdf ../fiodl-files/body_0_ForSyDeDesignModel_ForSyDeIOScalaModule.fiodl multithread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (one integers at a time) from the input file automatically and it will produce outputs (one integers at a time) to stdout. On my system it takes about 45 seconds to run this example.

# Steps to build and run the compiler for a toy SDF sequence example - multi core
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sequence_example.fiodl sdf ../fiodl-files/body_0_ForSyDeDesignModel_ForSyDeIOScalaModule.fiodl multicore"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes input tokens (one integers at a time) from the input file automatically and it will produce outputs (one integers at a time) to stdout. On my system it takes about 15 seconds to run this example.

# Steps to build and run the toy SDF sequence example using GHC for single thread
1. Open a powershell terminal
2. go to haskell-files directory
3. "D:\ghcup\ghc\9.6.3\bin\ghc.exe -O2 -threaded --make -main-is SDF_System_Model .\toy_sequence_example.hs"
4. Run the executable to use one thread using ".\toy_sequence_example.exe +RTS -N1"
5. Time the executable to use one core using "Measure-Command {.\toy_sequence_example.exe +RTS -N1}". This takes about 27 seconds on my system.

# Steps to build and run the toy SDF sequence example using GHC for multi thread
1. Open a powershell terminal
2. go to haskell-files directory
3. input:
     executablePath = "path to \toy_sequence_example.exe(customized)"
4. input:
     affinityMask = 0x1  # Set affinity to the first core (you can adjust this as needed)
5: input:
     executionResult = Measure-Command {
     process = Start-Process -FilePath $executablePath -ArgumentList "+RTS -N4" -PassThru -NoNewWindow
     process.ProcessorAffinity = $affinityMask
     process.WaitForExit()
    }
6. Time the executable to use four threads on one core:
     executionResult | Format-List

# Steps to build and run the toy SDF sequence example using GHC for multi core
1. Open a powershell terminal
2. go to haskell-files directory
3. "D:\ghcup\ghc\9.6.3\bin\ghc.exe -O2 -threaded --make -main-is SDF_System_Model .\toy_sequence_example.hs"
4. Run the executable to use one thread using ".\toy_sequence_example.exe +RTS -N1"
5. Time the executable to use one thread using "Measure-Command {.\toy_sequence_example.exe +RTS -N1}". This takes about 27 seconds on my system.
6. Run the executable to use two threads using ".\toy_sequence_example.exe +RTS -N2"
7. Time the executable to use two threads using "Measure-Command {.\toy_sequence_example.exe +RTS -N2}". This takes about 20 seconds on my system.
8. Run the executable to use four threads using ".\toy_sequence_example.exe +RTS -N4"
9. Time the executable to use four threads using "Measure-Command {.\toy_sequence_example.exe +RTS -N4}". This takes about 18 seconds on my system.
(The cores will be used randomly because we didn't limit the number of cores, it uses multi-core under this circumstance.)

# Steps to build and run the compiler for a toy SY sequence example - single thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/SY_sequential_example.fiodl sy singlethread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes 50 input tokens from the input file automatically, then pass them through 4 mapSY and it will produce outputs (50 integers) to stdout. On my system it takes about 35 seconds to run this example.

# Steps to build and run the compiler for a toy SY sequence example - multi thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/SY_sequential_example.fiodl sy multithread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes 50 input tokens from the input file automatically, then pass them through 4 mapSY and it will produce outputs (50 integers) to stdout. On my system it takes about 35 seconds to run this example.

# Steps to build and run the compiler for a toy SY sequence example - multi core
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/SY_sequential_example.fiodl sy multicore"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes 50 input tokens from the input file automatically, then pass them through 4 mapSY and it will produce outputs (50 integers) to stdout. On my system it takes about 35 seconds to run this example.
