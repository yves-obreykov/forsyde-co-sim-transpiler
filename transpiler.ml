(* File transpiler.ml *)

open Lexer
open Ast
open Lexing
open Printf

let print_position out_channel lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf out_channel "%s:%d:%d" 
         pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  let res =
    try
      Parser.main Lexer.read lexbuf
    with
    | SyntaxError msg ->
      fprintf stderr "%a: %s\n" print_position lexbuf msg; None
    | Parser.Error -> 
      fprintf stderr "%a: syntax error\n" print_position lexbuf;
      exit (-1)
  in
  print_endline (pprint_systemgraph res)

let () =
  print_endline "Welcome to the ForSyDe IO to C compiler!";
  let filename = Sys.argv.(1) in
  print_endline "The input file is:";
  print_endline filename;
  print_endline " ";
  let in_channel = Core.In_channel.create filename in
  let lexbuf = Lexing.from_channel in_channel in
  lexbuf.lex_curr_p <- 
    { lexbuf.lex_curr_p with pos_fname = filename };
  parse_with_error lexbuf;
  In_channel.close in_channel;