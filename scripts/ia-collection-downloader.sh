#!/bin/bash

# get name of script and place it into a variable
scriptname=`basename "$0"`

# parse command line parameters for standard help options
if [[ $1 =~ --h|--help|-h ]];then

    echo -e
    echo -e "Example syntax:"
    echo -e
    echo -e "./$scriptname <name of archive.org collection>"
    echo -e
    exit 1

fi

if [ -f $HOME/.config/ia.ini ]
then

	echo "ia config file exists - proceeding."

else

	echo "ia.ini file does not exist."
	echo -e
	echo "You will need an account on archive.org before using this utility."
	echo "Once you have an active account, please run:"
	echo -e
	echo "ia configure"
	echo -e
	echo -e
	exit 1

fi


# check to see if collection folder exists.  If not, create and use it.
if [ -d "$1" ]
then

    echo "$1 folder already exists."
    echo
else
    echo "$1 folder does not exist.  Creating."
    mkdir "$1"
    echo
fi

cd "$1"

# make sure the $1 variable is used correctly when encapsulated between single quotes
ia download --search 'collection:"'"$1"'"'
