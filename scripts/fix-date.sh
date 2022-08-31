#find . -mtime --1 -execdir sh -c 'touch -d "${PWD##/*}" -- "$@"' _ {} +
find . -mtime --1 -exec touch {} \;
