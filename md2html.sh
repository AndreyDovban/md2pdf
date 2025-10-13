docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    pandoc \
        test.md \
        -s \
        -c ./styles.css \
        -o test.html \