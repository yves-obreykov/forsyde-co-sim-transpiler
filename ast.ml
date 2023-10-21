
type systemgraph =
  | Systemgraph of vertex list * edge list

and vertex =
  | Vertex of string * attr list * signal list * param list

and attr =
  | AttributeTwo of string * string
  | AttributeThree of string * string * string

and signal =
  | Signal of string

and param =
  | ParamLeaf of string * value
  | ParamNode of string * param list

and value =
  | Value of int * char

and edge =
  | Edge of attr list * signal * port * signal * port

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
          | AttributeTwo(name, value)::tl -> name ^ " = " ^ value ^ "\n" ^ pprint_attr_list tl
          | AttributeThree(name, value1, value2)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ "\n" ^ pprint_attr_list tl
        in
        let rec pprint_signal_list = function
          | [] -> ""
          | Signal(name)::tl -> name ^ "\n" ^ pprint_signal_list tl
        in
        let rec pprint_param_list = function
          | [] -> ""
          | ParamLeaf(name, value)::tl -> name ^ " = " ^ pprint_value value ^ "\n" ^ pprint_param_list tl
          | ParamNode(name, paraml)::tl -> name ^ " = " ^ "\n" ^ pprint_param_list paraml ^ pprint_param_list tl
        and pprint_value = function
          | Value(i, c) -> string_of_int i ^ ", " ^ String.make 1 c
        in
        "Vertex:" ^ "\n" ^ "Name: " ^ name ^ "\n\n" ^ "Attributes:\n" ^ pprint_attr_list attrl ^ "\n" ^ "Signals:\n" ^ pprint_signal_list signall ^ "\n" ^ "Parameters:\n" ^ pprint_param_list paraml ^ "\n\n" ^ pprint_vertex_list tl
    and pprint_edge_list = function
      | [] -> ""
      | Edge(attrl, signal1, port1, signal2, port2)::tl ->
        let rec pprint_attr_list = function
          | [] -> ""
          | AttributeTwo(name, value)::tl -> name ^ " = " ^ value ^ "\n" ^ pprint_attr_list tl
          | AttributeThree(name, value1, value2)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ "\n" ^ pprint_attr_list tl
        in
        let pprint_signal = function
          | Signal(name) -> name
        in
        let pprint_port = function
          | Port(name) -> name
        in
        "Edge:" ^ "\n" ^ "Attributes:\n" ^ pprint_attr_list attrl ^ "\n" ^ "From Signal: " ^ pprint_signal signal1 ^ "\n" ^ "From Port: " ^ pprint_port port1 ^ "\n\n" ^ "To Signal: " ^ pprint_signal signal2 ^ "\n" ^ "To Port: " ^ pprint_port port2 ^ "\n\n\n" ^ pprint_edge_list tl
    in
    pprint_vertex_list vl ^ pprint_edge_list el
  | None -> "No systemgraph found\n"

