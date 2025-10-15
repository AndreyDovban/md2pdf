# Дефолтные значения переменных
title=Заголовок
product=Продукт
version="версия продукта"
updated_at="последнее обновление"

# Плучение имени файла без расширений и пути
file_path=$1
file_name="${file_path%.*}"
file_name="${file_name##*/}"
echo $file_name


# Парсинг метаданных целевого markdown файла
while IFS= read -r line; do
  if [[ "$line" =~ "product:"|"title:"|"version:"|"updated_at:"  ]]; then
    case "$line" in
       *product*)
        product="${line##*product\: }"
        echo "Product: ${product}" # Отладочный вывод
        ;;
      *title*)
        title="${line##*title\: }"
        echo "Title: ${title}" # Отладочный вывод
        ;;
      *version*)
        version="${line##*version\: }"
        echo "Version: ${version}" # Отладочный вывод
        ;;
      *updated_at*)
        updated_at="${line##*updated_at\: }"
        echo "Updated at: ${updated_at}" # Отладочный вывод
        ;;
    esac
  fi
done < $1

 

# Создание сосновного html файла из целевого markdown файла
docker run \
    -it \
    --rm \
    --user andrey \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    pandoc \
        $file_name.md \
        -s \
        -c ./modules/styles.css \
        -o $file_name.html


# Создание обложки документа, подставление нужных значений 
cp ./modules/cover.html ./modules/cover_temp.html
sed -i "s/TITLE/${title}/" ./modules/cover_temp.html
sed -i "s/PRODUCT/${product}/" ./modules/cover_temp.html
sed -i "s/VERSION/${version}/" ./modules/cover_temp.html
sed -i "s/UPDATED_AT/${updated_at}/" ./modules/cover_temp.html

# Создание шапки документа, подставление нужных значений 
cp ./modules/logotip.html ./modules/logotip_temp.html
sed -i "s/TITLE/${title}/" ./modules/logotip_temp.html
sed -i "s/PRODUCT/${product}/" ./modules/logotip_temp.html
sed -i "s/VERSION/${version}/" ./modules/logotip_temp.html
sed -i "s/UPDATED_AT/${updated_at}/" ./modules/logotip_temp.html

# Добавление блока с логотипом с основной html фалй
sed -i '/<body>/r ./modules/logotip_temp.html' ./$file_name.html

# Создание итогового pdf файла из html файла боложки и основного html файла
docker run \
    -it \
    --rm \
    --user andrey \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    wkhtmltopdf \
        --dpi 72 \
        --zoom 1.25 \
        --enable-toc-back-links \
        --disable-smart-shrinking \
        --encoding UTF-8 \
        --enable-local-file-access \
        --footer-spacing  0 \
        --header-spacing  -1 \
        --footer-html ./modules/footer.html \
        --header-html ./modules/header.html \
        --margin-bottom 36px \
        --margin-left 0px \
        --margin-top 24px \
        --margin-right 0px \
        ./modules/cover_temp.html \
        $file_name.html \
        $file_name.pdf


# Удаление временных файлов
rm $file_name.html
rm ./modules/cover_temp.html
rm ./modules/logotip_temp.html





 