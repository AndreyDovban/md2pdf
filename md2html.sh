docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-pandoc \
    pandoc \
        test.md \
        -s \
        -c ./styles.css \
        -o test.html \