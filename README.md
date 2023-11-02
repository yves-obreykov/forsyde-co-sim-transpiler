# forsyde-co-sim-transpiler
The Forsyde co-sim transpiler is an open source project which aims to be a source-to-source compiler for ForSyDe IO models and generate C code. It also aims to enable Co-simulations between the generated C implementations and the related ForSyDe-Shallow model. 

# Current status: Takes an .fiodl input file, prints AST and IR to terminal, makes a C file called "output.c"

# Steps to execute
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sdf_small_cycle_extended.fiodl"
4. This will make a c file called "../example-c-implementation/output.c"
5. Compile this c file using "gcc ../example-c-implementation/output.c"
6. Run the executable using "./a.exe"
7. Currently, this does not produce any outputs

# Changes
Made a new input file called toy_sdf_small_cycle_extended.fiodl in which I added sin and sout channels, and inlined code

# Pending Tasks
1. Implement exact buffer sizes for each channel - currently this is hardcoded to 2
2. Implement schedule in which to call the actors - currently it just calls each actor once
3. Both of the above needs to come from IDeSyDe which I have not be able to understand yet
4. Implement reading of input channel from stdin, printing of output channel to stdout
