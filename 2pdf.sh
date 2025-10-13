docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    pandoc \
        test.md \
        --from markdown \
        -t pdf \
        -s \
        --toc \
        --dpi=72 \
        -V language=ru-RU \
        -V linkcolor:blue \
        --pdf-engine=wkhtmltopdf \
        --pdf-engine-opt=--enable-local-file-access \
        -V "mainfont:Inter" \
        --css ./styles.css \
        --wrap=auto \
        --columns=78 \
        -o test.pdf \


        # --pdf-engine-opt=--footer-right="[page] / [topage]" \
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