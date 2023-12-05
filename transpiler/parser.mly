/* File parser.mly */
%{
    open Ast
%}

%token <int> INT
%token <char> CHAR
%token <string> STRING
%token LEFT_BRACE "{"
%token RIGHT_BRACE "}"
%token LEFT_BRACK "["
%token RIGHT_BRACK "]"
%token LEFT_PAREN "("
%token RIGHT_PAREN ")"
%token COLON ":"
%token COMMA ","
%token EOF
%token SYSTEMGRAPH
%token VERTEX
%token EDGE
%token FROM "from"
%token TO "to"
%token PORT "port"

/* %start systemgraph */
%start main
%type <'a option> main

%%
main:
  | s = systemgraph
    { Some s }
  | EOF
    { None }

/* systemgraph is a list of vertices and edges */
systemgraph:
    | SYSTEMGRAPH "{" v = vertex_list e = edge_list "}"
      { Systemgraph(v,e) }

/* vertex_list is a list of vertices */
vertex_list:
  | v = vertex*
    { v }

vertex:
  | VERTEX v_name = vertex_name "[" v_attrs = attr_list "]" "(" v_sigs = signal_list ")" "{" v_objs = param_list "}" 
    { Vertex(v_name, v_attrs, v_sigs, v_objs) }

vertex_name:
  | s1 = CHAR* i = INT s2=CHAR*
    { String.of_seq (List.to_seq s1) ^ string_of_int i ^ String.of_seq (List.to_seq s2) } 
  | s = CHAR*
    { String.of_seq (List.to_seq s) }
  | s = STRING
    { s }
  | s1 = CHAR* s2 = INT s3 = CHAR* s4 = INT
    { String.of_seq (List.to_seq s1) ^ string_of_int s2 ^ String.of_seq (List.to_seq s3) ^ string_of_int s4 }

attr_list:
    al = separated_list(COMMA, attr)
    { al }

attr:
  | s1 = CHAR*
    { AttributeOne(String.of_seq (List.to_seq s1)) }
  | s1 = CHAR* COLON COLON s2 = CHAR*
    { AttributeTwo(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2)) }
  | s1 = CHAR* COLON COLON s2 = CHAR* COLON COLON s3 = CHAR*
    { AttributeThree(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3)) }
  | s1 = CHAR* COLON COLON s2 = CHAR* COLON COLON s3 = CHAR* COLON COLON s4 = CHAR*
    { AttributeFour(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4)) }
  | s1 = CHAR* COLON COLON s2 = CHAR* COLON COLON s3 = CHAR* COLON COLON s4 = CHAR* COLON COLON s5 = CHAR*
    { AttributeFive(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5)) }
  | s1 = CHAR* COLON COLON s2 = CHAR* COLON COLON s3 = CHAR* COLON COLON s4 = CHAR* COLON COLON s5 = CHAR* COLON COLON s6 = CHAR*
    { AttributeSix(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5) , String.of_seq (List.to_seq s6)) }
  | s1 = CHAR* COLON COLON s2 = CHAR* COLON COLON s3 = CHAR* COLON COLON s4 = CHAR* COLON COLON s5 = CHAR* COLON COLON s6 = CHAR* COLON COLON s7 = CHAR*
    { AttributeSeven(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5) , String.of_seq (List.to_seq s6) , String.of_seq (List.to_seq s7)) }
  | s1 = CHAR* COLON COLON s2 = CHAR* COLON COLON s3 = CHAR* COLON COLON s4 = CHAR* COLON COLON s5 = CHAR* COLON COLON s6 = CHAR* COLON COLON s7 = CHAR* COLON COLON s8 = CHAR*
    { AttributeEight(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3) , String.of_seq (List.to_seq s4) , String.of_seq (List.to_seq s5) , String.of_seq (List.to_seq s6) , String.of_seq (List.to_seq s7) , String.of_seq (List.to_seq s8)) }

signal_list:
  | sl = separated_list(COMMA, signal)
    { sl }

signal:
  | s = CHAR*
    { Signal(String.of_seq (List.to_seq s)) }
  | s1 = CHAR* s2 = INT s3 = CHAR*
    { Signal(String.of_seq (List.to_seq s1) ^ string_of_int s2 ^ String.of_seq (List.to_seq s3)) }
  | s = STRING
    { Signal(s) }
  | s1 = CHAR* s2 = INT s3 = CHAR* s4 = INT
    { Signal(String.of_seq (List.to_seq s1) ^ string_of_int s2 ^ String.of_seq (List.to_seq s3) ^ string_of_int s4) }

param_list:
  | p = separated_list(COMMA, param)
    { p }

param:
  | k = STRING
    { ParamLeaf(k, [Value("")]) }
  | k = STRING COLON v = value
    { ParamLeaf(k, [v]) }
  | k = STRING COLON "[" vl = value_list "]"
    { ParamLeaf(k, vl) }
  | k = STRING COLON "[" "[" "]" "]"
    { ParamLeaf(k, [Value("")]) }
  | k = STRING COLON "[" "[" vl = value_list "]" "]"
    { ParamLeaf(k, vl) }
  | k = STRING COLON "[" p = param_list "]"
    { ParamNode(k, p) }
  | k = STRING COLON "{" p = param_list "}"
    { ParamNode(k, p) }

value_list:
  | vl = separated_nonempty_list(COMMA, value)
    { vl }

value:
  | s = STRING
    { Value(s) }
  | i = INT s = CHAR*
    { Value(string_of_int i ^ String.of_seq (List.to_seq s)) }
  
/* edge_list is a list of edges */
edge_list:
  | e = edge*
    { e }

edge:
  | EDGE "[" e_attrs = attr_list "]" "from" e_from = signal "port" e_from_port = option(port) "to" e_to = signal "port" e_to_port = option(port)
    { Edge(e_attrs, e_from, e_from_port, e_to, e_to_port) }
  | EDGE "[" e_attrs = attr_list "]" "from" e_from = signal "port" e_from_port = option(port) "to" e_to = signal
    { Edge(e_attrs, e_from, e_from_port, e_to, None) }
  | EDGE "[" e_attrs = attr_list "]" "from" e_from = signal "to" e_to = signal "port" e_to_port = option(port)
    { Edge(e_attrs, e_from, None, e_to, e_to_port) }
  | EDGE "[" e_attrs = attr_list "]" "from" e_from = signal "to" e_to = signal
    { Edge(e_attrs, e_from, None, e_to, None) }

port:
  | s1 = CHAR* i = INT s2=CHAR*
    { Port(String.of_seq (List.to_seq s1) ^ string_of_int i ^ String.of_seq (List.to_seq s2)) }
  | s = CHAR*
    { Port(String.of_seq (List.to_seq s)) } 
  | s = STRING
    { Port(s) }
