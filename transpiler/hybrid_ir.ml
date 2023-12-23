open Ast
open Printf

(* datatypes for hybrid-ir*)
type ir_systemgraph = 
  | IRSystemgraph of ir_vertex list * ir_edge list

and ir_vertex = 
  | IRSDFActor of string * attr list * signal list * param list * ir_IO_nr
  | IRSDFChannel of string * attr list * signal list * param list (* TODO: maybe we want input output identifier names?*)
  | IRSYActor of string * attr list * signal list * param list * ir_SY_IO_nr
  | IRSYSignal of string * attr list * signal list * param list
  | IRSYFunction of string * attr list * signal list * param list
  | IRUnkownVertex of string * attr list * signal list * param list

and ir_param = 
  | IRParamLeaf of string * value list
  | IRParamNode of string * param list

and ir_IO_nr = (* number of inputs, outputs, list of input tokens, list of output tokens , list of input signals, list of output signals, list of inlined code *)
  | IRActorIOnr of int * int * value list * value list * string list * string list * value list

and ir_SY_IO_nr = (* number of inputs, outputs, list of input signals, list of output signals *)
  | IRSYActorIOnr of int * int * string list * string list

and ir_edge = 
  | IREdge of attr list * signal * port option * signal * port option


(* Functions to build IR graph *)
let rec nr_of_IO = function
  | ParamLeaf(name, value)::tl -> 1 + nr_of_IO tl
  | ParamNode(_,_)::tl -> 0 + nr_of_IO tl
  | [] -> 0

let rec get_prod_cons_tokens_list acc = function
  | ParamLeaf(name, value)::tl -> get_prod_cons_tokens_list (List.append value acc) tl
  | ParamNode(_,_)::tl -> get_prod_cons_tokens_list acc tl
  | [] -> List.rev acc

let rec get_prod_cons_signals_list acc = function
  | ParamLeaf(name, value)::tl -> get_prod_cons_signals_list (name::acc) tl
  | ParamNode(_,_)::tl -> get_prod_cons_signals_list acc tl
  | [] -> List.rev acc

let rec ident_i_o (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) = function
  | ParamNode("production", paraml)::tl -> 
    ident_i_o (i, o + nr_of_IO paraml, (get_prod_cons_tokens_list prod_no_tokens_list paraml), cons_no_tokens_list, (get_prod_cons_signals_list prod_signals_list paraml), cons_signals_list, inlined_code) tl
  | ParamNode("consumption", paraml)::tl -> 
    ident_i_o (i + nr_of_IO paraml, o, prod_no_tokens_list, (get_prod_cons_tokens_list cons_no_tokens_list paraml), prod_signals_list, (get_prod_cons_signals_list cons_signals_list paraml), inlined_code) tl
  | ParamNode(name, paraml)::tl -> 
    ident_i_o (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) tl
  | ParamLeaf("inlinedCode", value)::tl -> 
    ident_i_o (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, (List.append value inlined_code)) tl
  | ParamLeaf(name, value)::tl -> 
    ident_i_o (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) tl
  | [] -> 
    IRActorIOnr(i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code)

let rec ident_sy_inputs_outputs (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) = function
  | ParamNode("outputPorts", paraml)::tl -> 
    ident_sy_inputs_outputs (i, o + nr_of_IO paraml, (get_prod_cons_tokens_list prod_no_tokens_list paraml), cons_no_tokens_list, (get_prod_cons_signals_list prod_signals_list paraml), cons_signals_list, inlined_code) tl
  | ParamNode("inputPorts", paraml)::tl -> 
    ident_sy_inputs_outputs (i + nr_of_IO paraml, o, prod_no_tokens_list, (get_prod_cons_tokens_list cons_no_tokens_list paraml), prod_signals_list, (get_prod_cons_signals_list cons_signals_list paraml), inlined_code) tl
  | ParamNode(name, paraml)::tl -> 
    ident_sy_inputs_outputs (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) tl
  | ParamLeaf("inlinedCode", value)::tl -> 
    ident_sy_inputs_outputs (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, (List.append value inlined_code)) tl
  | ParamLeaf(name, value)::tl -> 
    ident_sy_inputs_outputs (i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) tl
  | [] -> 
    IRSYActorIOnr(i, o, prod_signals_list, cons_signals_list)

