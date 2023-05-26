#!/bin/bash

FILES="/mydata/traces/*"
COUNT=0
COUNTMAX=10
for r in 2 5 10
do
    mkdir -p "/mydata/traces-"$r"x"
    for f in $FILES
    do
        NAME=$(basename "$f")  # Extract the filename with extension
        if [ ! -e "/mydata/traces-"$r"x/"${NAME%.*}".txt" ] && ! pgrep -f $NAME; then

            python3 scripts/genTraceVarSize.py $r $f "/mydata/traces-"$r"x/"${NAME%.*}".txt" &
            ((COUNT++))
            if [ $COUNT -eq $COUNTMAX ]
                then
                    wait
                    COUNT=0
            fi
        fi
    done
wait
done

