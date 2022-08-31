#!/bin/bash

shopt -s globstar
shopt -s extglob
shopt -s nocasematch

for f in "$PWD"/**/*
do


	if [[ $f == *.rar ]]; then

		fullfilename="$f"
		filename=$(basename "$fullfilename")
		fname="${filename%.*}"
		filesize=$(stat -c%s "$fullfilename")
		filepath=$(dirname "$f")
		parentname="$(basename "$(dirname "$filepath")")"
		fujipath=$(echo $filepath | cut -d'/' -f4-)

		echo fullfilename $fullfilenmae
		echo filename $filename
		echo fname $fname
		echo filesize $filesize
		echo filepath $filepath
		echo parentname $parentname
		echo $fujipath

		dir=${f%.rar}
 		unrar x "$f" "$filepath"

		echo
		echo
		echo

	fi

done

