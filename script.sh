docker run \
    -it \
    --rm \
    --user andrey \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    pandoc \
        $1.md \
        -s \
        -c ./modules/styles.css \
        -o $1.html




sed -i '/<body>/r ./modules/logotip.html' ./$1.html

docker run \
    -it \
    --rm \
    --user andrey \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    wkhtmltopdf \
        --dpi 72 \
        --zoom 1.25 \
        --enable-toc-back-links \
        --disable-smart-shrinking \
        --encoding UTF-8 \
        --enable-local-file-access \
        --footer-spacing  0 \
        --footer-html ./modules/footer.html \
        --header-html ./modules/header.html \
        --margin-bottom 36px \
        --margin-left 0px \
        --margin-top 24px \
        --margin-right 0px \
        ./modules/cover.html \
        $1.html \
        $1.pdf



        # --footer-html ./modules/footer.html \
        # --footer-right "[page]/[topage]" \
        # --header-html ./header.html \
    # -e XDG_RUNTIME_DIR="/run/user/1000" \


 