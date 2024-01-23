.PHONY: all clean docs
all:
	ocamlbuild -use-menhir -no-hygiene -pkgs 'core,str' transpiler.native
	mv transpiler.native transpiler
clean:
	ocamlbuild -clean
	$(RM) -rf _build
docs:
	ocamllex lexer.mll
	ocamlc -c ast.ml
	menhir --infer parser.mly
	ocamlc -c parser.mli
	ocamlc -c parser.ml
	ocamlc -c ast.ml
	ocamlc -c hybrid_ir.ml
	ocamlc -c c_maker.ml
	ocamlc -c lexer.ml
	ocamlfind ocamlc -c -I . -package core transpiler.ml
	ocamlfind ocamldoc -d docs -html -I . -package core  ast.ml c_maker.ml hybrid_ir.ml lexer.ml parser.ml transpiler.ml
