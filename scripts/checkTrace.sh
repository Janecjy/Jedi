#!/bin/bash

for f in /mydata/traces/*; do 
    if ! [[ $(wc -l < $f) -eq 100000000 ]]; then 
        echo $f; 
        rm -rf $f; 
    fi; 
done