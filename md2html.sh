docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    pandoc \
        test.md \
        -s \
        -c ./styles.css \
        -o test.html



header=$(cat ./modules/header.html)

sed -i '/<body>/r header.html' ./test.html