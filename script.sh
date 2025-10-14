./md2html.sh $1

./html2coverpdf.sh 72 $2

./html2pdf.sh 72 $3

./add-cover.sh $2 $3 $4

chown andrey:andrey $4.pdf