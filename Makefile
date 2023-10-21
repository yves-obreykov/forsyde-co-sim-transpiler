.PHONY: all clean
all:
	ocamlbuild -use-menhir -no-hygiene -pkg core transpiler.native
	mv transpiler.native transpiler
clean:
	ocamlbuild -clean
	$(RM) -rf _build
