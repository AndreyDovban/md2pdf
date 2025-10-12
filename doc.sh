# Notes about Debian packaging of Pandoc

## Packages needed for optional features

Some uses of Pandoc require additional packages:

  * SVG content in PDF output requires librsvg2-bin.
  * YAML metadata in TeX-related output requires texlive-latex-extra.
  * *.hs filters not set executable requires ghc.
  * *.js filters not set executable requires nodejs.
  * *.php filters not set executable requires php.
  * *.pl filters not set executable requires perl.
  * *.py filters not set executable requires python.
  * *.rb filters not set executable requires ruby.
  * *.r filters not set executable requires r-base-core.
  * LaTeX output, and PDF output via PDFLaTeX,
    require texlive-latex-recommended.
  * XeLaTeX output, and PDF output via XeLaTeX, require texlive-xetex.
  * LuaTeX output, and PDF output via LuaTeX, require texlive-luatex.
  * ConTeXt output, and PDF output via ConTeXt, require context.
  * PDF output via wkhtmltopdf requires wkhtmltopdf.
  * Roff man and roff ms output, and PDF output via roff ms,
    require groff.
  * MathJax-rendered equations require libjs-mathjax.
  * KaTeX-rendered equations require node-katex.
  * option --csl may use styles in citation-style-language-styles.


## Standalone output not always fully standalone

Some output formats depend on external material,
e.g. Javascript code for rendering mathematical equations.

Pandoc commonly links to such external material hosted on a public CDN.
Due to concerns for potential breach of privacy,
Debian-packaged Pandoc instead links to locally packaged material.


