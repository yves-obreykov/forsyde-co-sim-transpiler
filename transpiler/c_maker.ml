open Hybrid_ir
open Printf


let make_c_header = 
  "#include <stdio.h>\n" ^ 
  "#include <stdlib.h>\n" ^
  "#include <windows.h>\n" ^
  "#include \"c-skeletons-for-SDF.c\"\n\n"

let make_c_footer = "\treturn 0;\n}"

let rec pprint_value_list = function
  | [] -> ""
  | Ast.Value(s)::[] -> String.sub s 0 1
  | Ast.Value(s)::tl -> (String.sub s 0 1) ^ "," ^ pprint_value_list tl

let rec pprint_inlined_code = function
  | [] -> ""
  | Ast.Value(s)::[] -> s
  | Ast.Value(s)::tl -> s ^ "," ^ pprint_inlined_code tl

let rec pprint_string_list = function
  | [] -> ""
  | [s] -> "&" ^ s
  | s::tl -> "&" ^ s ^ ", " ^ pprint_string_list tl

let rec pprint_input_list n = function
  | [] -> ""
  | [s] -> "token* in" ^ string_of_int n
  | s::tl -> "token* in" ^ string_of_int n ^ ", " ^ pprint_input_list (n+1) tl

let rec pprint_output_list n = function
  | [] -> ""
  | [s] -> "token* out" ^ string_of_int n
  | s::tl -> "token* out" ^ string_of_int n ^ ", " ^ pprint_output_list (n+1) tl

let rec findi x lst c = match lst with
  | [] -> -1
  | hd::tl -> if (hd=x) then c else findi x tl (c+1)

  (* Find the element in the sizes list which has name as a substring *)
let extract_size name sizes =
  let rec find_size name = function
    | [] -> None
    | s :: rest ->
        if String.contains s '=' then begin
          let parts = String.split_on_char '=' s in
          match parts with
          | [n; size] when (String.sub (String.lowercase_ascii n) 2 2) = (String.sub (String.lowercase_ascii name) 0 2) -> Some (int_of_char (size.[1]) - 48)
          | _ -> find_size name rest
        end else
          find_size name rest
  in
  find_size name sizes
    
