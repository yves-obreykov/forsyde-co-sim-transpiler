(* File transpiler.ml *)

open Lexer
open Ast
open Lexing
open Printf
open Hybrid_ir
open C_maker

let print_position out_channel lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf out_channel "%s:%d:%d" 
         pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf sequence sizes =
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
  print_endline ("AST is done");
  print_endline ("AST is: ");
  print_endline (pprint_systemgraph res);
  print_endline ("Making hybrid IR...");
  let res2 = make_hybrid_ir res
  in
  print_endline ("Making hybrid IR is done");
  print_endline ("Hybrid IR is: ");
  print_endline (pprint_hybrid_ir res2);
  print_endline ("Making C code...");
  make_c_code sequence sizes res2;
  print_endline ("Making C code is done")


let rec find_sequence lexbuf =
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
  (find_super_loop res, find_sdf_channel_sizes res) 
  



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

  let filename2 = Sys.argv.(2) in
  print_endline "The solved sequence is in file:";
  print_endline filename2;
  print_endline " ";
  let in_channel2 = Core.In_channel.create filename2 in
  let lexbuf2 = Lexing.from_channel in_channel2 in
  lexbuf2.lex_curr_p <- 
    { lexbuf2.lex_curr_p with pos_fname = filename2 };
  let (sequence, sizes) = find_sequence lexbuf2 in
  parse_with_error lexbuf sequence sizes;
  print_endline "The sequence is:";
  List.iter print_endline sequence;
  print_endline "The channel sizes are:";
  List.iter print_endline sizes;
  In_channel.close in_channel;
  In_channel.close in_channel2;
  