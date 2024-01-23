
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | VERTEX
    | TO
    | SYSTEMGRAPH
    | STRING of (
# 8 "parser.mly"
       (string)
# 18 "parser.ml"
  )
    | RIGHT_PAREN
    | RIGHT_BRACK
    | RIGHT_BRACE
    | PORT
    | LEFT_PAREN
    | LEFT_BRACK
    | LEFT_BRACE
    | INT of (
# 6 "parser.mly"
       (int)
# 30 "parser.ml"
  )
    | FROM
    | EOF
    | EDGE
    | COMMA
    | COLON
    | CHAR of (
# 7 "parser.mly"
       (char)
# 40 "parser.ml"
  )
  
end

include MenhirBasics

# 2 "parser.mly"
  
    open Ast

# 51 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState002 : ('s, _menhir_box_main) _menhir_state
    (** State 002.
        Stack shape : .
        Start symbol: main. *)

  | MenhirState003 : (('s, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_state
    (** State 003.
        Stack shape : VERTEX.
        Start symbol: main. *)

  | MenhirState005 : (('s, _menhir_box_main) _menhir_cell1_CHAR, _menhir_box_main) _menhir_state
    (** State 005.
        Stack shape : CHAR.
        Start symbol: main. *)

  | MenhirState008 : ((('s, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name, _menhir_box_main) _menhir_state
    (** State 008.
        Stack shape : VERTEX vertex_name.
        Start symbol: main. *)

  | MenhirState013 : (('s, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_state
    (** State 013.
        Stack shape : list(CHAR).
        Start symbol: main. *)

  | MenhirState016 : ((('s, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_state
    (** State 016.
        Stack shape : list(CHAR) list(CHAR).
        Start symbol: main. *)

  | MenhirState019 : (((('s, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_state
    (** State 019.
        Stack shape : list(CHAR) list(CHAR) list(CHAR).
        Start symbol: main. *)

  | MenhirState022 : ((((('s, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_state
    (** State 022.
        Stack shape : list(CHAR) list(CHAR) list(CHAR) list(CHAR).
        Start symbol: main. *)

  | MenhirState025 : (((((('s, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_state
    (** State 025.
        Stack shape : list(CHAR) list(CHAR) list(CHAR) list(CHAR) list(CHAR).
        Start symbol: main. *)

  | MenhirState028 : ((((((('s, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_state
    (** State 028.
        Stack shape : list(CHAR) list(CHAR) list(CHAR) list(CHAR) list(CHAR) list(CHAR).
        Start symbol: main. *)

  | MenhirState031 : (((((((('s, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_state
    (** State 031.
        Stack shape : list(CHAR) list(CHAR) list(CHAR) list(CHAR) list(CHAR) list(CHAR) list(CHAR).
        Start symbol: main. *)

  | MenhirState035 : (((('s, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_state
    (** State 035.
        Stack shape : VERTEX vertex_name attr_list.
        Start symbol: main. *)

  | MenhirState039 : ((((('s, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal_list, _menhir_box_main) _menhir_state
    (** State 039.
        Stack shape : VERTEX vertex_name attr_list signal_list.
        Start symbol: main. *)

  | MenhirState041 : (('s, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_state
    (** State 041.
        Stack shape : STRING.
        Start symbol: main. *)

  | MenhirState043 : ((('s, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACK, _menhir_box_main) _menhir_state
    (** State 043.
        Stack shape : STRING LEFT_BRACK.
        Start symbol: main. *)

  | MenhirState045 : (((('s, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACK, _menhir_box_main) _menhir_cell1_LEFT_BRACK, _menhir_box_main) _menhir_state
    (** State 045.
        Stack shape : STRING LEFT_BRACK LEFT_BRACK.
        Start symbol: main. *)

  | MenhirState048 : (('s, _menhir_box_main) _menhir_cell1_INT, _menhir_box_main) _menhir_state
    (** State 048.
        Stack shape : INT.
        Start symbol: main. *)

  | MenhirState054 : (('s, _menhir_box_main) _menhir_cell1_value, _menhir_box_main) _menhir_state
    (** State 054.
        Stack shape : value.
        Start symbol: main. *)

  | MenhirState063 : (('s, _menhir_box_main) _menhir_cell1_param, _menhir_box_main) _menhir_state
    (** State 063.
        Stack shape : param.
        Start symbol: main. *)

  | MenhirState066 : ((('s, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACE, _menhir_box_main) _menhir_state
    (** State 066.
        Stack shape : STRING LEFT_BRACE.
        Start symbol: main. *)

  | MenhirState073 : (('s, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_state
    (** State 073.
        Stack shape : signal.
        Start symbol: main. *)

  | MenhirState076 : (('s, _menhir_box_main) _menhir_cell1_list_CHAR_ _menhir_cell0_INT, _menhir_box_main) _menhir_state
    (** State 076.
        Stack shape : list(CHAR) INT.
        Start symbol: main. *)

  | MenhirState082 : (('s, _menhir_box_main) _menhir_cell1_attr, _menhir_box_main) _menhir_state
    (** State 082.
        Stack shape : attr.
        Start symbol: main. *)

  | MenhirState085 : ((('s, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_list_CHAR_ _menhir_cell0_INT, _menhir_box_main) _menhir_state
    (** State 085.
        Stack shape : VERTEX list(CHAR) INT.
        Start symbol: main. *)

  | MenhirState088 : (('s, _menhir_box_main) _menhir_cell1_vertex_list, _menhir_box_main) _menhir_state
    (** State 088.
        Stack shape : vertex_list.
        Start symbol: main. *)

  | MenhirState090 : (('s, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_state
    (** State 090.
        Stack shape : EDGE.
        Start symbol: main. *)

  | MenhirState093 : ((('s, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_state
    (** State 093.
        Stack shape : EDGE attr_list.
        Start symbol: main. *)

  | MenhirState095 : (((('s, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_state
    (** State 095.
        Stack shape : EDGE attr_list signal.
        Start symbol: main. *)

  | MenhirState097 : ((((('s, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_state
    (** State 097.
        Stack shape : EDGE attr_list signal signal.
        Start symbol: main. *)

  | MenhirState102 : ((('s, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_list_CHAR_ _menhir_cell0_INT, _menhir_box_main) _menhir_state
    (** State 102.
        Stack shape : signal list(CHAR) INT.
        Start symbol: main. *)

  | MenhirState104 : (((('s, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_state
    (** State 104.
        Stack shape : EDGE attr_list signal.
        Start symbol: main. *)

  | MenhirState106 : ((((('s, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_option_port_, _menhir_box_main) _menhir_state
    (** State 106.
        Stack shape : EDGE attr_list signal option(port).
        Start symbol: main. *)

  | MenhirState108 : (((((('s, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_option_port_, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_state
    (** State 108.
        Stack shape : EDGE attr_list signal option(port) signal.
        Start symbol: main. *)

  | MenhirState113 : (('s, _menhir_box_main) _menhir_cell1_edge, _menhir_box_main) _menhir_state
    (** State 113.
        Stack shape : edge.
        Start symbol: main. *)

  | MenhirState115 : (('s, _menhir_box_main) _menhir_cell1_vertex, _menhir_box_main) _menhir_state
    (** State 115.
        Stack shape : vertex.
        Start symbol: main. *)


and ('s, 'r) _menhir_cell1_attr = 
  | MenhirCell1_attr of 's * ('s, 'r) _menhir_state * (Ast.attr)

and ('s, 'r) _menhir_cell1_attr_list = 
  | MenhirCell1_attr_list of 's * ('s, 'r) _menhir_state * (Ast.attr list)

and ('s, 'r) _menhir_cell1_edge = 
  | MenhirCell1_edge of 's * ('s, 'r) _menhir_state * (Ast.edge)

and ('s, 'r) _menhir_cell1_list_CHAR_ = 
  | MenhirCell1_list_CHAR_ of 's * ('s, 'r) _menhir_state * (char list)

and ('s, 'r) _menhir_cell1_option_port_ = 
  | MenhirCell1_option_port_ of 's * ('s, 'r) _menhir_state * (Ast.port option)

and ('s, 'r) _menhir_cell1_param = 
  | MenhirCell1_param of 's * ('s, 'r) _menhir_state * (Ast.param)

and ('s, 'r) _menhir_cell1_signal = 
  | MenhirCell1_signal of 's * ('s, 'r) _menhir_state * (Ast.signal)

and ('s, 'r) _menhir_cell1_signal_list = 
  | MenhirCell1_signal_list of 's * ('s, 'r) _menhir_state * (Ast.signal list)

and ('s, 'r) _menhir_cell1_value = 
  | MenhirCell1_value of 's * ('s, 'r) _menhir_state * (Ast.value)

and ('s, 'r) _menhir_cell1_vertex = 
  | MenhirCell1_vertex of 's * ('s, 'r) _menhir_state * (Ast.vertex)

and ('s, 'r) _menhir_cell1_vertex_list = 
  | MenhirCell1_vertex_list of 's * ('s, 'r) _menhir_state * (Ast.vertex list)

and ('s, 'r) _menhir_cell1_vertex_name = 
  | MenhirCell1_vertex_name of 's * ('s, 'r) _menhir_state * (String.t)

and ('s, 'r) _menhir_cell1_CHAR = 
  | MenhirCell1_CHAR of 's * ('s, 'r) _menhir_state * (
# 7 "parser.mly"
       (char)
# 270 "parser.ml"
)

and ('s, 'r) _menhir_cell1_EDGE = 
  | MenhirCell1_EDGE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_INT = 
  | MenhirCell1_INT of 's * ('s, 'r) _menhir_state * (
# 6 "parser.mly"
       (int)
# 280 "parser.ml"
)

and 's _menhir_cell0_INT = 
  | MenhirCell0_INT of 's * (
# 6 "parser.mly"
       (int)
# 287 "parser.ml"
)

and ('s, 'r) _menhir_cell1_LEFT_BRACE = 
  | MenhirCell1_LEFT_BRACE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LEFT_BRACK = 
  | MenhirCell1_LEFT_BRACK of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STRING = 
  | MenhirCell1_STRING of 's * ('s, 'r) _menhir_state * (
# 8 "parser.mly"
       (string)
# 300 "parser.ml"
)

and ('s, 'r) _menhir_cell1_VERTEX = 
  | MenhirCell1_VERTEX of 's * ('s, 'r) _menhir_state

and _menhir_box_main = 
  | MenhirBox_main of (Ast.systemgraph option) [@@unboxed]

let _menhir_action_01 =
  fun s1 ->
    (
# 66 "parser.mly"
    ( AttributeOne(String.of_seq (List.to_seq s1)) )
# 314 "parser.ml"
     : (Ast.attr))

let _menhir_action_02 =
  fun s1 s2 ->
    (
# 68 "parser.mly"
    ( AttributeTwo(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2)) )
# 322 "parser.ml"
     : (Ast.attr))

let _menhir_action_03 =
  fun s1 s2 s3 ->
    (
# 70 "parser.mly"
    ( AttributeThree(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3)) )
# 330 "parser.ml"
     : (Ast.attr))

let _menhir_action_04 =
  fun s1 s2 s3 s4 ->
    (
# 72 "parser.mly"
    ( AttributeFour(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4)) )
# 338 "parser.ml"
     : (Ast.attr))

let _menhir_action_05 =
  fun s1 s2 s3 s4 s5 ->
    (
# 74 "parser.mly"
    ( AttributeFive(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5)) )
# 346 "parser.ml"
     : (Ast.attr))

let _menhir_action_06 =
  fun s1 s2 s3 s4 s5 s6 ->
    (
# 76 "parser.mly"
    ( AttributeSix(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5) , String.of_seq (List.to_seq s6)) )
# 354 "parser.ml"
     : (Ast.attr))

let _menhir_action_07 =
  fun s1 s2 s3 s4 s5 s6 s7 ->
    (
# 78 "parser.mly"
    ( AttributeSeven(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5) , String.of_seq (List.to_seq s6) , String.of_seq (List.to_seq s7)) )
# 362 "parser.ml"
     : (Ast.attr))

let _menhir_action_08 =
  fun s1 s2 s3 s4 s5 s6 s7 s8 ->
    (
# 80 "parser.mly"
    ( AttributeEight(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5) , String.of_seq (List.to_seq s6) , String.of_seq (List.to_seq s7) , String.of_seq (List.to_seq s8)) )
# 370 "parser.ml"
     : (Ast.attr))

let _menhir_action_09 =
  fun xs ->
    let al = 
# 229 "<standard.mly>"
    ( xs )
# 378 "parser.ml"
     in
    (
# 62 "parser.mly"
    ( al )
# 383 "parser.ml"
     : (Ast.attr list))

let _menhir_action_10 =
  fun e_attrs e_from e_from_port e_to e_to_port ->
    (
# 133 "parser.mly"
    ( Edge(e_attrs, e_from, e_from_port, e_to, e_to_port) )
# 391 "parser.ml"
     : (Ast.edge))

let _menhir_action_11 =
  fun e_attrs e_from e_from_port e_to ->
    (
# 135 "parser.mly"
    ( Edge(e_attrs, e_from, e_from_port, e_to, None) )
# 399 "parser.ml"
     : (Ast.edge))

let _menhir_action_12 =
  fun e_attrs e_from e_to e_to_port ->
    (
# 137 "parser.mly"
    ( Edge(e_attrs, e_from, None, e_to, e_to_port) )
# 407 "parser.ml"
     : (Ast.edge))

let _menhir_action_13 =
  fun e_attrs e_from e_to ->
    (
# 139 "parser.mly"
    ( Edge(e_attrs, e_from, None, e_to, None) )
# 415 "parser.ml"
     : (Ast.edge))

let _menhir_action_14 =
  fun e ->
    (
# 129 "parser.mly"
    ( e )
# 423 "parser.ml"
     : (Ast.edge list))

let _menhir_action_15 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 431 "parser.ml"
     : (char list))

let _menhir_action_16 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 439 "parser.ml"
     : (char list))

let _menhir_action_17 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 447 "parser.ml"
     : (Ast.edge list))

let _menhir_action_18 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 455 "parser.ml"
     : (Ast.edge list))

let _menhir_action_19 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 463 "parser.ml"
     : (Ast.vertex list))

let _menhir_action_20 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 471 "parser.ml"
     : (Ast.vertex list))

let _menhir_action_21 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 479 "parser.ml"
     : (Ast.attr list))

let _menhir_action_22 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 487 "parser.ml"
     : (Ast.attr list))

let _menhir_action_23 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 495 "parser.ml"
     : (Ast.param list))

let _menhir_action_24 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 503 "parser.ml"
     : (Ast.param list))

let _menhir_action_25 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 511 "parser.ml"
     : (Ast.signal list))

let _menhir_action_26 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 519 "parser.ml"
     : (Ast.signal list))

let _menhir_action_27 =
  fun s ->
    (
# 32 "parser.mly"
    ( Some s )
# 527 "parser.ml"
     : (Ast.systemgraph option))

let _menhir_action_28 =
  fun () ->
    (
# 34 "parser.mly"
    ( None )
# 535 "parser.ml"
     : (Ast.systemgraph option))

let _menhir_action_29 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 543 "parser.ml"
     : (Ast.port option))

let _menhir_action_30 =
  fun x ->
    (
# 113 "<standard.mly>"
    ( Some x )
# 551 "parser.ml"
     : (Ast.port option))

let _menhir_action_31 =
  fun k ->
    (
# 102 "parser.mly"
    ( ParamLeaf(k, [Value("")]) )
# 559 "parser.ml"
     : (Ast.param))

let _menhir_action_32 =
  fun k v ->
    (
# 104 "parser.mly"
    ( ParamLeaf(k, [v]) )
# 567 "parser.ml"
     : (Ast.param))

let _menhir_action_33 =
  fun k vl ->
    (
# 106 "parser.mly"
    ( ParamLeaf(k, vl) )
# 575 "parser.ml"
     : (Ast.param))

let _menhir_action_34 =
  fun k ->
    (
# 108 "parser.mly"
    ( ParamLeaf(k, [Value("")]) )
# 583 "parser.ml"
     : (Ast.param))

let _menhir_action_35 =
  fun k vl ->
    (
# 110 "parser.mly"
    ( ParamLeaf(k, vl) )
# 591 "parser.ml"
     : (Ast.param))

let _menhir_action_36 =
  fun k p ->
    (
# 112 "parser.mly"
    ( ParamNode(k, p) )
# 599 "parser.ml"
     : (Ast.param))

let _menhir_action_37 =
  fun k p ->
    (
# 114 "parser.mly"
    ( ParamNode(k, p) )
# 607 "parser.ml"
     : (Ast.param))

let _menhir_action_38 =
  fun xs ->
    let p = 
# 229 "<standard.mly>"
    ( xs )
# 615 "parser.ml"
     in
    (
# 98 "parser.mly"
    ( p )
# 620 "parser.ml"
     : (Ast.param list))

let _menhir_action_39 =
  fun i s1 s2 ->
    (
# 143 "parser.mly"
    ( Port(String.of_seq (List.to_seq s1) ^ string_of_int i ^ String.of_seq (List.to_seq s2)) )
# 628 "parser.ml"
     : (Ast.port))

let _menhir_action_40 =
  fun s ->
    (
# 145 "parser.mly"
    ( Port(String.of_seq (List.to_seq s)) )
# 636 "parser.ml"
     : (Ast.port))

let _menhir_action_41 =
  fun s ->
    (
# 147 "parser.mly"
    ( Port(s) )
# 644 "parser.ml"
     : (Ast.port))

let _menhir_action_42 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 652 "parser.ml"
     : (Ast.attr list))

let _menhir_action_43 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 660 "parser.ml"
     : (Ast.attr list))

let _menhir_action_44 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 668 "parser.ml"
     : (Ast.param list))

let _menhir_action_45 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 676 "parser.ml"
     : (Ast.param list))

let _menhir_action_46 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 684 "parser.ml"
     : (Ast.signal list))

let _menhir_action_47 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 692 "parser.ml"
     : (Ast.signal list))

let _menhir_action_48 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 700 "parser.ml"
     : (Ast.value list))

let _menhir_action_49 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 708 "parser.ml"
     : (Ast.value list))

let _menhir_action_50 =
  fun s ->
    (
# 88 "parser.mly"
    ( Signal(String.of_seq (List.to_seq s)) )
# 716 "parser.ml"
     : (Ast.signal))

let _menhir_action_51 =
  fun s1 s2 s3 ->
    (
# 90 "parser.mly"
    ( Signal(String.of_seq (List.to_seq s1) ^ string_of_int s2 ^ String.of_seq (List.to_seq s3)) )
# 724 "parser.ml"
     : (Ast.signal))

let _menhir_action_52 =
  fun s ->
    (
# 92 "parser.mly"
    ( Signal(s) )
# 732 "parser.ml"
     : (Ast.signal))

let _menhir_action_53 =
  fun s1 s2 s3 s4 ->
    (
# 94 "parser.mly"
    ( Signal(String.of_seq (List.to_seq s1) ^ string_of_int s2 ^ String.of_seq (List.to_seq s3) ^ string_of_int s4) )
# 740 "parser.ml"
     : (Ast.signal))

let _menhir_action_54 =
  fun xs ->
    let sl = 
# 229 "<standard.mly>"
    ( xs )
# 748 "parser.ml"
     in
    (
# 84 "parser.mly"
    ( sl )
# 753 "parser.ml"
     : (Ast.signal list))

let _menhir_action_55 =
  fun e v ->
    (
# 39 "parser.mly"
      ( Systemgraph(v,e) )
# 761 "parser.ml"
     : (Ast.systemgraph))

let _menhir_action_56 =
  fun s ->
    (
# 122 "parser.mly"
    ( Value(s) )
# 769 "parser.ml"
     : (Ast.value))

let _menhir_action_57 =
  fun i s ->
    (
# 124 "parser.mly"
    ( Value(string_of_int i ^ String.of_seq (List.to_seq s)) )
# 777 "parser.ml"
     : (Ast.value))

let _menhir_action_58 =
  fun vl ->
    (
# 118 "parser.mly"
    ( vl )
# 785 "parser.ml"
     : (Ast.value list))

let _menhir_action_59 =
  fun v_attrs v_name v_objs v_sigs ->
    (
# 48 "parser.mly"
    ( Vertex(v_name, v_attrs, v_sigs, v_objs) )
# 793 "parser.ml"
     : (Ast.vertex))

let _menhir_action_60 =
  fun v ->
    (
# 44 "parser.mly"
    ( v )
# 801 "parser.ml"
     : (Ast.vertex list))

let _menhir_action_61 =
  fun i s1 s2 ->
    (
# 52 "parser.mly"
    ( String.of_seq (List.to_seq s1) ^ string_of_int i ^ String.of_seq (List.to_seq s2) )
# 809 "parser.ml"
     : (String.t))

let _menhir_action_62 =
  fun s ->
    (
# 54 "parser.mly"
    ( String.of_seq (List.to_seq s) )
# 817 "parser.ml"
     : (String.t))

let _menhir_action_63 =
  fun s ->
    (
# 56 "parser.mly"
    ( s )
# 825 "parser.ml"
     : (String.t))

let _menhir_action_64 =
  fun s1 s2 s3 s4 ->
    (
# 58 "parser.mly"
    ( String.of_seq (List.to_seq s1) ^ string_of_int s2 ^ String.of_seq (List.to_seq s3) ^ string_of_int s4 )
# 833 "parser.ml"
     : (String.t))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | CHAR _ ->
        "CHAR"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | EDGE ->
        "EDGE"
    | EOF ->
        "EOF"
    | FROM ->
        "FROM"
    | INT _ ->
        "INT"
    | LEFT_BRACE ->
        "LEFT_BRACE"
    | LEFT_BRACK ->
        "LEFT_BRACK"
    | LEFT_PAREN ->
        "LEFT_PAREN"
    | PORT ->
        "PORT"
    | RIGHT_BRACE ->
        "RIGHT_BRACE"
    | RIGHT_BRACK ->
        "RIGHT_BRACK"
    | RIGHT_PAREN ->
        "RIGHT_PAREN"
    | STRING _ ->
        "STRING"
    | SYSTEMGRAPH ->
        "SYSTEMGRAPH"
    | TO ->
        "TO"
    | VERTEX ->
        "VERTEX"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_goto_main : type  ttv_stack. ttv_stack -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      MenhirBox_main _v
  
  let rec _menhir_run_110_spec_088 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_vertex_list -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let _v =
        let e = _v in
        _menhir_action_14 e
      in
      let MenhirCell1_vertex_list (_menhir_stack, _, v) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_55 e v in
      let s = _v in
      let _v = _menhir_action_27 s in
      _menhir_goto_main _menhir_stack _v
  
  let rec _menhir_run_114 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_edge -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let MenhirCell1_edge (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_18 x xs in
      _menhir_goto_list_edge_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_edge_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState113 ->
          _menhir_run_114 _menhir_stack _v
      | MenhirState088 ->
          _menhir_run_110_spec_088 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_003 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VERTEX (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let s = _v in
          let _v = _menhir_action_63 s in
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState003 _tok
      | CHAR _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState003
      | INT _ | LEFT_BRACK ->
          let _v = _menhir_action_15 () in
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState003 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_007 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_vertex_name (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LEFT_BRACK ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CHAR _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState008
          | COLON | COMMA ->
              let _v = _menhir_action_15 () in
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState008 _tok
          | RIGHT_BRACK ->
              let _v = _menhir_action_21 () in
              _menhir_run_010_spec_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_005 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_CHAR (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | CHAR _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | COLON | COMMA | EDGE | INT _ | LEFT_BRACK | PORT | RIGHT_BRACE | RIGHT_BRACK | RIGHT_PAREN | TO ->
          let _v = _menhir_action_15 () in
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_006 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_CHAR -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_CHAR (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_16 x xs in
      _menhir_goto_list_CHAR_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_CHAR_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState102 ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState104 ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState108 ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState085 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState003 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState076 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState093 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState106 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState095 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState035 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState073 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState048 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState031 ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState028 ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState025 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState019 ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState016 ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState008 ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState005 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_103 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_list_CHAR_ _menhir_cell0_INT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_INT (_menhir_stack, i) = _menhir_stack in
      let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
      let s2 = _v in
      let _v = _menhir_action_39 i s1 s2 in
      _menhir_goto_port _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_port : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_signal as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let x = _v in
      let _v = _menhir_action_30 x in
      _menhir_goto_option_port_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_option_port_ : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_signal as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState108 ->
          _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState104 ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_109 : type  ttv_stack. (((((ttv_stack, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_option_port_, _menhir_box_main) _menhir_cell1_signal -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_signal (_menhir_stack, _, e_to) = _menhir_stack in
      let MenhirCell1_option_port_ (_menhir_stack, _, e_from_port) = _menhir_stack in
      let MenhirCell1_signal (_menhir_stack, _, e_from) = _menhir_stack in
      let MenhirCell1_attr_list (_menhir_stack, _, e_attrs) = _menhir_stack in
      let MenhirCell1_EDGE (_menhir_stack, _menhir_s) = _menhir_stack in
      let e_to_port = _v in
      let _v = _menhir_action_10 e_attrs e_from e_from_port e_to e_to_port in
      _menhir_goto_edge _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_edge : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_edge (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EDGE ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | RIGHT_BRACE ->
          let _v = _menhir_action_17 () in
          _menhir_run_114 _menhir_stack _v
      | _ ->
          _eRR ()
  
  and _menhir_run_089 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_EDGE (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LEFT_BRACK ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CHAR _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState090
          | COLON | COMMA ->
              let _v = _menhir_action_15 () in
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState090 _tok
          | RIGHT_BRACK ->
              let _v = _menhir_action_21 () in
              _menhir_run_010_spec_090 _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_011 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CHAR _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState013
              | COLON | COMMA | RIGHT_BRACK ->
                  let _v = _menhir_action_15 () in
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState013 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA | RIGHT_BRACK ->
          let s1 = _v in
          let _v = _menhir_action_01 s1 in
          _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_014 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CHAR _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState016
              | COLON | COMMA | RIGHT_BRACK ->
                  let _v = _menhir_action_15 () in
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState016 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA | RIGHT_BRACK ->
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s2 = _v in
          let _v = _menhir_action_02 s1 s2 in
          _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_017 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CHAR _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState019
              | COLON | COMMA | RIGHT_BRACK ->
                  let _v = _menhir_action_15 () in
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState019 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA | RIGHT_BRACK ->
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s3 = _v in
          let _v = _menhir_action_03 s1 s2 s3 in
          _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_020 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CHAR _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState022
              | COLON | COMMA | RIGHT_BRACK ->
                  let _v = _menhir_action_15 () in
                  _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState022 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA | RIGHT_BRACK ->
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s3) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s4 = _v in
          let _v = _menhir_action_04 s1 s2 s3 s4 in
          _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_023 : type  ttv_stack. (((((ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CHAR _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState025
              | COLON | COMMA | RIGHT_BRACK ->
                  let _v = _menhir_action_15 () in
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState025 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA | RIGHT_BRACK ->
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s4) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s3) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s5 = _v in
          let _v = _menhir_action_05 s1 s2 s3 s4 s5 in
          _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_026 : type  ttv_stack. ((((((ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CHAR _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState028
              | COLON | COMMA | RIGHT_BRACK ->
                  let _v = _menhir_action_15 () in
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState028 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA | RIGHT_BRACK ->
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s5) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s4) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s3) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s6 = _v in
          let _v = _menhir_action_06 s1 s2 s3 s4 s5 s6 in
          _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_029 : type  ttv_stack. (((((((ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CHAR _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState031
              | COMMA | RIGHT_BRACK ->
                  let _v = _menhir_action_15 () in
                  _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA | RIGHT_BRACK ->
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s6) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s5) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s4) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s3) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s7 = _v in
          let _v = _menhir_action_07 s1 s2 s3 s4 s5 s6 s7 in
          _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack. (((((((ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_, _menhir_box_main) _menhir_cell1_list_CHAR_ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_list_CHAR_ (_menhir_stack, _, s7) = _menhir_stack in
      let MenhirCell1_list_CHAR_ (_menhir_stack, _, s6) = _menhir_stack in
      let MenhirCell1_list_CHAR_ (_menhir_stack, _, s5) = _menhir_stack in
      let MenhirCell1_list_CHAR_ (_menhir_stack, _, s4) = _menhir_stack in
      let MenhirCell1_list_CHAR_ (_menhir_stack, _, s3) = _menhir_stack in
      let MenhirCell1_list_CHAR_ (_menhir_stack, _, s2) = _menhir_stack in
      let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
      let s8 = _v in
      let _v = _menhir_action_08 s1 s2 s3 s4 s5 s6 s7 s8 in
      _menhir_goto_attr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_attr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_attr (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CHAR _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState082
          | COLON | COMMA | RIGHT_BRACK ->
              let _v = _menhir_action_15 () in
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState082 _tok
          | _ ->
              _eRR ())
      | RIGHT_BRACK ->
          let x = _v in
          let _v = _menhir_action_42 x in
          _menhir_goto_separated_nonempty_list_COMMA_attr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_attr_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState082 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState090 ->
          _menhir_run_009_spec_090 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState008 ->
          _menhir_run_009_spec_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_083 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_attr -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_attr (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_43 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_attr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_009_spec_090 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_EDGE -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_22 x in
      _menhir_run_010_spec_090 _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_010_spec_090 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_EDGE -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _v =
        let xs = _v in
        _menhir_action_09 xs
      in
      let _menhir_stack = MenhirCell1_attr_list (_menhir_stack, MenhirState090, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | FROM ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let s = _v_0 in
              let _v = _menhir_action_52 s in
              _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState093 _tok
          | CHAR _v_2 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState093
          | INT _ | PORT | TO ->
              let _v = _menhir_action_15 () in
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState093 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_094 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_signal (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TO ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let s = _v_0 in
              let _v = _menhir_action_52 s in
              _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState095 _tok
          | CHAR _v_2 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState095
          | EDGE | INT _ | PORT | RIGHT_BRACE ->
              let _v = _menhir_action_15 () in
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState095 _tok
          | _ ->
              _eRR ())
      | PORT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_4 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_5 =
                let s = _v_4 in
                _menhir_action_41 s
              in
              let x = _v_5 in
              let _v = _menhir_action_30 x in
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState104 _tok
          | CHAR _v_7 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_7 MenhirState104
          | INT _ ->
              let _v = _menhir_action_15 () in
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState104 _tok
          | TO ->
              let _v = _menhir_action_29 () in
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState104 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_096 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PORT ->
          let _menhir_stack = MenhirCell1_signal (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_1 =
                let s = _v_0 in
                _menhir_action_41 s
              in
              let x = _v_1 in
              let _v = _menhir_action_30 x in
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | CHAR _v_3 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState097
          | INT _ ->
              let _v = _menhir_action_15 () in
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState097 _tok
          | EDGE | RIGHT_BRACE ->
              let _v = _menhir_action_29 () in
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | EDGE | RIGHT_BRACE ->
          let MenhirCell1_signal (_menhir_stack, _, e_from) = _menhir_stack in
          let MenhirCell1_attr_list (_menhir_stack, _, e_attrs) = _menhir_stack in
          let MenhirCell1_EDGE (_menhir_stack, _menhir_s) = _menhir_stack in
          let e_to = _v in
          let _v = _menhir_action_13 e_attrs e_from e_to in
          _menhir_goto_edge _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_100 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_signal -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_signal (_menhir_stack, _, e_to) = _menhir_stack in
      let MenhirCell1_signal (_menhir_stack, _, e_from) = _menhir_stack in
      let MenhirCell1_attr_list (_menhir_stack, _, e_attrs) = _menhir_stack in
      let MenhirCell1_EDGE (_menhir_stack, _menhir_s) = _menhir_stack in
      let e_to_port = _v in
      let _v = _menhir_action_12 e_attrs e_from e_to e_to_port in
      _menhir_goto_edge _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_101 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_signal as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | INT _v_0 ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell0_INT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CHAR _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState102
          | EDGE | RIGHT_BRACE | TO ->
              let _v = _menhir_action_15 () in
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | EDGE | RIGHT_BRACE | TO ->
          let s = _v in
          let _v = _menhir_action_40 s in
          _menhir_goto_port _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_075 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | INT _v_0 ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell0_INT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CHAR _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState076
          | COMMA | EDGE | INT _ | PORT | RIGHT_BRACE | RIGHT_PAREN | TO ->
              let _v = _menhir_action_15 () in
              _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | COMMA | EDGE | PORT | RIGHT_BRACE | RIGHT_PAREN | TO ->
          let s = _v in
          let _v = _menhir_action_50 s in
          _menhir_goto_signal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_077 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_list_CHAR_ _menhir_cell0_INT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | INT _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_INT (_menhir_stack, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let (s3, s4) = (_v, _v_0) in
          let _v = _menhir_action_53 s1 s2 s3 s4 in
          _menhir_goto_signal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COMMA | EDGE | PORT | RIGHT_BRACE | RIGHT_PAREN | TO ->
          let MenhirCell0_INT (_menhir_stack, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s3 = _v in
          let _v = _menhir_action_51 s1 s2 s3 in
          _menhir_goto_signal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_signal : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState106 ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState095 ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState093 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState073 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState035 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_107 : type  ttv_stack. (((((ttv_stack, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal, _menhir_box_main) _menhir_cell1_option_port_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PORT ->
          let _menhir_stack = MenhirCell1_signal (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_1 =
                let s = _v_0 in
                _menhir_action_41 s
              in
              let x = _v_1 in
              let _v = _menhir_action_30 x in
              _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | CHAR _v_3 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState108
          | INT _ ->
              let _v = _menhir_action_15 () in
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState108 _tok
          | EDGE | RIGHT_BRACE ->
              let _v = _menhir_action_29 () in
              _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | EDGE | RIGHT_BRACE ->
          let MenhirCell1_option_port_ (_menhir_stack, _, e_from_port) = _menhir_stack in
          let MenhirCell1_signal (_menhir_stack, _, e_from) = _menhir_stack in
          let MenhirCell1_attr_list (_menhir_stack, _, e_attrs) = _menhir_stack in
          let MenhirCell1_EDGE (_menhir_stack, _menhir_s) = _menhir_stack in
          let e_to = _v in
          let _v = _menhir_action_11 e_attrs e_from e_from_port e_to in
          _menhir_goto_edge _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_072 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_signal (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let s = _v_0 in
              let _v = _menhir_action_52 s in
              _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState073 _tok
          | CHAR _v_2 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState073
          | COMMA | INT _ | RIGHT_PAREN ->
              let _v = _menhir_action_15 () in
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState073 _tok
          | _ ->
              _eRR ())
      | RIGHT_PAREN ->
          let x = _v in
          let _v = _menhir_action_46 x in
          _menhir_goto_separated_nonempty_list_COMMA_signal_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_signal_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState035 ->
          _menhir_run_079_spec_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState073 ->
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_079_spec_035 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name, _menhir_box_main) _menhir_cell1_attr_list -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_26 x in
      _menhir_run_080_spec_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_080_spec_035 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name, _menhir_box_main) _menhir_cell1_attr_list -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let xs = _v in
      let _v = _menhir_action_54 xs in
      let _menhir_s = MenhirState035 in
      let _menhir_stack = MenhirCell1_signal_list (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LEFT_BRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState039
          | RIGHT_BRACE ->
              let _v = _menhir_action_23 () in
              _menhir_run_065_spec_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_stack = MenhirCell1_STRING (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | RIGHT_BRACE | RIGHT_BRACK ->
          let k = _v in
          let _v = _menhir_action_31 k in
          _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_041 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_STRING -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let s = _v in
          let _v = _menhir_action_56 s in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LEFT_BRACK ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v ->
              let _menhir_stack = MenhirCell1_LEFT_BRACK (_menhir_stack, MenhirState041) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | COLON ->
                  let _menhir_stack = MenhirCell1_STRING (_menhir_stack, MenhirState043, _v) in
                  _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
              | COMMA | RIGHT_BRACK ->
                  let (_menhir_s, k) = (MenhirState043, _v) in
                  let _v = _menhir_action_31 k in
                  _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | LEFT_BRACK ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | STRING _v ->
                  let _menhir_stack = MenhirCell1_LEFT_BRACK (_menhir_stack, MenhirState041) in
                  let _menhir_stack = MenhirCell1_LEFT_BRACK (_menhir_stack, MenhirState043) in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let s = _v in
                  let _v = _menhir_action_56 s in
                  _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState045 _tok
              | RIGHT_BRACK ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | RIGHT_BRACK ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let MenhirCell1_STRING (_menhir_stack, _menhir_s, k) = _menhir_stack in
                      let _v = _menhir_action_34 k in
                      _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
                  | _ ->
                      _eRR ())
              | INT _v ->
                  let _menhir_stack = MenhirCell1_LEFT_BRACK (_menhir_stack, MenhirState041) in
                  let _menhir_stack = MenhirCell1_LEFT_BRACK (_menhir_stack, MenhirState043) in
                  _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState045
              | _ ->
                  _eRR ())
          | INT _v ->
              let _menhir_stack = MenhirCell1_LEFT_BRACK (_menhir_stack, MenhirState041) in
              _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState043
          | RIGHT_BRACK ->
              let _menhir_stack = MenhirCell1_LEFT_BRACK (_menhir_stack, MenhirState041) in
              let _v = _menhir_action_23 () in
              _menhir_run_065_spec_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | LEFT_BRACE ->
          let _menhir_stack = MenhirCell1_LEFT_BRACE (_menhir_stack, MenhirState041) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState066
          | RIGHT_BRACE ->
              let _v = _menhir_action_23 () in
              _menhir_run_065_spec_066 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | INT _v ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState041
      | _ ->
          _eRR ()
  
  and _menhir_run_069 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_STRING -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_STRING (_menhir_stack, _menhir_s, k) = _menhir_stack in
      let v = _v in
      let _v = _menhir_action_32 k v in
      _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_param : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_param (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState063
          | _ ->
              _eRR ())
      | RIGHT_BRACE | RIGHT_BRACK ->
          let x = _v in
          let _v = _menhir_action_44 x in
          _menhir_goto_separated_nonempty_list_COMMA_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_param_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState063 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState039 ->
          _menhir_run_059_spec_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState066 ->
          _menhir_run_059_spec_066 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState043 ->
          _menhir_run_059_spec_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_064 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_param -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_param (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_45 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_059_spec_039 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal_list -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_24 x in
      _menhir_run_065_spec_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_065_spec_039 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal_list -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _v =
        let xs = _v in
        _menhir_action_38 xs
      in
      match (_tok : MenhirBasics.token) with
      | RIGHT_BRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_signal_list (_menhir_stack, _, v_sigs) = _menhir_stack in
          let MenhirCell1_attr_list (_menhir_stack, _, v_attrs) = _menhir_stack in
          let MenhirCell1_vertex_name (_menhir_stack, _, v_name) = _menhir_stack in
          let MenhirCell1_VERTEX (_menhir_stack, _menhir_s) = _menhir_stack in
          let v_objs = _v in
          let _v = _menhir_action_59 v_attrs v_name v_objs v_sigs in
          let _menhir_stack = MenhirCell1_vertex (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | VERTEX ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState115
          | EDGE | RIGHT_BRACE ->
              let _v = _menhir_action_19 () in
              _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_116 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_vertex -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_vertex (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_20 x xs in
      _menhir_goto_list_vertex_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_vertex_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState002 ->
          _menhir_run_117_spec_002 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState115 ->
          _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_117_spec_002 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let v = _v in
      let _v = _menhir_action_60 v in
      let _menhir_s = MenhirState002 in
      let _menhir_stack = MenhirCell1_vertex_list (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EDGE ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
      | RIGHT_BRACE ->
          let _v = _menhir_action_17 () in
          _menhir_run_110_spec_088 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_059_spec_066 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACE -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_24 x in
      _menhir_run_065_spec_066 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_065_spec_066 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACE -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _v =
        let xs = _v in
        _menhir_action_38 xs
      in
      match (_tok : MenhirBasics.token) with
      | RIGHT_BRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LEFT_BRACE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_STRING (_menhir_stack, _menhir_s, k) = _menhir_stack in
          let p = _v in
          let _v = _menhir_action_37 k p in
          _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_059_spec_043 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACK -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_24 x in
      _menhir_run_065_spec_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_065_spec_043 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACK -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _v =
        let xs = _v in
        _menhir_action_38 xs
      in
      match (_tok : MenhirBasics.token) with
      | RIGHT_BRACK ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LEFT_BRACK (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_STRING (_menhir_stack, _menhir_s, k) = _menhir_stack in
          let p = _v in
          let _v = _menhir_action_36 k p in
          _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_053 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_value (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let s = _v_0 in
              let _v = _menhir_action_56 s in
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState054 _tok
          | INT _v_2 ->
              _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState054
          | _ ->
              _eRR ())
      | RIGHT_BRACK ->
          let x = _v in
          let _v = _menhir_action_48 x in
          _menhir_goto_separated_nonempty_list_COMMA_value_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_048 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_INT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | CHAR _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState048
      | COMMA | RIGHT_BRACE | RIGHT_BRACK ->
          let _v = _menhir_action_15 () in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_049 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_INT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_INT (_menhir_stack, _menhir_s, i) = _menhir_stack in
      let s = _v in
      let _v = _menhir_action_57 i s in
      _menhir_goto_value _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_value : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState041 ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState043 ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState045 ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_value_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState043 ->
          _menhir_run_056_spec_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState045 ->
          _menhir_run_056_spec_045 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState054 ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_056_spec_043 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACK -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _v =
        let vl = _v in
        _menhir_action_58 vl
      in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LEFT_BRACK (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_STRING (_menhir_stack, _menhir_s, k) = _menhir_stack in
      let vl = _v in
      let _v = _menhir_action_33 k vl in
      _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_056_spec_045 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_STRING, _menhir_box_main) _menhir_cell1_LEFT_BRACK, _menhir_box_main) _menhir_cell1_LEFT_BRACK -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _v =
        let vl = _v in
        _menhir_action_58 vl
      in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | RIGHT_BRACK ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LEFT_BRACK (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_LEFT_BRACK (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_STRING (_menhir_stack, _menhir_s, k) = _menhir_stack in
          let vl = _v in
          let _v = _menhir_action_35 k vl in
          _menhir_goto_param _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_055 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_value -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_value (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_49 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_value_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_074 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_signal -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_signal (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_47 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_signal_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_105 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_EDGE, _menhir_box_main) _menhir_cell1_attr_list, _menhir_box_main) _menhir_cell1_signal as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option_port_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TO ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let s = _v_0 in
              let _v = _menhir_action_52 s in
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState106 _tok
          | CHAR _v_2 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState106
          | EDGE | INT _ | PORT | RIGHT_BRACE ->
              let _v = _menhir_action_15 () in
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState106 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_009_spec_008 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_22 x in
      _menhir_run_010_spec_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_010_spec_008 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_vertex_name -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _v =
        let xs = _v in
        _menhir_action_09 xs
      in
      let _menhir_stack = MenhirCell1_attr_list (_menhir_stack, MenhirState008, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LEFT_PAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let s = _v_0 in
              let _v = _menhir_action_52 s in
              _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState035 _tok
          | CHAR _v_2 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState035
          | COMMA | INT _ ->
              let _v = _menhir_action_15 () in
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState035 _tok
          | RIGHT_PAREN ->
              let _v = _menhir_action_25 () in
              _menhir_run_080_spec_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_086 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX, _menhir_box_main) _menhir_cell1_list_CHAR_ _menhir_cell0_INT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | INT _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_INT (_menhir_stack, s2) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let (s3, s4) = (_v, _v_0) in
          let _v = _menhir_action_64 s1 s2 s3 s4 in
          _menhir_goto_vertex_name _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LEFT_BRACK ->
          let MenhirCell0_INT (_menhir_stack, i) = _menhir_stack in
          let MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, s1) = _menhir_stack in
          let s2 = _v in
          let _v = _menhir_action_61 i s1 s2 in
          _menhir_goto_vertex_name _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_vertex_name : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_084 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_VERTEX as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | INT _v_0 ->
          let _menhir_stack = MenhirCell1_list_CHAR_ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell0_INT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CHAR _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState085
          | INT _ | LEFT_BRACK ->
              let _v = _menhir_action_15 () in
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | LEFT_BRACK ->
          let s = _v in
          let _v = _menhir_action_62 s in
          _menhir_goto_vertex_name _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  let rec _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SYSTEMGRAPH ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LEFT_BRACE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VERTEX ->
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
              | EDGE | RIGHT_BRACE ->
                  let _v = _menhir_action_19 () in
                  _menhir_run_117_spec_002 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | EOF ->
          let _v = _menhir_action_28 () in
          _menhir_goto_main _menhir_stack _v
      | _ ->
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