let rec make_c_actors identified_functions actor_calls buffer_declaration buffer_creations sequences sizes = function
  | [] -> (identified_functions, actor_calls, buffer_declaration, buffer_creations)
  | IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)::tl ->
    (
    match ir_IO_nr with
    | IRActorIOnr(i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) ->
      match sequences with
      | [] -> make_c_actors identified_functions actor_calls buffer_declaration buffer_creations sequences sizes tl
      | sequence::remaining_sequences ->
        match sequence with
        | [] -> make_c_actors identified_functions (actor_calls^"\n@\n") buffer_declaration buffer_creations remaining_sequences sizes (IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)::tl)
        | curr::remaining -> 
          (List.iter print_endline sequence);
          print_endline "";
          let (new_identified_functions, new_actor_calls, new_sequences, new_vl) =
          if curr = name then
            if (List.exists (fun x -> x = name) remaining) then
              if List.exists (fun x -> x = "sip") cons_signals_list then
                let index = findi "sip" cons_signals_list 0 in
                let num_sip_tokens = List.nth cons_no_tokens_list index in
                (identified_functions),         
                (
                  actor_calls
                  ^ "\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sip_tokens]) ^ "; j++) {\n\t\tif(fscanf(file, \"%d\", &input) == 1) {\n\t\t\tprintf(\"Read " ^ (pprint_value_list [num_sip_tokens]) ^ " input tokens: \");\n\t\t\tprintf(\"%d\\n\", input);\n\t\t\twriteToken(sip, input);\n\t\t}\n\telse {\n\t\t\tprintf(\"End of file reached.\\n\");\n\t\t\tfclose(file);\n\t\t\texit(0);\n\t\t}\n\t}\n"
                  ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                ),
                (List.append [remaining] remaining_sequences),
                ((IRSDFActor(name, attrl, signall, paraml, ir_IO_nr))::tl)
              else if List.exists (fun x -> x = "sout") prod_signals_list then
                let index = findi "sout" prod_signals_list 0 in
                let num_sout_tokens = List.nth prod_no_tokens_list index in
                (identified_functions),         
                (
                  actor_calls
                  ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                  ^ "\n\tprintf(\"Output:\");\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sout_tokens]) ^ "; j++) {\n\t\treadToken(sout, &output);\n\t\tprintf(\"%d\\n\", output);\n\t}\n"
                ),
                (List.append [remaining] remaining_sequences),
                ((IRSDFActor(name, attrl, signall, paraml, ir_IO_nr))::tl)
              else
                (identified_functions),         
                (
                  actor_calls
                  ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                ),
                (List.append [remaining] remaining_sequences),
                ((IRSDFActor(name, attrl, signall, paraml, ir_IO_nr))::tl)
            else
              if List.exists (fun x -> x = "sip") cons_signals_list then
                let index = findi "sip" cons_signals_list 0 in
                let num_sip_tokens = List.nth cons_no_tokens_list index in
                (identified_functions ^ "\n/* Function " ^ name ^ " */\n" ^ "void f_" ^ name ^ "(" ^ pprint_input_list 1 cons_signals_list ^ ", " ^ pprint_output_list 1 prod_signals_list ^ "){\n" ^ "\t" ^ pprint_inlined_code inlined_code ^ "\n}\n"),
                (
                  actor_calls
                  ^ "\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sip_tokens]) ^ "; j++) {\n\t\tif(fscanf(file, \"%d\", &input) == 1) {\n\t\t\tprintf(\"Read " ^ (pprint_value_list [num_sip_tokens]) ^ " input tokens: \");\n\t\t\tprintf(\"%d\\n\", input);\n\t\t\twriteToken(sip, input);\n\t\t}\n\telse {\n\t\t\tprintf(\"End of file reached.\\n\");\n\t\t\tfclose(file);\n\t\t\texit(0);\n\t\t}\n\t}\n"
                  ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                ),
                (List.append [remaining] remaining_sequences),
                tl
              else if List.exists (fun x -> x = "sout") prod_signals_list then
                let index = findi "sout" prod_signals_list 0 in
                let num_sout_tokens = List.nth prod_no_tokens_list index in
                (identified_functions ^ "\n/* Function " ^ name ^ " */\n" ^ "void f_" ^ name ^ "(" ^ pprint_input_list 1 cons_signals_list ^ ", " ^ pprint_output_list 1 prod_signals_list ^ "){\n" ^ "\t" ^ pprint_inlined_code inlined_code ^ "\n}\n"),
                (
                  actor_calls
                  ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                  ^ "\n\tprintf(\"Output:\");\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sout_tokens]) ^ "; j++) {\n\t\treadToken(sout, &output);\n\t\tprintf(\"%d\\n\", output);\n\t}\n"
                ),
                (List.append [remaining] remaining_sequences),
                tl
              else
                (identified_functions ^ "\n/* Function " ^ name ^ " */\n" ^ "void f_" ^ name ^ "(" ^ pprint_input_list 1 cons_signals_list ^ ", " ^ pprint_output_list 1 prod_signals_list ^ "){\n" ^ "\t" ^ pprint_inlined_code inlined_code ^ "\n}\n"),
                (
                  actor_calls
                  ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                ),
                (List.append [remaining] remaining_sequences),
                tl
          else
            identified_functions,
            actor_calls,
            (List.append remaining_sequences [sequence]),
            (List.append tl [IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)])
        in
        make_c_actors new_identified_functions new_actor_calls buffer_declaration buffer_creations new_sequences sizes new_vl
    )
  
  | IRSDFChannel(name, attrl, signall, paraml)::tl -> 
    (* Sample
      token* buffer_s_in = malloc(3 * sizeof(token));
      channel s_in = createFIFO(buffer_s_in, 3);
    *)
    (* Find the element in the sizes list which has name as a substring *)
    let size_option = extract_size name sizes in
    let size = match size_option with
      | Some s -> s
      | None -> failwith "make_c_actors: IRSDFChannel: Size not found"
    in
    let sigName = String.sub name 0 (String.length name - 3) in
    let rec string_repeat s n =
      if n = 0 then
        ""
      else
        s ^ string_repeat s (n - 1)
    in
    let rec print_initial_tokens = function
    | Ast.ParamLeaf("numOfInitialTokens", value)::tl -> 
      let num_initial_tokens =
        match value with
        | Ast.Value(s)::[] -> int_of_string (String.sub s 0 1)
        | _ -> failwith "make_c_actors: IRParamLeaf: Value expected"
      in
      if num_initial_tokens > 0 then
        "\t/*Initial tokens for " ^ sigName ^ "*/\n" ^ string_repeat ("\twriteToken(" ^ sigName ^ ", " ^ "0" ^ ");\n") num_initial_tokens ^ print_initial_tokens tl
      else
        print_initial_tokens tl
    | _::tl -> print_initial_tokens tl
    | [] -> ""
  in
  make_c_actors identified_functions actor_calls (buffer_declaration ^ "\n" ^ "token* buffer_" ^ sigName ^ ";\n" ^ "channel " ^ sigName ^ ";\n") (buffer_creations ^ "\n\t" ^ "buffer_" ^ sigName ^ " = malloc(" ^ string_of_int size ^ " * sizeof(token));\n\t" ^ sigName ^ " = createFIFO(buffer_" ^ sigName ^ ", " ^ string_of_int size ^ ");\n" ^ print_initial_tokens paraml) sequences sizes tl


  | IRUnkownVertex(name, attrl, signall, paraml)::tl ->
    make_c_actors identified_functions actor_calls buffer_declaration buffer_creations sequences sizes tl



let rec sy_find_functions_and_signals identified_functions function_calls identified_signals = function
  | [] -> (identified_functions, function_calls, identified_signals)
  | IRSYSignal(name, attrl, signall, paraml)::tl ->
    let new_identified_signals = identified_signals ^ "Signal **" ^ name ^ ";\n" in
    sy_find_functions_and_signals identified_functions function_calls new_identified_signals tl
  | IRSYFunction(name, attrl, signall, paraml)::tl ->
    let inlined_code_param = List.hd paraml in
    (
    match inlined_code_param with
    | Ast.ParamLeaf("inlinedCode", inlined_code)->
      let new_identified_functions = identified_functions ^ "/* Function " ^ name ^ " */\n" ^ "int " ^ name ^ "(int a){\n\t" ^ "int res;\n" ^ pprint_inlined_code inlined_code ^ "\n\treturn res;\n}\n" in
      sy_find_functions_and_signals new_identified_functions function_calls identified_signals tl
    )
  | IRUnkownVertex(name, attrl, signall, paraml)::tl ->
    sy_find_functions_and_signals identified_functions function_calls identified_signals tl
  | IRSYActor(name, attrl, signall, paraml, ir_IO_nr)::tl ->
    (
    match ir_IO_nr with
    | IRSYActorIOnr(no_i, no_o, list_i, list_o) ->
      (
      if (no_i = 1) && (no_o = 1) then
        begin
          let new_function_calls = function_calls ^ "\t/* Vertex " ^ name ^ " */\n\t" ^ "mapSY(f, *" ^ (List.hd list_o) ^ ", " ^ (List.hd list_i) ^ ");" in
          sy_find_functions_and_signals identified_functions new_function_calls identified_signals tl
        end
      else
        begin
          sy_find_functions_and_signals identified_functions function_calls identified_signals tl
        end
      )
    )

      



    
let make_c_code_threads sequences sizes target_platform = function
  | IRSystemgraph(vl, el) ->
    let oc = open_out "../example-c-implementation/output.c" in
    fprintf oc "/* Code generated by the ForSyDe compiler */\n";
    fprintf oc "%s" make_c_header;
    let (identified_functions, actor_calls, buffer_declaration, buffer_creations) = make_c_actors "" "" "" "" sequences sizes vl in
    fprintf oc "%s" identified_functions;
    fprintf oc "%s" "\nFILE *file;\n";
    fprintf oc "%s" buffer_declaration;
    (*Split actor_calls into a list of strings by the delimiter "\@\n"*)
    let actor_calls_list = String.split_on_char '@' actor_calls in
    (* Iterate over the list of strings and print this header followed by the string *)
    List.iter (fun x -> fprintf oc "%s" (
      "\n" ^
      "void *loop" ^ string_of_int (findi x actor_calls_list 0) ^ "(void* arg)" ^ "\n" ^
      "{" ^ "\n\t" ^
      "token input;" ^ "\n\t" ^
      "token output;" ^ "\n\n\t" ^
      "int threadId = *((int *)arg);" ^ "\n\t" ^
      "printf(\"Thread %d is running on CPU %d\\n\", threadId, GetCurrentProcessorNumber());" ^ "\n\n\t" ^
      "while(1){" ^ "\n\t\t" ^ x ^ "\t}\n}\n") ) actor_calls_list;

    fprintf oc "%s" (
      "\n" ^ 
      "int main(int argc, char *argv[]) {" ^ "\n\t" ^
      "// Check if the correct number of command-line arguments is provided" ^ "\n\t" ^
      "if (argc != 2) {" ^ "\n\t\t" ^
        "fprintf(stderr, \"Usage: %s <filename>\\n\", argv[0]);" ^ "\n\t\t" ^
        "return 1; // Return an error code" ^ "\n\t" ^
      "}" ^ "\n\t\n\t" ^
      "// Open the file for reading" ^ "\n\t" ^
      "file = fopen(argv[1], \"r\");" ^ "\n\n\t" ^
      "// Check if the file opened successfully" ^ "\n\t" ^
      "if (file == NULL) {" ^ "\n\t\t" ^
      "fprintf(stderr, \"Unable to open the file '%s' for reading.\\n\", argv[1]);" ^ "\n\t\t" ^
      "return 1; // Return an error code" ^ "\n\t" ^
      "}" ^ "\n\t\n\t"
      );

    fprintf oc "%s" buffer_creations;

    fprintf oc "%s" (
      "\n\t" ^
      "int num_threads = 4;" ^ "\n\t" ^
      "HANDLE threads[num_threads];" ^ "\n\t" ^
      "int threadIds[num_threads];" ^ "\n\n\t" ^
      "// Create and run threads" ^ "\n\t"
    );

    (* Create threads equal to the length of actor_calls_list *)
    (*Example
      threadIds[0] = 0;
    	threads[0] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop0, (LPVOID)&threadIds[0], 0, NULL);
	    if (threads[0] == NULL) {
		    fprintf(stderr, "Error creating thread %d\n", 0);
		    exit(EXIT_FAILURE);
	    }
    *)
    List.iter (fun x -> fprintf oc "%s" (
      "\n\t" ^ 
      "threadIds[" ^ string_of_int (findi x actor_calls_list 0) ^ "] = " ^ string_of_int (findi x actor_calls_list 0) ^ ";" ^ "\n\t" ^
      "threads[" ^ string_of_int (findi x actor_calls_list 0) ^ "] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop" ^ string_of_int (findi x actor_calls_list 0) ^ ", (LPVOID)&threadIds[" ^ string_of_int (findi x actor_calls_list 0) ^ "], 0, NULL);" ^ "\n\t" ^
      "if (threads[" ^ string_of_int (findi x actor_calls_list 0) ^ "] == NULL) {" ^ "\n\t\t" ^
      "fprintf(stderr, \"Error creating thread %d\\n\", " ^ string_of_int (findi x actor_calls_list 0) ^ ");" ^ "\n\t\t" ^
      "exit(EXIT_FAILURE);" ^ "\n\t" ^
      "}" ^ "\n\t"
    )) actor_calls_list;

    (* Set affinity for threads equal to the length of actor_calls_list *)
    (*Example
      // Set affinity for each thread using SetThreadAffinityMask
	    for (int i = 0; i < num_threads; ++i) {
		  DWORD_PTR affinityMask = 1ULL << 0; // Set affinity always to CPU0
		  if (SetThreadAffinityMask(threads[i], affinityMask) == 0) {
			  fprintf(stderr, "Error setting affinity for thread %d\n", i);
			  exit(EXIT_FAILURE);
		    }
	    }
    *)
    if target_platform = "multithread" then
    (
    fprintf oc "%s" (
      "\n\t" ^
      "// Set affinity for each thread using SetThreadAffinityMask" ^ "\n\t" ^
      "for (int i = 0; i < num_threads; ++i) {" ^ "\n\t\t" ^
      "DWORD_PTR affinityMask = 1ULL << 0; // Set affinity always to CPU0" ^ "\n\t\t" ^
      "if (SetThreadAffinityMask(threads[i], affinityMask) == 0) {" ^ "\n\t\t\t" ^
      "fprintf(stderr, \"Error setting affinity for thread %d\\n\", i);" ^ "\n\t\t\t" ^
      "exit(EXIT_FAILURE);" ^ "\n\t\t" ^
      "}" ^ "\n\t" ^
      "}" ^ "\n\t"
    );
    )
    else
    (
    fprintf oc "%s" (
      "\n\t" ^
      "// Set affinity for each thread using SetThreadAffinityMask" ^ "\n\t" ^
      "for (int i = 0; i < num_threads; ++i) {" ^ "\n\t\t" ^
      "DWORD_PTR affinityMask = 1ULL << i; // Set affinity to a different CPU for each thread" ^ "\n\t\t" ^
      "if (SetThreadAffinityMask(threads[i], affinityMask) == 0) {" ^ "\n\t\t\t" ^
      "fprintf(stderr, \"Error setting affinity for thread %d\\n\", i);" ^ "\n\t\t\t" ^
      "exit(EXIT_FAILURE);" ^ "\n\t\t" ^
      "}" ^ "\n\t" ^
      "}" ^ "\n\t"
    );
    );

    (* Wait for threads equal to the length of actor_calls_list *)
    (*Example
      // Wait for threads to finish
	    WaitForMultipleObjects(num_threads, threads, TRUE, INFINITE);
    *)
    fprintf oc "%s" (
      "\n\t" ^
      "// Wait for threads to finish" ^ "\n\t" ^
      "WaitForMultipleObjects(num_threads, threads, TRUE, INFINITE);" ^ "\n\t"
    );

    (* Close threads equal to the length of actor_calls_list *)
    (*Example
      // Close thread handles
	    for (int i = 0; i < num_threads; ++i) {
		    CloseHandle(threads[i]);
	    }
    *)
    fprintf oc "%s" (
      "\n\t" ^
      "// Close thread handles" ^ "\n\t" ^
      "for (int i = 0; i < num_threads; ++i) {" ^ "\n\t\t" ^
      "CloseHandle(threads[i]);" ^ "\n\t" ^
      "}" ^ "\n\n\t"
    );

    fprintf oc "%s" make_c_footer;
    close_out oc





let make_c_code_simple sequences sizes target_platform = function
    | IRSystemgraph(vl, el) ->
      let oc = open_out "../example-c-implementation/output.c" in
      fprintf oc "/* Code generated by the ForSyDe compiler */\n";
      fprintf oc "%s" "#include \"c-skeletons-for-SDF.c\"\n\n";
      let (identified_functions, actor_calls, buffer_declaration, buffer_creations) = make_c_actors "" "" "" "" sequences sizes vl in
      fprintf oc "%s" identified_functions;
      fprintf oc "%s" "\nFILE *file;\n";
      fprintf oc "%s" buffer_declaration;
      fprintf oc "%s" (
        "\n" ^
        "void *loop0" ^ "(void* arg)" ^ "\n" ^
        "{" ^ "\n\t" ^
        "token input;" ^ "\n\t" ^
        "token output;" ^ "\n\n\t" ^
        "while(1){"
      );
      (*Split actor_calls into a list of strings by the delimiter "\@\n"*)
      let actor_calls_list = String.split_on_char '@' actor_calls in
      (* Iterate over the list of strings and print this header followed by the string *)
      List.iter (fun x -> fprintf oc "%s" (
        "\n" ^ x ^ "\n") ) actor_calls_list;
      
      fprintf oc "%s" (
        "\t}\n}\n"
      );

      fprintf oc "%s" (
        "\n" ^ 
        "int main(int argc, char *argv[]) {" ^ "\n\t" ^
        "// Check if the correct number of command-line arguments is provided" ^ "\n\t" ^
        "if (argc != 2) {" ^ "\n\t\t" ^
          "fprintf(stderr, \"Usage: %s <filename>\\n\", argv[0]);" ^ "\n\t\t" ^
          "return 1; // Return an error code" ^ "\n\t" ^
        "}" ^ "\n\t\n\t" ^
        "// Open the file for reading" ^ "\n\t" ^
        "file = fopen(argv[1], \"r\");" ^ "\n\n\t" ^
        "// Check if the file opened successfully" ^ "\n\t" ^
        "if (file == NULL) {" ^ "\n\t\t" ^
        "fprintf(stderr, \"Unable to open the file '%s' for reading.\\n\", argv[1]);" ^ "\n\t\t" ^
        "return 1; // Return an error code" ^ "\n\t" ^
        "}" ^ "\n\t\n\t"
        );
  
      fprintf oc "%s" buffer_creations;

      fprintf oc "%s" "\n\tloop0(NULL);\n\n";

      fprintf oc "%s" make_c_footer;
      close_out oc





let make_c_code_simple_sy sequences sizes target_platform = function
| IRSystemgraph(vl, el) ->
  let oc = open_out "../example-c-implementation/output.c" in
  fprintf oc "/* Code generated by the ForSyDe compiler */\n";
  fprintf oc "%s" "#include \"c-skeletons-for-SY.c\"\n\n";
  (* let (identified_functions, actor_calls, buffer_declaration, buffer_creations) = make_c_actors "" "" "" "" sequences sizes vl in *)
  (* fprintf oc "%s" identified_functions; *)
  let (identified_functions, function_calls, identified_signals) = sy_find_functions_and_signals "" "" "" vl in
  fprintf oc "%s" identified_functions;
  fprintf oc "%s" "\nFILE *file;\n";
  fprintf oc "%s" identified_signals;
  (* fprintf oc "%s" buffer_declaration; *)
  fprintf oc "%s" (
    "\n" ^
    "void *loop0" ^ "(void* arg)" ^ "\n" ^
    "{" ^ "\n\t" ^
    "int input;" ^ "\n\t" ^
    "int output;" ^ "\n\n\t" ^
    "while(1)" ^ "\n\t\t" ^
    "{" ^ "\n\t\t\t" ^
    "if(fscanf(file, \"%d\", &input) == 1)" ^ "\n\t\t" ^
    "{" ^ "\n\t\t\t" ^
    "printf(\"Read 1 input tokens: \");" ^ "\n\t\t\t" ^
    "printf(\"%d\\n\", input);" ^ "\n\t\t\t" ^
    "" ^ "\n\t\t" ^    
    "// Allocate memory for Signal structure" ^ "\n\t\t" ^
    "if(*s_in == NULL)" ^ "\n\t\t\t" ^
    "{" ^ "\n\t\t\t\t" ^
    "*s_in = (struct Signal *)malloc(sizeof(struct Signal));" ^ "\n\t\t\t\t" ^
    "(*s_in)->data = input;" ^ "\n\t\t\t\t" ^
    "(*s_in)->next = NULL;" ^ "\n\t\t\t" ^
    "}" ^ "\n\t\t" ^
    "else" ^ "\n\t\t\t" ^
    "{" ^ "\n\t\t\t\t" ^
    "struct Signal *current = *s_in;" ^ "\n\t\t\t\t" ^
    "while (current->next != NULL)" ^ "\n\t\t\t\t" ^
    "{" ^ "\n\t\t\t\t\t" ^
    "current = current->next;" ^ "\n\t\t\t\t" ^
    "}" ^ "\n\t\t\t\t" ^
    "current->next = (struct Signal *)malloc(sizeof(struct Signal));" ^ "\n\t\t\t\t" ^
    "current->next->data = input;" ^ "\n\t\t\t\t" ^
    "current->next->next = NULL;" ^ "\n\t\t\t" ^
    "}" ^ "\n\t\t" ^
    "}" ^ "\n\t\t" ^
    "else {" ^ "\n\t\t\t" ^
    "printf(\"End of file reached.\\n\");" ^ "\n\t\t\t" ^
    "fclose(file);" ^ "\n\t\t\t" ^
    "break;" ^ "\n\t\t" ^
    "}" ^ "\n\t" ^
    "}" ^ "\n\n"
  );

  List.iter (fun x -> fprintf oc "%s" (
    x ^ ";\n\n"
  )) (List.rev (List.tl (List.rev (String.split_on_char ';' function_calls))));

  fprintf oc "%s" (
    "\t" ^
    "printf(\"Output:\");" ^ "\n\t" ^
    "struct Signal *current = *s_out;" ^ "\n\t" ^
    "while (current != NULL)" ^ "\n\t" ^
    "{" ^ "\n\t\t" ^
    "printf(\"%d\\n\", current->data);" ^ "\n\t\t" ^
    "current = current->next;" ^ "\n\t" ^
    "}" ^ "\n" ^
    "}" ^ "\n" 
  );
  (*Split actor_calls into a list of strings by the delimiter "\@\n"*)
  (* let actor_calls_list = String.split_on_char '@' actor_calls in *)
  (* Iterate over the list of strings and print this header followed by the string *)
  (* List.iter (fun x -> fprintf oc "%s" ( *)
    (* "\n" ^ x ^ "\n") ) actor_calls_list; *)
  
  (* fprintf oc "%s" ( *)
    (* "\t}\n}\n" *)
  (* ); *)

  fprintf oc "%s" (
    "\n" ^ 
    "int main(int argc, char *argv[]) {" ^ "\n\t" ^
    "// Check if the correct number of command-line arguments is provided" ^ "\n\t" ^
    "if (argc != 2) {" ^ "\n\t\t" ^
      "fprintf(stderr, \"Usage: %s <filename>\\n\", argv[0]);" ^ "\n\t\t" ^
      "return 1; // Return an error code" ^ "\n\t" ^
    "}" ^ "\n\t\n\t" ^
    "// Open the file for reading" ^ "\n\t" ^
    "file = fopen(argv[1], \"r\");" ^ "\n\n\t" ^
    "// Check if the file opened successfully" ^ "\n\t" ^
    "if (file == NULL) {" ^ "\n\t\t" ^
    "fprintf(stderr, \"Unable to open the file '%s' for reading.\\n\", argv[1]);" ^ "\n\t\t" ^
    "return 1; // Return an error code" ^ "\n\t" ^
    "}" ^ "\n\t\n\t"
    );

  (* Allocate memory for each identified signal *)
  fprintf oc "%s" "// Allocate memory for Signal structures\n";
  List.iter (fun x -> fprintf oc "%s" (
    let x_list = String.split_on_char ' ' x in
    if List.length x_list > 1 then
      begin
        let signal_name = List.nth x_list 1 in
        let signal_name = String.sub signal_name 2 (String.length signal_name - 3) in
        "\n\t" ^ 
        signal_name ^ " = (struct Signal **)malloc(sizeof(struct Signal *));" ^ "\n\t" ^
        "*" ^ signal_name ^ " = NULL;" ^ "\n\t"
      end
    else
      begin
        ""
      end
  )) (String.split_on_char '\n' identified_signals);



  (* fprintf oc "%s" buffer_creations; *)

  fprintf oc "%s" "\n\tloop0(NULL);\n\n";

  fprintf oc "%s" make_c_footer;
  close_out oc


let make_c_code_threads_sy sequences sizes target_platform = function
  | IRSystemgraph(vl, el) ->
    let oc = open_out "../example-c-implementation/output.c" in
    fprintf oc "/* Code generated by the ForSyDe compiler */\n";
    fprintf oc "%s" (
      "#include <stdio.h>" ^ "\n" ^
      "#include <stdlib.h>" ^ "\n" ^
      "#include <windows.h>" ^ "\n" ^
      "#include \"c-skeletons-for-SY.c\"\n\n"
    );
    (* let (identified_functions, actor_calls, buffer_declaration, buffer_creations) = make_c_actors "" "" "" "" sequences sizes vl in *)
    (* fprintf oc "%s" identified_functions; *)
    let (identified_functions, function_calls, identified_signals) = sy_find_functions_and_signals "" "" "" vl in
    fprintf oc "%s" identified_functions;
    fprintf oc "%s" "\nFILE *file;\n";
    fprintf oc "%s" identified_signals;
    (* for each identified signal, make a mutex *)
    List.iter (fun x -> fprintf oc "%s" (
      let x_list = String.split_on_char ' ' x in
      if List.length x_list > 1 then
        begin
          let signal_name = List.nth x_list 1 in
          let signal_name = String.sub signal_name 2 (String.length signal_name - 3) in
          "HANDLE mutex_" ^ signal_name ^ ";\n"
        end
      else
        begin
          ""
        end
    )) (String.split_on_char '\n' identified_signals);

    (* Example 
       void *loop0(void* arg)
      {
          int threadId = arg;

        // aquire mutex for both input and output signals
        WaitForSingleObject(mutex_s_in, INFINITE);
        WaitForSingleObject(mutex_s_1, INFINITE);

        printf("Thread %d is running on CPU %d\n", threadId, GetCurrentProcessorNumber());
        /* Vertex p_1 */
        mapSY(f, *s_in, s_1);

        printf("Thread %d is finished\n", threadId);

        // release mutex for both input and output signals
        ReleaseMutex(mutex_s_1);
        ReleaseMutex(mutex_s_in);
      }	
    *)
    List.iter (fun x -> fprintf oc "%s" (
      (* x ^ "\n@\n" *)
      let vertex_name = (List.nth (String.split_on_char '\n' x) 0) in
      let func_call = (List.nth (String.split_on_char '\n' x) 1) in
      let from_signal = (String.sub (List.nth (String.split_on_char ',' func_call) 1) 2 ((String.length (List.nth (String.split_on_char ',' func_call) 1)) - 2)) in
      let to_signal = (String.sub (List.nth (String.split_on_char ',' func_call) 2) 1 ((String.length (List.nth (String.split_on_char ',' func_call) 2)) - 2)) in
      "\nvoid *loop" ^ string_of_int (findi x (List.rev (List.tl (List.rev (String.split_on_char ';' function_calls)))) 0) ^ "(void* arg)\n" ^
      "{\n\t" ^
      "int threadId = *((int *)arg);\n\n\t" ^
      "// aquire mutex for both input and output signals\n\t" ^
      "WaitForSingleObject(mutex_" ^ to_signal ^ ", INFINITE);\n\t" ^
      "WaitForSingleObject(mutex_" ^ from_signal ^ ", INFINITE);\n\n\t" ^
      "printf(\"Thread %d is running on CPU %d\\n\", threadId, GetCurrentProcessorNumber());\n\n" ^
      vertex_name ^ "\n" ^
      func_call ^ ";\n\n\t" ^
      "printf(\"Thread %d is finished\\n\", threadId);\n\n\t" ^
      "// release mutex for both input and output signals\n\t" ^
      "ReleaseMutex(mutex_" ^ from_signal ^ ");\n\t" ^
      "ReleaseMutex(mutex_" ^ to_signal ^ ");\n" ^
      "}\n\n"
    )) (List.rev (List.tl (List.rev (String.split_on_char ';' function_calls))));


    fprintf oc "%s" (
      "\n" ^ 
      "int main(int argc, char *argv[]) {" ^ "\n\t" ^
      "int input;" ^ "\n\t" ^
      "int output;" ^ "\n\n\t" ^
      "// Check if the correct number of command-line arguments is provided" ^ "\n\t" ^
      "if (argc != 2) {" ^ "\n\t\t" ^
        "fprintf(stderr, \"Usage: %s <filename>\\n\", argv[0]);" ^ "\n\t\t" ^
        "return 1; // Return an error code" ^ "\n\t" ^
      "}" ^ "\n\t\n\t" ^
      "// Open the file for reading" ^ "\n\t" ^
      "file = fopen(argv[1], \"r\");" ^ "\n\n\t" ^
      "// Check if the file opened successfully" ^ "\n\t" ^
      "if (file == NULL) {" ^ "\n\t\t" ^
      "fprintf(stderr, \"Unable to open the file '%s' for reading.\\n\", argv[1]);" ^ "\n\t\t" ^
      "return 1; // Return an error code" ^ "\n\t" ^
      "}" ^ "\n\t\n\t"
      );
  
    (* Allocate memory for each identified signal *)
    fprintf oc "%s" "// Allocate memory for Signal structures\n";
    List.iter (fun x -> fprintf oc "%s" (
      let x_list = String.split_on_char ' ' x in
      if List.length x_list > 1 then
        begin
          let signal_name = List.nth x_list 1 in
          let signal_name = String.sub signal_name 2 (String.length signal_name - 3) in
          "\n\t" ^ 
          signal_name ^ " = (struct Signal **)malloc(sizeof(struct Signal *));" ^ "\n\t" ^
          "*" ^ signal_name ^ " = NULL;" ^ "\n\t"
        end
      else
        begin
          ""
        end
    )) (String.split_on_char '\n' identified_signals);

    (* for each identified signal, initialize the mutex *)
    fprintf oc "%s" "\n// make mutexes for each signal\n\t";
    List.iter (fun x -> fprintf oc "%s" (
      let x_list = String.split_on_char ' ' x in
      if List.length x_list > 1 then
        begin
          let signal_name = List.nth x_list 1 in
          let signal_name = String.sub signal_name 2 (String.length signal_name - 3) in
          "mutex_" ^ signal_name ^ " = CreateMutex(NULL, TRUE, NULL);\n\t"
        end
      else
        begin
          ""
        end
    )) (String.split_on_char '\n' identified_signals);
    
    fprintf oc "%s" (
      "\n" ^
      "while(1)" ^ "\n\t\t" ^
      "{" ^ "\n\t\t\t" ^
      "if(fscanf(file, \"%d\", &input) == 1)" ^ "\n\t\t" ^
      "{" ^ "\n\t\t\t" ^
      "printf(\"Read 1 input tokens: \");" ^ "\n\t\t\t" ^
      "printf(\"%d\\n\", input);" ^ "\n\t\t\t" ^
      "" ^ "\n\t\t" ^    
      "// Allocate memory for Signal structure" ^ "\n\t\t" ^
      "if(*s_in == NULL)" ^ "\n\t\t\t" ^
      "{" ^ "\n\t\t\t\t" ^
      "*s_in = (struct Signal *)malloc(sizeof(struct Signal));" ^ "\n\t\t\t\t" ^
      "(*s_in)->data = input;" ^ "\n\t\t\t\t" ^
      "(*s_in)->next = NULL;" ^ "\n\t\t\t" ^
      "}" ^ "\n\t\t" ^
      "else" ^ "\n\t\t\t" ^
      "{" ^ "\n\t\t\t\t" ^
      "struct Signal *current = *s_in;" ^ "\n\t\t\t\t" ^
      "while (current->next != NULL)" ^ "\n\t\t\t\t" ^
      "{" ^ "\n\t\t\t\t\t" ^
      "current = current->next;" ^ "\n\t\t\t\t" ^
      "}" ^ "\n\t\t\t\t" ^
      "current->next = (struct Signal *)malloc(sizeof(struct Signal));" ^ "\n\t\t\t\t" ^
      "current->next->data = input;" ^ "\n\t\t\t\t" ^
      "current->next->next = NULL;" ^ "\n\t\t\t" ^
      "}" ^ "\n\t\t" ^
      "}" ^ "\n\t\t" ^
      "else {" ^ "\n\t\t\t" ^
      "printf(\"End of file reached.\\n\");" ^ "\n\t\t\t" ^
      "fclose(file);" ^ "\n\t\t\t" ^
      "break;" ^ "\n\t\t" ^
      "}" ^ "\n\t" ^
      "}" ^ "\n\n"
    );
  
    fprintf oc "%s" (
      "\tint num_threads = " ^ 
      string_of_int ((List.length (String.split_on_char '\n' identified_signals))-2) ^ 
      ";"
    );

    fprintf oc "%s" (
      "\n\t" ^
      "HANDLE threads[num_threads];" ^ "\n\t" ^
      "int threadIds[num_threads];" ^ "\n\n\t" ^
      "// Create and run threads" ^ "\t"
    );

    (* Create threads equal to two less than the length of identified_signals*)
    (*Example
      threadIds[0] = 0;
    	threads[0] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop0, (LPVOID)&threadIds[0], 0, NULL);
      if (threads[0] == NULL) {
        fprintf(stderr, "Error creating thread %d\n", 0);
        exit(EXIT_FAILURE);
      }
    *)
    List.iter (fun x -> 
      let index = ((findi x (String.split_on_char '\n' identified_signals) 0) - 2) in
      fprintf oc "%s" (
        "\n\t" ^ 
        "threadIds[" ^ string_of_int index ^ "] = " ^ string_of_int index ^ ";" ^ "\n\t" ^
        "threads[" ^ string_of_int index ^ "] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)loop" ^ string_of_int index ^ ", (LPVOID)&threadIds[" ^ string_of_int index ^ "], 0, NULL);" ^ "\n\t" ^
        "if (threads[" ^ string_of_int index ^ "] == NULL) {" ^ "\n\t\t" ^
        "fprintf(stderr, \"Error creating thread %d\\n\", " ^ string_of_int index ^ ");" ^ "\n\t\t" ^
        "exit(EXIT_FAILURE);" ^ "\n\t" ^
        "}" ^ "\n\t"
      )
    ) (List.tl (List.tl (String.split_on_char '\n' identified_signals)));

    (* Set affinity for threads equal to the length of identified_signals *)
    (*Example
      // Set affinity for each thread using SetThreadAffinityMask
      for (int i = 0; i < num_threads; ++i) {
        DWORD_PTR affinityMask = 1ULL << 0; // Set affinity always to CPU0
        if (SetThreadAffinityMask(threads[i], affinityMask) == 0) {
          fprintf(stderr, "Error setting affinity for thread %d\n", i);
          exit(EXIT_FAILURE);
          }
      }
    *)
    let affinity_string = 
      if target_platform = "multithread" then
        "DWORD_PTR affinityMask = 1ULL << 0; // Set affinity always to CPU0\n\t\t"
      else
        "DWORD_PTR affinityMask = 1ULL << i; // Set affinity to a different CPU for each thread\n\t\t"
      in
    fprintf oc "%s" (
      "\n\t" ^
      "// Set affinity for each thread using SetThreadAffinityMask" ^ "\n\t" ^
      "for (int i = 0; i < num_threads; ++i) {" ^ "\n\t\t" ^
      affinity_string ^
      "if (SetThreadAffinityMask(threads[i], affinityMask) == 0) {" ^ "\n\t\t\t" ^
      "fprintf(stderr, \"Error setting affinity for thread %d\\n\", i);" ^ "\n\t\t\t" ^
      "exit(EXIT_FAILURE);" ^ "\n\t\t" ^
      "}" ^ "\n\t" ^
      "}" ^ "\n\t"
    );

    (* Release the mutexes *)
    fprintf oc "%s" "\n\t// Release the mutexes\n\t";
    List.iter (fun x -> fprintf oc "%s" (
      let x_list = String.split_on_char ' ' x in
      if List.length x_list > 1 then
        begin
          let signal_name = List.nth x_list 1 in
          let signal_name = String.sub signal_name 2 (String.length signal_name - 3) in
          "ReleaseMutex(mutex_" ^ signal_name ^ ");\n\tSleep(1);\n\t"
        end
      else
        begin
          ""
        end
    )) (String.split_on_char '\n' identified_signals);

    (* Wait for threads equal to the length of identified_signals *)
    (*Example
      // Wait for threads to finish
      WaitForMultipleObjects(num_threads, threads, TRUE, INFINITE);
    *)
    fprintf oc "%s" (
      "\n\t" ^
      "// Wait for threads to finish" ^ "\n\t" ^
      "WaitForMultipleObjects(num_threads, threads, TRUE, INFINITE);" ^ "\n\t"
    );

    (* Close threads equal to the length of identified_signals *)
    (*Example
      // Close thread handles
      for (int i = 0; i < num_threads; ++i) {
        CloseHandle(threads[i]);
      }
    *)
    fprintf oc "%s" (
      "\n\t" ^
      "// Close thread handles" ^ "\n\t" ^
      "for (int i = 0; i < num_threads; ++i) {" ^ "\n\t\t" ^
      "CloseHandle(threads[i]);" ^ "\n\t" ^
      "}" ^ "\n\n\t"
    );
    

    fprintf oc "%s" (
      "\t" ^
      "printf(\"Output:\");" ^ "\n\t" ^
      "struct Signal *current = *s_out;" ^ "\n\t" ^
      "while (current != NULL)" ^ "\n\t" ^
      "{" ^ "\n\t\t" ^
      "printf(\"%d\\n\", current->data);" ^ "\n\t\t" ^
      "current = current->next;" ^ "\n\t" ^
      "}" ^ "\n\n" 
    );  
  

    fprintf oc "%s" make_c_footer;
    close_out oc