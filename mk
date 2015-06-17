for f in *.chpl; do chpl -o out/$f --fast $f; done
