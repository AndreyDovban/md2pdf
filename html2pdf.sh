docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    wkhtmltopdf \
        --dpi $1 \
        --zoom 1.25 \
        --enable-toc-back-links \
        --disable-smart-shrinking \
        --encoding UTF-8 \
        --enable-local-file-access \
        --footer-html ./modules/footer.html \
        --footer-right "[page]/[topage]" \
        --footer-font-size 10 \
        --footer-spacing  5 \
        --margin-bottom 48px \
        --margin-left 42px \
        --margin-top 24px \
        --margin-right 42px \
        test.html \
        $2.pdf



        # --footer-right "[page]/[topage]" \
        # --header-html ./header.html \
    # -e XDG_RUNTIME_DIR="/run/user/1000" \


 