#!/bin/bash

BASE_DIR="/scratch1/09498/janechen/mydata/"
FILES=$BASE_DIR"traces/*"
for r in 2 5 10
do
    mkdir -p $BASE_DIR"traces-"$r"x"
    for f in $FILES
    do
        NAME=$(basename "$f")  # Extract the filename with extension
        if [[ ! -e $BASE_DIR"traces-"$r"x/"${NAME%.*}".txt" || ! $(wc -l < $BASE_DIR"traces-"$r"x/"${NAME%.*}".txt") -eq 100000000 ]] && ! pgrep -f $NAME && [[ $(wc -l < $f) -eq 100000000 ]]; then
            rm "/mydata/traces-"$r"x/"${NAME%.*}".txt"
            echo "python3 scripts/genTraceVarSizeNoise.py "$r" "$f" "$BASE_DIR"traces-"$r"x/"${NAME%.*}".txt" &
        fi
    done
wait
done

