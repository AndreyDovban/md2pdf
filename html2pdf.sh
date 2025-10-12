docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-pandoc \
    html2pdf \
        --enable-local-file-access \
        test.html \
        test.pdf


