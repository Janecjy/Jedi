#!/bin/bash

BASE_DIR="/scratch1/09498/janechen/mydata/"
FILES=$BASE_DIR"traces/*"
for r in 2 5 10
do
    mkdir -p $BASE_DIR"traces-"$r"x"
    for f in $FILES
    do
        NAME=$(basename "$f")  # Extract the filename with extension
        echo "python3 genTraceVarSizeNoise.py "$r" "$f" "$BASE_DIR"traces-"$r"x/"${NAME%.*}".txt" &
    done
wait
done

