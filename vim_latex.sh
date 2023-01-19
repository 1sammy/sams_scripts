#!/bin/sh
#
# script providing a LaTeX editing environment

echo "Using LaTeX in $PWD"

SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
DOC=$(find *.tex)

# if there exists a latex document in the working directory
if [ -n "$DOC" ];
then
	echo "Editing existing LaTeX document $DOC"
	DOC_PDF=$(find *.pdf)
# else create a new one and copy the template
else
	echo "Creating a new latex document..."
	read -p "filename: " DOC
	if [ "$DOC" != "*.tex" ];
	then
		DOC="${DOC}.tex"
	fi
	cp "$SCRIPT_DIR/latex/latex_template.tex" $DOC
	cp "$SCRIPT_DIR/latex/latex_latexmkrc" "$PWD/latexmkrc"
fi
latexmk -pvc -pdf $DOC > latexmk_out.txt 2>&1 & latexmk_pid=$!
vim "$PWD/$DOC"
kill "$latexmk_pid"
latexmk -c
