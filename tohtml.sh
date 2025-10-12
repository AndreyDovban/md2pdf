docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-pandoc \
    pandoc \
        -s \
        -o out.html \
        test.md