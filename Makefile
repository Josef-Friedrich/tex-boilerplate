jobname = cloze
texmf = $(HOME)/texmf
texmftex = $(texmf)/tex/luatex
installdir = $(texmftex)/$(jobname)

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

clean:
	git clean -fdx

.PHONY: all install doc doc_pdf doc_lua test test_luatex test_lualatex clean ctan
