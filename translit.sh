content=""

# Парсинг относительных ссылок на файлы markdown файла
while IFS= read -r line; do
    if [[ "$line" =~ .*media.* ]]; then
        content+="!!!$line"
    else
        content+=$line
    fi
done < $1


echo $content > ./temp.md

 