docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    wkhtmltopdf \
        --dpi $1 \
        --encoding UTF-8 \
        --enable-local-file-access \
        --footer-right "[page]/[topage]" \
        --footer-html ./modules/footer.html \
        --footer-font-size 8 \
        --footer-spacing  2 \
        --margin-bottom 48px \
        --margin-left 42px \
        --margin-top 24px \
        --margin-right 42px \
        test.html \
        $2.pdf



        # --header-html ./header.html \
    # -e XDG_RUNTIME_DIR="/run/user/1000" \


 