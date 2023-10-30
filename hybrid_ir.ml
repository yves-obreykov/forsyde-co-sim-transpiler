open Ast
open Printf

(* datatypes for hybrid-ir*)
type ir_systemgraph = 
  | IRSystemgraph of ir_vertex list * ir_edge list

and ir_vertex = 
  | IRSDFActor of string * attr list * signal list * param list * ir_IO_nr
  | IRSDFChannel of string * attr list * signal list * param list (* TODO: maybe we want input output identifier names?*)

and ir_param = 
  | IRParamLeaf of string * value list
  | IRParamNode of string * param list

and ir_IO_nr = (* number of inputs and outputs of an actor*)
  | IRActorIOnr of int * int

and ir_edge = 
  | IREdge of attr list * signal * port option * signal * port option


(* Functions to build IR graph *)
let rec nr_of_IO = function
  | ParamLeaf(name, value)::tl -> 1 + nr_of_IO tl
  | ParamNode(_,_)::tl -> 0 + nr_of_IO tl
  | [] -> 0

let rec ident_i_o (i, o) = function
  | ParamNode("production", paraml)::tl -> ident_i_o (i, o + nr_of_IO paraml) tl
  | ParamNode("consumption", paraml)::tl -> ident_i_o (i + nr_of_IO paraml, o) tl
  | ParamNode(name, paraml)::tl -> ident_i_o (i, o) tl
  | ParamLeaf(name, value)::tl -> ident_i_o (i, o) tl
  | [] -> IRActorIOnr(i, o)

let rec ident_vertex_type name attrl signall paraml = 
  match attrl with
  | AttributeOne(value)::attr_tl 
    -> ident_vertex_type name (attr_tl @ [AttributeOne(value)]) signall paraml (* @ appends to a list*)
  (* | AttributeTwo("visualization", "Visualizable")::attr_tl 
    -> ident_vertex_type name attr_tl signall paraml Ignore visuilization *)
  | AttributeTwo(value1, value2)::attr_tl 
    -> ident_vertex_type name (attr_tl @ [AttributeTwo(value1, value2)]) signall paraml
  | AttributeThree("moc", "sdf", "SDFActor")::attr_tl 
    -> IRSDFActor(name, attr_tl, signall, paraml, (ident_i_o (0, 0) paraml)) 
  | AttributeThree("moc", "sdf", "SDFChannel")::attr_tl 
    -> IRSDFChannel(name, attr_tl, signall, paraml)
  | _ -> failwith "There is an attribute that has not been implemented yet."

let rec make_ir_edge_list = function
  | Edge(attrl, signal1, port1, signal2, port2)::tl -> IREdge(attrl, signal1, port1, signal2, port2)::(make_ir_edge_list tl)
  | [] -> []  

let rec make_ir_vertex_list = function
  | Vertex(name, attrl, signall, paraml)::tl -> 
      (ident_vertex_type name attrl signall paraml)::(make_ir_vertex_list tl)
  | [] -> [] 
 
let rec make_hybrid_ir = function
  | Some Systemgraph(vl, el) -> IRSystemgraph(make_ir_vertex_list vl, make_ir_edge_list el) 
  | _ -> failwith "Some kind of error occured in the creation of the IR Systemgraph"



(* pretty print IR *)
let pprint_io = function
  | IRActorIOnr(i, o) -> "IRActorIOnr(in=" ^ string_of_int i ^ ", out=" ^ string_of_int o ^ ")"

let rec pprint_value_list = function
  | [] -> ""
  | Value(s)::tl -> s ^ "\n" ^ pprint_value_list tl

let rec pprint_ir_param_list = function
  | [] -> ""
  | ParamLeaf(name, valuel)::tl -> name ^ " = " ^ pprint_value_list valuel ^ "\n" ^ pprint_ir_param_list tl
  | ParamNode(name, paraml)::tl -> name ^ " = " ^ "\n" ^ pprint_ir_param_list paraml ^ pprint_ir_param_list tl

let rec pprint_ir_signal_list = function
  | [] -> ""
  | Signal(name)::tl -> name ^ ", " ^ pprint_ir_signal_list tl

let rec pprint_ir_attr_list = function 
  | [] -> ""
  | AttributeOne(name)::tl -> name ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeTwo(name, value)::tl -> name ^ " = " ^ value ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeThree(name, value1, value2)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ "\n" ^ pprint_ir_attr_list tl

let rec pprint_ir_vertex_list = function
  | IRSDFActor(name, attrl, signall, paraml, io)::tl 
    -> "IRSDFActor( \n actor_name = " ^ name ^ "\n" ^ pprint_ir_attr_list attrl ^ "signals(" ^ pprint_ir_signal_list signall ^ ")\n" ^ pprint_ir_param_list paraml ^ pprint_io io ^ "\n)\n\n" ^ pprint_ir_vertex_list tl
  | IRSDFChannel(name, attrl, signall, paraml)::tl 
    -> "IRSDFChannel(\nchannel_name = " ^ name ^ "\n" ^ (pprint_ir_attr_list attrl) ^  "signals(" ^ (pprint_ir_signal_list signall) ^ ")\n" ^ (pprint_ir_param_list paraml) ^ ")\n\n" ^ pprint_ir_vertex_list tl
  | [] -> ""

let rec pprint_ir_port = function
  | Some Port(name) -> name
  | _ -> "no_port"

let rec pprint_ir_edge_list = function
  | IREdge(attrl, signal1, port1, signal2, port2)::tl -> "IREdge(\n" ^ (pprint_ir_attr_list attrl) ^ "\nFrom Signal: " ^ (pprint_ir_signal_list [signal1]) ^ "\nFrom Port: " ^ (pprint_ir_port port1) ^ "\n\nTo Signal: " ^ (pprint_ir_signal_list [signal2]) ^ "\nTo Port: " ^ (pprint_ir_port port1) ^ "\n)\n\n" ^ pprint_ir_edge_list tl
  | [] -> ""

let pprint_hybrid_ir = function
  | IRSystemgraph(vl, el) 
    -> "IRSystemgraph(\n\n" ^ (pprint_ir_vertex_list vl) ^ pprint_ir_edge_list el ^ ")"

