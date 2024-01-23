
type systemgraph =
  | Systemgraph of vertex list * edge list

and vertex =
  | Vertex of string * attr list * signal list * param list

and attr =
  | AttributeOne of string
  | AttributeTwo of string * string
  | AttributeThree of string * string * string
  | AttributeFour of string * string * string * string
  | AttributeFive of string * string * string * string * string
  | AttributeSix of string * string * string * string * string * string
  | AttributeSeven of string * string * string * string * string * string * string
  | AttributeEight of string * string * string * string * string * string * string * string

and signal =
  | Signal of string

and param =
  | ParamLeaf of string * value list
  | ParamNode of string * param list

and value =
  | Value of string

and edge =
  | Edge of attr list * signal * port option * signal * port option

and port =
  | Port of string


(* Pretty printing *)
let pprint_systemgraph = function
  | Some Systemgraph(vl, el) ->
    let rec pprint_vertex_list = function
      | [] -> ""
      | Vertex(name, attrl, signall, paraml)::tl ->
        let rec pprint_attr_list = function
          | [] -> ""
          | AttributeOne(name)::tl -> name ^ "\n" ^ pprint_attr_list tl
          | AttributeTwo(name, value)::tl -> name ^ " = " ^ value ^ "\n" ^ pprint_attr_list tl
          | AttributeThree(name, value1, value2)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ "\n" ^ pprint_attr_list tl
          | AttributeFour(name, value1, value2, value3)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ "\n" ^ pprint_attr_list tl
          | AttributeFive(name, value1, value2, value3, value4)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ "\n" ^ pprint_attr_list tl
          | AttributeSix(name, value1, value2, value3, value4, value5)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ "\n" ^ pprint_attr_list tl
          | AttributeSeven(name, value1, value2, value3, value4, value5, value6)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ ", " ^ value6 ^ "\n" ^ pprint_attr_list tl
          | AttributeEight(name, value1, value2, value3, value4, value5, value6, value7)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ ", " ^ value6 ^ ", " ^ value7 ^ "\n" ^ pprint_attr_list tl
        in
        let rec pprint_signal_list = function
          | [] -> ""
          | Signal(name)::tl -> name ^ "\n" ^ pprint_signal_list tl
        in
        let rec pprint_param_list = function
          | [] -> ""
          | ParamLeaf(name, valuel)::tl -> name ^ " = " ^ pprint_value_list valuel ^ "\n" ^ pprint_param_list tl
          | ParamNode(name, paraml)::tl -> name ^ " = " ^ "\n" ^ pprint_param_list paraml ^ pprint_param_list tl
        and pprint_value_list = function
          | [] -> ""
          | Value(s)::tl -> s ^ "\n" ^ pprint_value_list tl
        in
        "Vertex:" ^ "\n" ^ "Name: " ^ name ^ "\n\n" ^ "Attributes:\n" ^ pprint_attr_list attrl ^ "\n" ^ "Signals:\n" ^ pprint_signal_list signall ^ "\n" ^ "Parameters:\n" ^ pprint_param_list paraml ^ "\n\n" ^ pprint_vertex_list tl
    and pprint_edge_list = function
      | [] -> ""
      | Edge(attrl, signal1, port1, signal2, port2)::tl ->
        let rec pprint_attr_list = function
          | [] -> ""
          | AttributeOne(name)::tl -> name ^ "\n" ^ pprint_attr_list tl
          | AttributeTwo(name, value)::tl -> name ^ " = " ^ value ^ "\n" ^ pprint_attr_list tl
          | AttributeThree(name, value1, value2)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ "\n" ^ pprint_attr_list tl
          | AttributeFour(name, value1, value2, value3)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ "\n" ^ pprint_attr_list tl
          | AttributeFive(name, value1, value2, value3, value4)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ "\n" ^ pprint_attr_list tl
          | AttributeSix(name, value1, value2, value3, value4, value5)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ "\n" ^ pprint_attr_list tl
          | AttributeSeven(name, value1, value2, value3, value4, value5, value6)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ ", " ^ value6 ^ "\n" ^ pprint_attr_list tl
          | AttributeEight(name, value1, value2, value3, value4, value5, value6, value7)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ ", " ^ value6 ^ ", " ^ value7 ^ "\n" ^ pprint_attr_list tl
        in
        let pprint_signal = function
          | Signal(name) -> name
        in
        let pprint_port_option = function
          | Some (Port(name)) -> name
          | None -> ""
        in
        "Edge:" ^ "\n" ^ "Attributes:\n" ^ pprint_attr_list attrl ^ "\n" ^ "From Signal: " ^ pprint_signal signal1 ^ "\n" ^ "From Port: " ^ pprint_port_option port1 ^ "\n\n" ^ "To Signal: " ^ pprint_signal signal2 ^ "\n" ^ "To Port: " ^ pprint_port_option port2 ^ "\n\n\n" ^ pprint_edge_list tl
    in
    pprint_vertex_list vl ^ pprint_edge_list el
  | None -> "No systemgraph found\n"



