#find . -type f -name "*.sh" -print0 | xargs -0 sed -i'' -e 's/CocoPi/CoCoPi/g'
find . -type f -name "Makefile" -print0 | xargs -0 sed -i'' -e 's#~/research/lzsa/lzsa/lzsa#~/source/lzsa/lzsa#g'
