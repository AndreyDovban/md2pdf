docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    pandoc \
        $1.md \
        -s \
        -c ./modules/styles.css \
        -o test.html




sed -i '/<body>/r ./modules/header.html' ./test.html