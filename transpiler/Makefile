.PHONY: all clean
all:
	ocamlbuild -use-menhir -no-hygiene -pkgs 'core,str' transpiler.native
	mv transpiler.native transpiler
clean:
	ocamlbuild -clean
	$(RM) -rf _build
