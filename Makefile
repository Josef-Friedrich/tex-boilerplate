jobname = boilerplate
texmf = $(HOME)/texmf
texmftex = $(texmf)/tex/luatex
installdir = $(texmftex)/$(jobname)

all: install doc

install: uninstall_texlive install_quick

uninstall_texlive:
	-tlmgr uninstall --force boilerplate

install_quick:
	mkdir -p $(installdir)
	cp -f $(jobname).lua $(installdir)
	cp -f $(jobname).sty $(installdir)
	cp -f $(jobname).tex $(installdir)

doc: doc_pdf doc_lua

doc_pdf:
	lualatex --shell-escape documentation.tex
	makeindex -s gglo.ist -o documentation.gls documentation.glo
	makeindex -s gind.ist -o documentation.ind documentation.idx
	lualatex --shell-escape documentation.tex
	mkdir -p $(texmf)/doc
	cp documentation.pdf $(texmf)/doc/$(jobname).pdf

doc_lua:
	ldoc .

doc_lua_open:
	ldoc .
	xdg-open docs/index.html

ctan: doc_pdf
	rm -rf $(jobname).tar.gz
	rm -rf $(jobname)/
	mkdir $(jobname)
	cp -f README.md $(jobname)/
	cp -f $(jobname).lua $(jobname)/
	cp -f $(jobname).sty $(jobname)/
	cp -f $(jobname).tex $(jobname)/
	cp -f documentation.pdf $(jobname)/$(jobname).pdf
	cp -f documentation.tex $(jobname)/
	tar cvfz $(jobname).tar.gz $(jobname)
	rm -rf $(jobname)

# test: install test_lua test_examples test_tex doc_pdf
test: install test_lua

test_lua:
	busted --lua=/usr/bin/lua5.3 --exclude-tags=skip tests/lua/test-*.lua

test_examples: test_examples_lua test_examples_plain test_examples_latex
test_examples_lua:
	busted --pattern "**/*.lua" examples
test_examples_plain:
	find examples -iname "*plain.tex" -exec luatex --output-dir=examples {} \;
test_examples_latex:
	find examples -iname "*latex.tex" -exec latexmk -lualatex -cd --output-directory=examples {} \;

test_tex: test_tex_plain test_tex_latex
test_tex_plain:
	find tests/tex/plain -iname "*.tex" -exec luatex --output-dir=tests/tex/plain {} \;
test_tex_latex:
	find tests/tex/latex -iname "*.tex" -exec lualatex --output-dir=tests/tex/latex {} \;

clean:
	git clean -d -x --force

.PHONY: all install doc doc_pdf doc_lua test test_luatex test_lualatex clean ctan
