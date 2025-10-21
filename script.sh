# Дефолтные значения переменных для создания обложки и шапки документа
cover_title=Заголовок
cover_product=Продукт
cover_version="версия продукта"
cover_updated_at="последнее обновление"

# Плучение имени файла без расширений и пути
file_path=$1
file_name="${file_path%.*}"
file_name="${file_name##*/}"
echo $file_name


# Парсинг метаданных целевого markdown файла
while IFS= read -r line; do
  if [[ "$line" =~ "cover_product:"|"cover_title:"|"cover_version:"|"cover_updated_at:"  ]]; then
    case "$line" in
       *cover_product*)
        cover_product="${line##*cover_product: }"
        echo "Product: ${cover_product}" # Отладочный вывод
        ;;
      *cover_title*)
        cover_title="${line##*cover_title: }"
        echo "Title: ${cover_title}" # Отладочный вывод
        ;;
      *cover_version*)
        cover_version="${line##*cover_version: }"
        echo "Version: ${cover_version}" # Отладочный вывод
        ;;
      *cover_updated_at*)
        cover_updated_at="${line##*cover_updated_at: }"
        echo "Updated at: ${cover_updated_at}" # Отладочный вывод
        ;;
    esac
  fi
done < $1


# Создание временного markdown файла и временной директории со статическими ресурсами создаваемого документа
# Названия фалов ресурсов и относительные ссылки на них будут транслитерированы
# Библиотека wkhtmltopdf не поддерживает работу с относительными путями имеющими кирилицу
go run . --path $1

 

# Создание временного html файла из целевого markdown файла
docker run \
    -it \
    --rm \
    --user andrey \
    -v $(pwd):/opt/app \
    ubuntu-md2pdf \
    pandoc \
        temp.md \
        -s \
        -c ./modules/styles.css \
        -o $file_name.html


# Создание обложки документа, подставление нужных значений 
cp ./modules/cover.html ./modules/cover_temp.html
sed -i "s/TITLE/${cover_title}/" ./modules/cover_temp.html
sed -i "s/PRODUCT/${cover_product}/" ./modules/cover_temp.html
sed -i "s/VERSION/${cover_version}/" ./modules/cover_temp.html
sed -i "s/UPDATED_AT/${cover_updated_at}/" ./modules/cover_temp.html

# Создание шапки документа, подставление нужных значений 
cp ./modules/logotip.html ./modules/logotip_temp.html
sed -i "s/TITLE/${cover_title}/" ./modules/logotip_temp.html
sed -i "s/PRODUCT/${cover_product}/" ./modules/logotip_temp.html
sed -i "s/VERSION/${cover_version}/" ./modules/logotip_temp.html
sed -i "s/UPDATED_AT/${cover_updated_at}/" ./modules/logotip_temp.html

# Добавление шапки документа основной html фалй
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
        --page-offset -1 \
        --disable-smart-shrinking \
        --enable-toc-back-links \
        --encoding UTF-8 \
        --enable-local-file-access \
        --footer-spacing  0 \
        --header-spacing  -1 \
        --footer-html ./modules/footer.html \
        --margin-bottom 36px \
        --margin-left 42px \
        --margin-top 24px \
        --margin-right 42px \
        cover ./modules/cover_temp.html \
        toc \
        --xsl-style-sheet ./modules/toc.xsl \
        $file_name.html \
        $file_name.pdf


# Удаление временных файлов
# rm $file_name.html
rm -r ./folder
rm ./temp.md
rm ./modules/cover_temp.html
rm ./modules/logotip_temp.html




 