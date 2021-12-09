for first in $(ls -1 | sed 's/^\(.\).*$/\1/' | tr '[a-z0-9]' '[A-Z0-9]' | uniq)
do
    mkdir tmp
    mv "$first"* tmp/
    lower=$(echo $first | tr '[A-Z]' '[a-z]')
    mv "$lower"* tmp/
    mv tmp/ "$first";
done

