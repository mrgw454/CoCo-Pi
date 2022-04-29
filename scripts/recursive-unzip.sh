#!/bin/bash

shopt -s globstar
shopt -s extglob
shopt -s nocasematch

find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`" "$filename"; done;
#find . -name "*.ZIP" | while read filename; do unzip -o -d "`dirname "$filename"`" "$filename"; done;
#find . -name "*.zip" | xargs -P 5 -I fileName sh -c 'unzip -o -d "$(dirname "fileName")/$(basename -s .zip "fileName")" "fileName"'

