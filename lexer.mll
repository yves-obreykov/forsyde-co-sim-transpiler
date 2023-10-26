(* File lexer.mll *)

{
open Lexing
open Parser

exception SyntaxError of string

let incr_lineno lexbuf =
  let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <- 
    { 
      pos with
        pos_lnum = pos.pos_lnum + 1;
        pos_bol = pos.pos_cnum;
    }
}

let int = '-'? ['0'-'9'] ['0'-'9']*

let char = ['a'-'z' 'A'-'Z' '_']

let digit = ['0'-'9']
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let float = digit* frac? exp?

let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n" | "\n\r"
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule read =
  parse
  | " to "     {TO}
  | " from "   {FROM}
  | " port "   {PORT}
  | white    { read lexbuf }
  | newline  { incr_lineno lexbuf; read lexbuf }
  | int      { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | char     { CHAR (Lexing.lexeme lexbuf).[0] }
  | "systemgraph" {SYSTEMGRAPH}
  | "vertex" {VERTEX}
  | "edge"   {EDGE}
  | '"'      { read_string (Buffer.create 17) lexbuf }
  | '{'      { LEFT_BRACE }
  | '}'      { RIGHT_BRACE }
  | '['      { LEFT_BRACK }
  | ']'      { RIGHT_BRACK }
  | '('      { LEFT_PAREN }
  | ')'      { RIGHT_PAREN }
  | ':'      { COLON }
  | ','      { COMMA }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof      { EOF }
and read_string buf =
  parse
  | '"'       { STRING (Buffer.contents buf) }
  | '\\' '/'  { Buffer.add_char buf '/'; read_string buf lexbuf }
  | '\\' '\\' { Buffer.add_char buf '\\'; read_string buf lexbuf }
  | '\\' 'b'  { Buffer.add_char buf '\b'; read_string buf lexbuf }
  | '\\' 'f'  { Buffer.add_char buf '\012'; read_string buf lexbuf }
  | '\\' 'n'  { Buffer.add_char buf '\n'; read_string buf lexbuf }
  | '\\' 'r'  { Buffer.add_char buf '\r'; read_string buf lexbuf }
  | '\\' 't'  { Buffer.add_char buf '\t'; read_string buf lexbuf }
  | [^ '"' '\\']+
    {
      let lxm = (Lexing.lexeme lexbuf) in
      for i = 0 to String.length lxm - 1 do
        if lxm.[i] = '\n' then incr_lineno lexbuf
      done;
      Buffer.add_string buf lxm;
      read_string buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("String is not terminated")) }