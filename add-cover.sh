docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
        pdftk $1 $2 cat output combined.pdf

# qpdf --empty --pages file1.pdf file2.pdf -- output.pdf