let rec ident_vertex_type name attrl signall paraml = 
  match attrl with
  | AttributeThree("moc", "sdf", "SDFActor")::attr_tl 
    -> IRSDFActor(name, attr_tl, signall, paraml, (ident_i_o (0, 0, [], [], [], [], []) paraml)) 
  | AttributeThree("moc", "sdf", "SDFChannel")::attr_tl 
    -> IRSDFChannel(name, attr_tl, signall, paraml)
  | AttributeThree("moc", "sy", "SYMap")::attr_tl 
    -> IRSYActor(name, attr_tl, signall, paraml, (ident_sy_inputs_outputs (0, 0, [], [], [], [], []) paraml)) 
  | AttributeThree("moc", "sy", "SYSignal")::attr_tl 
    -> IRSYSignal(name, attr_tl, signall, paraml)
  | AttributeTwo("impl", "InstrumentedExecutable")::attr_tl 
    -> IRSYFunction(name, attr_tl, signall, paraml)
  | _::attr_tl -> ident_vertex_type name attr_tl signall paraml
  | [] -> IRUnkownVertex(name, attrl, signall, paraml)
(* 
  | AttributeOne(value)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | AttributeTwo(value1, value2)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | AttributeThree(value1, value2, value3)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | AttributeFour(value1, value2, value3, value4)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | AttributeFive(value1, value2, value3, value4, value5)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | AttributeSix(value1, value2, value3, value4, value5, value6)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | AttributeSeven(value1, value2, value3, value4, value5, value6, value7)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | AttributeEight(value1, value2, value3, value4, value5, value6, value7, value8)::attr_tl
    -> IRUnkownVertex(name, attrl, signall, paraml)
  | _ -> failwith "There is an attribute that has not been implemented yet." *)

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

let rec pprint_string_list = function
  | [] -> ""
  | [s] -> s
  | s::tl -> s ^ ", " ^ pprint_string_list tl

let pprint_io = function
  | IRActorIOnr(i, o, prod_no_tokens_list, cons_no_tokens_list, prod_signals_list, cons_signals_list, inlined_code) ->
    "inputs = " ^ string_of_int i ^ "\noutputs = " ^ string_of_int o ^ "\nproduction_tokens = " ^ pprint_value_list prod_no_tokens_list ^ "\nconsumption_tokens = " ^ pprint_value_list cons_no_tokens_list ^ "\nproduction_signals = " ^ pprint_string_list prod_signals_list ^ "\nconsumption_signals = " ^ pprint_string_list cons_signals_list ^ "\ninlined_code = " ^ pprint_value_list inlined_code ^ "\n"

let pprint_sy_io = function
  | IRSYActorIOnr(i, o, prod_signals_list, cons_signals_list) ->
    "inputs = " ^ string_of_int i ^ "\noutputs = " ^ string_of_int o ^ "\nproduction_signals = " ^ pprint_string_list prod_signals_list ^ "\nconsumption_signals = " ^ pprint_string_list cons_signals_list ^ "\n"

let rec pprint_ir_attr_list = function 
  | [] -> ""
  | AttributeOne(name)::tl -> name ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeTwo(name, value)::tl -> name ^ " = " ^ value ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeThree(name, value1, value2)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeFour(name, value1, value2, value3)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeFive(name, value1, value2, value3, value4)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeSix(name, value1, value2, value3, value4, value5)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeSeven(name, value1, value2, value3, value4, value5, value6)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ ", " ^ value6 ^ "\n" ^ pprint_ir_attr_list tl
  | AttributeEight(name, value1, value2, value3, value4, value5, value6, value7)::tl -> name ^ " = " ^ value1 ^ ", " ^ value2 ^ ", " ^ value3 ^ ", " ^ value4 ^ ", " ^ value5 ^ ", " ^ value6 ^ ", " ^ value7 ^ "\n" ^ pprint_ir_attr_list tl

