#!/bin/bash

BASEDIR=$(pwd)
FILES="$BASEDIR/config/*"
COUNT=0
COUNTMAX="$1"

for f in $FILES
    do
        NAME=$(basename "$f")  # Extract the filename with extension
        if [ ! -e "/mydata/traces/"${NAME%.*}".txt" ]; then

            python3 tragen_cli.py -c ${f::-7}".config" &
            ((COUNT++))
            if [ $COUNT -eq $COUNTMAX ]
                then
                    wait
                    COUNT=0
                    mv OUTPUT/* /mydata/traces/
            fi
        fi
        # done
    done
wait
mv OUTPUT/* /mydata/traces/
rm -rf /mydata/traces/debug.txt
rm -rf /mydata/traces/logfile.txt
rm -rf /mydata/traces/debug_cache_mix.txt