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
%token NEWLINE
%token UNDERSCORE
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

attr_list:
    al = separated_list(COMMA, attr)
    { al }

attr:
  | s1 = CHAR* COLON COLON s2 = CHAR*
    { AttributeTwo(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2)) }
  | s1 = CHAR* COLON COLON s2 = CHAR* COLON COLON s3 = CHAR*
    { AttributeThree(String.of_seq (List.to_seq s1) , String.of_seq (List.to_seq s2) , String.of_seq (List.to_seq s3)) }

signal_list:
  | sl = separated_list(COMMA, signal)
    { sl }

signal:
  | s = CHAR*
    { Signal(String.of_seq (List.to_seq s)) }
  | s1 = CHAR* s2 = INT s3 = CHAR*
    { Signal(String.of_seq (List.to_seq s1) ^ string_of_int s2 ^ String.of_seq (List.to_seq s3)) }

param_list:
  | p = separated_list(COMMA, param)
    { p }

param:
  | k = STRING COLON v = value
    { ParamLeaf(k, v) }
  | k = STRING COLON "{" p = param_list "}"
    { ParamNode(k, p) }

value:
  | i = INT UNDERSCORE c = CHAR
    { Value(i, c) }
  
/* edge_list is a list of edges */
edge_list:
  | e = edge*
    { e }

edge:
  | EDGE "[" e_attrs = attr_list "]" "from" e_from = signal "port" e_from_port = port "to" e_to = signal "port" e_to_port = port
    { Edge(e_attrs, e_from, e_from_port, e_to, e_to_port) }

port:
  | s1 = CHAR* i = INT s2=CHAR*
    { Port(String.of_seq (List.to_seq s1) ^ string_of_int i ^ String.of_seq (List.to_seq s2)) }
  | s = CHAR*
    { Port(String.of_seq (List.to_seq s)) } 
