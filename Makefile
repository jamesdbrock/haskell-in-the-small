# Makefile for building documentation.

.PHONY : all clean
all : README.html
clean :
	rm README.html

README.html : README.md
	pandoc -f markdown_github-hard_line_breaks -t html5 -s --toc --self-contained --section-divs --title-prefix="Haskell in the Small" --css=README.css --highlight-style zenburn < README.md > README.html
