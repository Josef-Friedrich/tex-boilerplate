# tex-project-boilerplate

## My other project boilerplates:

* [TeX](https://github.com/Josef-Friedrich/tex-project-boilerplate)
* [Python](https://github.com/Josef-Friedrich/python-project-boilerplate)

This material is subject to the [LaTeX Project Public License 1.3c](https://www.ctan.org/license/lppl1.3).

## Current version

2023/01/29 v0.1.0

## License

Copyright (C) 2023 by Josef Friedrich <josef@friedrich.rocks>
------------------------------------------------------------------------
This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3c of this license
or (at your option) any later version.  The latest version of this
license is in:

  http://www.latex-project.org/lppl.txt

and version 1.3c or later is part of all distributions of LaTeX
version 2008/05/04 or later.

## Maintainer

Josef Friedrich <josef@friedrich.rocks>

## Packaging

### CTAN

The `jobname` package has been included in the Comprehensive TeX Archive
Network (CTAN) since July 2015.

* [Package page](https://www.ctan.org/pkg/jobname)
* [Sources](https://www.ctan.org/tex-archive/macros/luatex/generic/jobname)

### Distributions

* TeX Live:
  * run files:
    * [jobname.lua](https://tug.org/svn/texlive/trunk/Master/texmf-dist/scripts/jobname/jobname.lua) texmf-dist/scripts/jobname/jobname.lua
    * [jobname.tex](https://tug.org/svn/texlive/trunk/Master/texmf-dist/tex/luatex/jobname/jobname.tex) texmf-dist/tex/luatex/jobname/jobname.tex
    * [jobname.sty](https://tug.org/svn/texlive/trunk/Master/texmf-dist/tex/luatex/jobname/jobname.sty) texmf-dist/tex/luatex/jobname/jobname.sty
  * doc files:
    * [jobname-doc.tex](https://tug.org/svn/texlive/trunk/Master/texmf-dist/doc/luatex/jobname/jobname.pdf) texmf-dist/doc/luatex/jobname/jobname-doc.tex
    * [jobname-doc.pdf](https://tug.org/svn/texlive/trunk/Master/texmf-dist/doc/luatex/jobname/jobname.pdf) texmf-dist/doc/luatex/jobname/jobname-doc.pdf
    * [README.md](https://tug.org/svn/texlive/trunk/Master/texmf-dist/doc/luatex/jobname/README.md) texmf-dist/doc/luatex/jobname/README.md
* [MiKTeX](https://miktex.org/packages/jobname)

### Repository

The [Git repository](https://github.com/Josef-Friedrich/jobname) in
which the development takes place is hosted on GitHub.

## Documentation

* [User documentation as a PDF](http://mirror.ctan.org/tex-archive/macros/luatex/generic/jobname/jobname.pdf)

## Installation

### TeX Live

    tlmgr install jobname

### Manually

    git clone git@github.com:Josef-Friedrich/jobname.git
    cd jobname
    make install

### Using make (assumes your TeX environment takes `$HOME/texmf` into account)

    make install

### By hand

    mkdir -p $HOME/texmf/tex/luatex/jobname
    cp -f jobname.tex $HOME/texmf/tex/luatex/jobname
    cp -f jobname.sty $HOME/texmf/tex/luatex/jobname
    cp -f jobname.lua $HOME/texmf/tex/luatex/jobname

## Compile the documentation:

    lualatex --shell-escape documentation.tex
    makeindex -s gglo.ist -o documentation.gls documentation.glo
    makeindex -s gind.ist -o documentation.ind documentation.idx
    lualatex --shell-escape documentation.tex
    mv documentation.pdf jobname.pdf
    mkdir -p $HOME/texmf/doc/luatex/jobname
    cp -f jobname.pdf $HOME/texmf/doc/luatex/jobname

## Development

First delete the stable version installed by TeX Live. Because the
package `jobname` belongs to the collection `collection-latexextra`, the
option  `--force` must be used to delete the package.

    tlmgr remove --force jobname

### Deploying a new version

Update the version number in the file `jobname.dtx` on this locations:

### In the markup for the file `jobname.sty` (approximately at the line number 30)

    %<*package>
      [2020/05/20 v1.4 Package to typeset jobname worksheets or jobname tests]
    %<*package>

Add a changes entry (approximately at the line 90):

```latex
\changes{v1.4}{2020/05/20}{...}
```

### In the package documentation `documentation.tex` (approximately at the line number 125)

```latex
\date{v1.7.0~from 2020/06/30}
```

### In the markup for the file `jobname.lua` (approximately at the line number 1900)

```lua
if not modules then modules = { } end modules ['jobname'] = {
  version   = '1.4'
}
```

### Command line tasks:

```
git tag v1.4
make
make ctan
```
