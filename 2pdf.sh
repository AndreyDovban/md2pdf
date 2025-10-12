docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-pandoc \
    pandoc \
        --verbose \
        test.md \
        --from markdown \
        -t pdf \
        -s \
        --toc \
        -V language=ru-RU \
        -V linkcolor:blue \
        -V geometry:a4paper \
        --pdf-engine=xelatex \
        -V "mainfont:Inter" \
        -V "geometry=margin=0.8in" \
        -V "fontsize=16px" \
        --css ./styles.css \
        --wrap=auto \
        --columns=78 \
        -o tet.pdf \


        # --include-before-body cover.tex \
        # -c style.css \
        # --epub-embed-font style.css \
        # -V "toc-title=Оглавление" \

# ---
# title: Title text
# geometry: margin=2cm
# lang: ru
# header-includes: |
#     \newfontfamily{\cyrillicfont}{Inter} 
#     \newfontfamily{\cyrillicfontrm}{Inter}
#     \newfontfamily{\cyrillicfonttt}{Inter}
#     \newfontfamily{\cyrillicfontsf}{Inter}
# ---