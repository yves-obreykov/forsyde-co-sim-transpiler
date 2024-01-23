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

NOTE - Your path might be different

4. Open this terminal
5. opam init
6. opam switch create 4.14.0+mingw64
7. eval $(opam env)
8. opam install ocamlbuild
9. opam install ocamlfind
10. opam install core
11. opam install menhir
12. It is recommended that you execute all compiler related instructions using this newly installed "Cygwin" terminal inside VSCode

# Steps to install gcc on your system
1. Follow the instructions from https://code.visualstudio.com/docs/cpp/config-mingw 

# Step to install GHC on your system
1. Install cabal and GHC 9.6.3 using instructions from https://www.haskell.org/ghcup/
3. Install git bash terminal from https://gitforwindows.org/
2. Open a git bash terminal and run following commands
3. cabal update
4. cabal install forsyde-shallow -w ghc-9.6.3
5. cabal install --lib forsyde-shallow -w ghc-9.6.3
6. cabal install parallel -w ghc-9.6.3
7. cabal install --lib parallel -w ghc-9.6.3

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
3. Run
     D:\ghcup\ghc\9.6.3\bin\ghc.exe -O2 -threaded --make -main-is SDF_System_Model .\toy_sequence_example_simple.hs
4. Run the executable to use one thread using 
     .\toy_sequence_example_simple.exe +RTS -N1-qa
5. Time the executable to use one core using 
     Measure-Command {.\toy_sequence_example_simple.exe +RTS -N1-qa}
This takes about 26 seconds on my system.

# Steps to build and run the toy SDF sequence example using GHC for one core running multiple threads
1. Open a powershell terminal
2. go to haskell-files directory
3. Run
     D:\ghcup\ghc\9.6.3\bin\ghc.exe -O2 -threaded --make -main-is SDF_System_Model .\toy_sequence_example.hs
3. Run
     $executablePath = ".\toy_sequence_example.exe"
4. Run
     $affinityMask = 0x1
     This sets affinity to the first core (you can adjust this as needed)
5. Run
     $executionResult = Measure-Command {
     $process = Start-Process -FilePath $executablePath -ArgumentList "+RTS -N1-qa" -PassThru -NoNewWindow
     $process.ProcessorAffinity = $affinityMask
     $process.WaitForExit()
    }
6. Time the executable to use four threads on one core:
     $executionResult | Format-List
     This takes about 27 seconds on my system

# Steps to build and run the toy SDF sequence example using GHC for multi core
1. Open a powershell terminal
2. go to haskell-files directory
3. "D:\ghcup\ghc\9.6.3\bin\ghc.exe -O2 -threaded --make -main-is SDF_System_Model .\toy_sequence_example.hs"
4. Run the executable to use one core using ".\toy_sequence_example.exe +RTS -N1-qa"
5. Time the executable to use one core using "Measure-Command {.\toy_sequence_example.exe +RTS -N1-qa}". This takes about 27 seconds on my system.
6. Run the executable to use two cores using ".\toy_sequence_example.exe +RTS -N2-qa"
7. Time the executable to use two cores using "Measure-Command {.\toy_sequence_example.exe +RTS -N2-qa}". This takes about 20 seconds on my system.
8. Run the executable to use four cores using ".\toy_sequence_example.exe +RTS -N4-qa"
9. Time the executable to use four cores using "Measure-Command {.\toy_sequence_example.exe +RTS -N4-qa}". This takes about 18 seconds on my system.

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

# Steps to build and run the compiler for a toy SY parallel example - single thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/SY_parallel_example.fiodl sy singlethread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes 50 input tokens from the input file automatically, then pass them through 4 parallel mapSY and it will produce outputs (50 integers x 4) to stdout. On my system it takes about 35 seconds to run this example.

# Steps to build and run the compiler for a toy SY parallel example - multi thread
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/SY_parallel_example.fiodl sy multithread"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes 50 input tokens from the input file automatically, then pass them through 4 mapSY and it will produce outputs (50 integers x 4) to stdout. On my system it takes about 35 seconds to run this example.

# Steps to build and run the compiler for a toy SY parallel example - multi core
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/SY_parallel_example.fiodl sy multicore"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run and time the executable using "time ./a.exe ../example-c-implementation/input.txt"
7. It takes 50 input tokens from the input file automatically, then pass them through 4 mapSY and it will produce outputs (50 integers x 4) to stdout. On my system it takes about 15 seconds to run this example.

# Steps to build the documentation
1. go to transpiler directory
2. run "make docs"
3. This will make the html documentaion in the docs\ folder, you can open index.html and navigate