#!/bin/bash

FILES="/mydata/traces/*"
COUNT=0
COUNTMAX=$1
IMP=$2 # 0 for float, 1 for int, 2 for noise
for r in 2 5 10
do
    mkdir -p "/mydata/traces-"$r"x-"$IMP
    for f in $FILES
    do
        NAME=$(basename "$f")  # Extract the filename with extension
        if [[ ! -e "/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt" || ! $(wc -l < "/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt") -eq 100000000 ]] && ! pgrep -f $NAME && [[ $(wc -l < $f) -eq 100000000 ]]; then
            rm "/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt"
            if [ $IMP -eq 0 ]; then
                # echo "0/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt"
                python3 scripts/genTraceVarSize.py $r $f "/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt" &
            elif [ $IMP -eq 1 ]; then
                # echo "1/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt"
                python3 scripts/genTraceVarSizeInt.py $r $f "/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt" &
            else
                # echo "2/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt"
                python3 scripts/genTraceVarSizeNoise.py $r $f "/mydata/traces-"$r"x-"$IMP"/"${NAME%.*}".txt" &
            fi
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

