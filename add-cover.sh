docker run \
    -it \
    --rm \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
        qpdf --empty --pages $1.pdf $2.pdf -- $3.pdf

 
# qpdf --empty --pages file1.pdf file2.pdf -- combined.pdf
# pdftk $1 $2 cat output combined.pdf
# pdftk combined.pdf update_info_utf8 bookmarks.txt output final_combined.pdf