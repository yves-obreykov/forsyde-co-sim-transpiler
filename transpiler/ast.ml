
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


(* Find "superLoopEntries" in vertex "os0" *)
let find_super_loop = function
| Some Systemgraph(vl, el) ->
  let rec find_super_loop_vertex = function
    | [] -> None
    | Vertex(name, attrl, signall, paraml)::tl ->
      if name = "os0" then
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
        find_super_loop_param paraml
      else
        find_super_loop_vertex tl
  in
  let res = find_super_loop_vertex vl
  in
  (match res with
  | Some vl ->
    let rec pprint_param_list = function
      | [] -> []
      | ParamLeaf(name, valuel)::tl -> name :: pprint_param_list tl
      | ParamNode(name, paraml)::tl -> pprint_param_list tl
    in
    pprint_param_list vl
  | None -> [])
| None -> []