docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-pandoc \
    pandoc \
        -s \
        --toc \
        -H chapter_break.tex \
        -V "toc-title=Оглавление" \
        -V language=ru-RU \
        -V linkcolor:blue \
        -V geometry:a4paper \
        -V geometry:margin=2cm \
        --pdf-engine=xelatex \
        -V "mainfont:Inter" \
        -V "geometry=margin=0.8in" \
        -V "fontsize=16px" \
        --wrap=auto \
        --columns=78 \
        -o out.pdf \
        test.md


        # --include-before-body cover.tex \
        # -c style.css \
        # --epub-embed-font style.css \