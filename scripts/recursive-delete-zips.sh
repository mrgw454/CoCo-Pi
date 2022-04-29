#!/bin/bash

shopt -s globstar
shopt -s extglob
shopt -s nocasematch

find . -type f -name '*.zip' -delete

