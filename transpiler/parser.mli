
(* The type of tokens. *)

type token = 
  | VERTEX
  | TO
  | SYSTEMGRAPH
  | STRING of (string)
  | RIGHT_PAREN
  | RIGHT_BRACK
  | RIGHT_BRACE
  | PORT
  | LEFT_PAREN
  | LEFT_BRACK
  | LEFT_BRACE
  | INT of (int)
  | FROM
  | EOF
  | EDGE
  | COMMA
  | COLON
  | CHAR of (char)

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.systemgraph option)
