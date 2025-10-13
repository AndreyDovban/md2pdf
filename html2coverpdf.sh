docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    wkhtmltopdf \
        --dpi $1 \
        --margin-bottom 0 \
        --margin-left 0 \
        --margin-top 0 \
        --margin-right 0 \
        cover.html \
        $2.pdf



        # --header-html ./header.html \
    # -e XDG_RUNTIME_DIR="/run/user/1000" \


 