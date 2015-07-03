if [ -n "$1" ]
then
chpl -o out/$1 $1
else
for f in *.chpl; do chpl -o out/$f --fast $f; done
fi
