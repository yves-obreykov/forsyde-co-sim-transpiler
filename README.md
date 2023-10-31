# forsyde-co-sim-transpiler
The Forsyde co-sim transpiler is an open source project which aims to be a source-to-source compiler for ForSyDe IO models and generate C code. It also aims to enable Co-simulations between the generated C implementations and the related ForSyDe-Shallow model. 

# Current status: Takes an .fiodl input file, makes Abstarct Syntax Tree (AST) and pretty prints it to terminal

# Steps to execute
1. go to transpiler directory
2. run "make"
3. run "./transpiler ../fiodl-files/toy_sdf_small_cycle.fiodl"