let rec pprint_ir_vertex_list = function
  | IRSDFActor(name, attrl, signall, paraml, io)::tl 
    -> "IRSDFActor( \n actor_name = " ^ name ^ "\n" ^ pprint_ir_attr_list attrl ^ "signals(" ^ pprint_ir_signal_list signall ^ ")\n" ^ pprint_ir_param_list paraml ^ pprint_io io ^ "\n)\n\n" ^ pprint_ir_vertex_list tl
  | IRSDFChannel(name, attrl, signall, paraml)::tl 
    -> "IRSDFChannel(\nchannel_name = " ^ name ^ "\n" ^ (pprint_ir_attr_list attrl) ^  "signals(" ^ (pprint_ir_signal_list signall) ^ ")\n" ^ (pprint_ir_param_list paraml) ^ ")\n\n" ^ pprint_ir_vertex_list tl
  | IRSYActor(name, attrl, signall, paraml, io)::tl 
    -> "IRSYActor( \n actor_name = " ^ name ^ "\n" ^ pprint_ir_attr_list attrl ^ "signals(" ^ pprint_ir_signal_list signall ^ ")\n" ^ pprint_ir_param_list paraml ^ pprint_sy_io io ^ "\n)\n\n" ^ pprint_ir_vertex_list tl
  | IRSYSignal(name, attrl, signall, paraml)::tl 
    -> "IRSYSignal(\nchannel_name = " ^ name ^ "\n" ^ (pprint_ir_attr_list attrl) ^  "signals(" ^ (pprint_ir_signal_list signall) ^ ")\n" ^ (pprint_ir_param_list paraml) ^ ")\n\n" ^ pprint_ir_vertex_list tl
  | IRSYFunction(name, attrl, signall, paraml)::tl 
    -> "IRSYFunction(\nchannel_name = " ^ name ^ "\n" ^ (pprint_ir_attr_list attrl) ^  "signals(" ^ (pprint_ir_signal_list signall) ^ ")\n" ^ (pprint_ir_param_list paraml) ^ ")\n\n" ^ pprint_ir_vertex_list tl
  | IRUnkownVertex(name, attrl, signall, paraml)::tl
    -> "IRUnkownVertex(\nvertex_name = " ^ name ^ "\n" ^ (pprint_ir_attr_list attrl) ^  "signals(" ^ (pprint_ir_signal_list signall) ^ ")\n" ^ (pprint_ir_param_list paraml) ^ ")\n\n" ^ pprint_ir_vertex_list tl
  | [] -> ""

let rec pprint_ir_port = function
  | Some Port(name) -> name
  | _ -> "no_port"

let rec pprint_ir_edge_list = function
  | IREdge(attrl, signal1, port1, signal2, port2)::tl -> "IREdge(\n" ^ (pprint_ir_attr_list attrl) ^ "\nFrom Signal: " ^ (pprint_ir_signal_list [signal1]) ^ "\nFrom Port: " ^ (pprint_ir_port port1) ^ "\n\nTo Signal: " ^ (pprint_ir_signal_list [signal2]) ^ "\nTo Port: " ^ (pprint_ir_port port2) ^ "\n)\n\n" ^ pprint_ir_edge_list tl
  | [] -> ""

let pprint_hybrid_ir = function
  | IRSystemgraph(vl, el) 
    -> "IRSystemgraph(\n\n" ^ (pprint_ir_vertex_list vl) ^ pprint_ir_edge_list el ^ ")"

