open Hybrid_ir
open Printf


let make_c_header = 
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
    
let rec make_c_actors identified_functions actor_calls buffer_creations sequence sizes = function
  | [] -> (identified_functions, actor_calls, buffer_creations)
  | IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)::tl ->
    (
    match ir_IO_nr with
    | IRActorIOnr(i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) ->
      match sequence with
      | [] -> make_c_actors identified_functions actor_calls buffer_creations sequence sizes tl
      | curr::remaining -> 
        if curr = name then
          if (List.exists (fun x -> x = name) remaining) then
            if List.exists (fun x -> x = "sin") cons_signals_list then
              let index = findi "sin" cons_signals_list 0 in
              let num_sin_tokens = List.nth cons_no_tokens_list index in
              make_c_actors 
              identified_functions
              (
                actor_calls
                ^ "\n\tprintf(\"Read " ^ (pprint_value_list [num_sin_tokens]) ^ " input tokens: \");" ^ "\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sin_tokens]) ^ "; j++) {\n\t\tscanf(\"%d\", &input);\n\t\twriteToken(sin, input);\n\t}\n"
                ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
              )
              buffer_creations remaining sizes (IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)::tl)
            else if List.exists (fun x -> x = "sout") prod_signals_list then
              let index = findi "sout" prod_signals_list 0 in
              let num_sout_tokens = List.nth prod_no_tokens_list index in
              make_c_actors 
              identified_functions
              (
                actor_calls
                ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                ^ "\n\tprintf(\"Output:\");\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sout_tokens]) ^ "; j++) {\n\t\treadToken(sout, &output);\n\t\tprintf(\"%d\\n\", output);\n\t}\n"
              )
              buffer_creations remaining sizes (IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)::tl)
            else
              make_c_actors 
              identified_functions
              (
                actor_calls
                ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
              )
              buffer_creations remaining sizes (IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)::tl)
          else
            if List.exists (fun x -> x = "sin") cons_signals_list then
              let index = findi "sin" cons_signals_list 0 in
              let num_sin_tokens = List.nth cons_no_tokens_list index in
              make_c_actors 
              (identified_functions ^ "\n/* Function " ^ name ^ " */\n" ^ "void f_" ^ name ^ "(" ^ pprint_input_list 1 cons_signals_list ^ ", " ^ pprint_output_list 1 prod_signals_list ^ "){\n" ^ "\t" ^ pprint_inlined_code inlined_code ^ "\n}\n")
              (
                actor_calls
                ^ "\n\tprintf(\"Read " ^ (pprint_value_list [num_sin_tokens]) ^ " input tokens: \");" ^ "\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sin_tokens]) ^ "; j++) {\n\t\tscanf(\"%d\", &input);\n\t\twriteToken(sin, input);\n\t}\n"
                ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
              )
              buffer_creations remaining sizes tl
            else if List.exists (fun x -> x = "sout") prod_signals_list then
              let index = findi "sout" prod_signals_list 0 in
              let num_sout_tokens = List.nth prod_no_tokens_list index in
              make_c_actors 
              (identified_functions ^ "\n/* Function " ^ name ^ " */\n" ^ "void f_" ^ name ^ "(" ^ pprint_input_list 1 cons_signals_list ^ ", " ^ pprint_output_list 1 prod_signals_list ^ "){\n" ^ "\t" ^ pprint_inlined_code inlined_code ^ "\n}\n")
              (
                actor_calls
                ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
                ^ "\n\tprintf(\"Output:\");\n\tfor(int j = 0; j <" ^ (pprint_value_list [num_sout_tokens]) ^ "; j++) {\n\t\treadToken(sout, &output);\n\t\tprintf(\"%d\\n\", output);\n\t}\n"
              )
              buffer_creations remaining sizes tl

            else
              make_c_actors 
              (identified_functions ^ "\n/* Function " ^ name ^ " */\n" ^ "void f_" ^ name ^ "(" ^ pprint_input_list 1 cons_signals_list ^ ", " ^ pprint_output_list 1 prod_signals_list ^ "){\n" ^ "\t" ^ pprint_inlined_code inlined_code ^ "\n}\n")
              (
                actor_calls
                ^ "\n\t/* Actor " ^ name ^ " */\n\t" ^ "actor" ^ string_of_int i ^ string_of_int o ^ "SDF(" ^ pprint_value_list cons_no_tokens_list ^ ", " ^ pprint_value_list prod_no_tokens_list ^ ", " ^ pprint_string_list cons_signals_list ^ ", " ^ pprint_string_list prod_signals_list ^ ", f_" ^ name ^ ");\n"
              )
              buffer_creations remaining sizes tl
        else
          make_c_actors identified_functions actor_calls buffer_creations sequence sizes (List.append tl [IRSDFActor(name, attrl, signall, paraml, ir_IO_nr)])
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
  make_c_actors identified_functions actor_calls (buffer_creations ^ "\n\t" ^ "token* buffer_" ^ sigName ^ " = malloc(" ^ string_of_int size ^ " * sizeof(token));\n\t" ^ "channel " ^ sigName ^ " = createFIFO(buffer_" ^ sigName ^ ", " ^ string_of_int size ^ ");\n" ^ print_initial_tokens paraml) sequence sizes tl


  | IRUnkownVertex(name, attrl, signall, paraml)::tl ->
    make_c_actors identified_functions actor_calls buffer_creations sequence sizes tl

let make_c_code sequence sizes = function
  | IRSystemgraph(vl, el) ->
    let oc = open_out "../example-c-implementation/output.c" in
    fprintf oc "/* Code generated by the ForSyDe compiler */\n";
    fprintf oc "%s" make_c_header;
    let (identified_functions, actor_calls, buffer_creations) = make_c_actors "" "" "" sequence sizes vl in
    fprintf oc "%s" identified_functions;
    fprintf oc "%s" ("\nint main(){" ^ "\n\t" ^ "token input;" ^ "\n\t" ^ "token output;");
    fprintf oc "%s" buffer_creations;
    fprintf oc "%s" "\n\twhile(1){\n";
    fprintf oc "%s" actor_calls;
    fprintf oc "%s" "\t}\n";
    fprintf oc "%s" make_c_footer;
    close_out oc