let find_super_loop = function
| Some Systemgraph(vl, el) ->
  let rec find_super_loop_vertex params_found names_found = function
    | [] -> (None, params_found, names_found)
    | Vertex(name, _, _, paraml)::tl ->
      if List.mem name ["os0"; "os1"; "os2"; "os3"] && not (List.mem name names_found) then
      let rec find_super_loop_param = function
        | [] -> None
        | ParamLeaf(name, valuel)::tl ->
          (find_super_loop_param tl)
        | ParamNode(name, paraml)::tl ->
          if name = "superLoopEntries" then
            (Some paraml)
          else
            (find_super_loop_param tl)
      in
      let param_list = find_super_loop_param paraml in
      let updated_names_found =
        (match param_list with
        | Some param_list -> name :: names_found
        | None -> names_found) in
      let updated_params_found =
        (match param_list with
        | Some param_list -> [param_list] @ params_found
        | None -> params_found)
      in
      find_super_loop_vertex updated_params_found updated_names_found tl
      else
      find_super_loop_vertex params_found names_found tl
  in
  let (res1, res2, res3) = find_super_loop_vertex [] [] vl
  in
  if res2 = [] then
    failwith "No superLoopEntries found"
  else
  let rec pprint_param_list = function
    | [] -> []
    | ParamLeaf(name, valuel)::tl -> name :: pprint_param_list tl
    | ParamNode(name, paraml)::tl -> pprint_param_list tl
  in
  (List.map pprint_param_list res2)
| None -> []




(* Find vertices with the attribute "forsyde::io::lib::hierarchy::behavior::moc::sdf::SDFChannel" *)
let find_sdf_channel_sizes = function
| Some Systemgraph(vl, el) ->
  let rec find_sdf_channels_vertex = function
    | [] -> []
    | Vertex(name, attrl, signall, paraml)::tl ->
      let rec find_sdf_channels_attr = function
        | [] -> false
        | AttributeOne(name)::tl -> find_sdf_channels_attr tl
        | AttributeTwo(name, value)::tl -> find_sdf_channels_attr tl
        | AttributeThree(name, value1, value2)::tl -> find_sdf_channels_attr tl
        | AttributeFour(name, value1, value2, value3)::tl -> find_sdf_channels_attr tl
        | AttributeFive(name, value1, value2, value3, value4)::tl -> find_sdf_channels_attr tl
        | AttributeSix(name, value1, value2, value3, value4, value5)::tl -> find_sdf_channels_attr tl
        | AttributeSeven(name, value1, value2, value3, value4, value5, value6)::tl -> find_sdf_channels_attr tl
        | AttributeEight(name, value1, value2, value3, value4, value5, value6, value7)::tl -> 
          if value7 = "SDFChannel" then
            true
          else
            find_sdf_channels_attr tl
      in
      if find_sdf_channels_attr attrl then
        let rec find_sdf_channels_param = function
          | [] -> None
          | ParamLeaf("maxElements", [Value(s)])::ptl -> Some s
          | ParamLeaf(name, valuel)::ptl -> find_sdf_channels_param ptl
          | ParamNode(name, paraml)::ptl -> find_sdf_channels_param ptl
        in
        (match find_sdf_channels_param paraml with
        | Some s -> (name ^ " = " ^ s) :: find_sdf_channels_vertex tl
        | None -> find_sdf_channels_vertex tl)
      else
        find_sdf_channels_vertex tl
  in
  find_sdf_channels_vertex vl
| None -> []