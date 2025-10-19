package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

var converter = map[string]string{
	"а": "a",
	"б": "b",
	"в": "v",
	"г": "g",
	"д": "d",
	"е": "e",
	"ё": "e",
	"ж": "zh",
	"з": "z",
	"и": "i",
	"й": "y",
	"к": "k",
	"л": "l",
	"м": "m",
	"н": "n",
	"о": "o",
	"п": "p",
	"р": "r",
	"с": "s",
	"т": "t",
	"у": "u",
	"ф": "f",
	"х": "h",
	"ц": "c",
	"ч": "ch",
	"ш": "sh",
	"щ": "sch",
	"ь": "",
	"ы": "y",
	"ъ": "",
	"э": "e",
	"ю": "yu",
	"я": "ya",

	"А": "A",
	"Б": "B",
	"В": "V",
	"Г": "G",
	"Д": "D",
	"Е": "E",
	"Ё": "E",
	"Ж": "Zh",
	"З": "Z",
	"И": "I",
	"Й": "Y",
	"К": "K",
	"Л": "L",
	"М": "M",
	"Н": "N",
	"О": "O",
	"П": "P",
	"Р": "R",
	"С": "S",
	"Т": "T",
	"У": "U",
	"Ф": "F",
	"Х": "H",
	"Ц": "C",
	"Ч": "Ch",
	"Ш": "Sh",
	"Щ": "Sch",
	"Ь": "",
	"Ы": "Y",
	"Ъ": "",
	"Э": "E",
	"Ю": "Yu",
	"Я": "Ya",
}

// Функция возвращает транслитерированную строку
func Translit(word string) string {
	answer := ""

	for _, v := range word {
		t, ok := converter[string(v)]
		if !ok {
			answer += string(v)
		} else {
			answer += t
		}
	}

	return answer

}

func copyFile(src, dst string) error {
	// Open the source file
	sourceFile, err := os.Open(src)
	if err != nil {
		return fmt.Errorf("failed to open source file: %w", err)
	}
	defer sourceFile.Close()

	// Create the destination file
	destinationFile, err := os.Create(dst)
	if err != nil {
		return fmt.Errorf("failed to create destination file: %w", err)
	}
	defer destinationFile.Close()

	// Copy the content
	_, err = io.Copy(destinationFile, sourceFile)
	if err != nil {
		return fmt.Errorf("failed to copy file: %w", err)
	}

	// Flush file metadata to disk
	err = destinationFile.Sync()
	if err != nil {
		return fmt.Errorf("failed to sync destination file: %w", err)
	}

	return nil
}

func createTreeDirs(path string, info fs.FileInfo, err error) error {
	if err != nil {
		return err
	}

	fmt.Println(info.Name(), info.Size())

	if info.IsDir() {
		err := os.Mkdir("./folder/"+Translit(path), 0755)
		if err != nil {
			fmt.Println(err)
		}
	}
	return nil
}

func createTreeFiles(path string, info fs.FileInfo, err error) error {
	if err != nil {
		return err
	}

	fmt.Println(info.Name(), info.Size())

	if !info.IsDir() {
		newName := "./folder/" + Translit(path)
		err = copyFile(path, newName)
		if err != nil {
			fmt.Printf("Ошибка переименования %s: %v\\n", path, err)
		}
	}
	return nil

}

var (
	path = flag.String("path", "", "путь к файлу")
)

func main() {
	flag.Parse()
	fmt.Println("Путь к файлу:", *path)

	rootDir := "./media"

	err := os.Mkdir("./folder", 0755)
	if err != nil {
		fmt.Println(err)
	}

	err = filepath.Walk(rootDir, createTreeDirs)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	fmt.Println("Дерево директорий каталога успешно транслитерировано")

	err = filepath.Walk(rootDir, createTreeFiles)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	fmt.Println("Дерево файлов каталога успешно транслитерировано")

	filename := *path
	file, err := os.Open(filename)
	if err != nil {
		fmt.Printf("Error opening file %s: %v\n", filename, err)
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var content string

	reMedia := regexp.MustCompile(`.*media.*`)
	for scanner.Scan() {
		line := scanner.Text()
		if reMedia.MatchString(line) {
			regPath := regexp.MustCompile(`(media.+)[\.].+`)
			matchedPathString := regPath.FindStringSubmatch(line)
			// fmt.Println(matchedPathString)
			translitPath := Translit(matchedPathString[1])
			// fmt.Println(translitPath)
			res := strings.Replace(line, matchedPathString[1], "folder/"+translitPath, 1)
			// fmt.Println("!!!", res)
			content += res + "\n"
		} else {
			content += line + "\n"
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Printf("Error reading from file %s: %v\n", filename, err)
		os.Exit(1)
	}

	tempFile, err := os.Create("./temp.md")
	if err != nil {
		fmt.Println("Error creating temp.md:", err)
		os.Exit(1)
	}
	defer tempFile.Close()

	tempFile.WriteString(content)
}
