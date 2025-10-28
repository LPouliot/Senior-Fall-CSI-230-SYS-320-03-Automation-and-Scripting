#!/bin/bash

i="$(ip addr show  | grep "inet" |awk '{print $2}'  | cut -d "/" -f1 | head -n 3 | tail -n 1)"

echo "$i" 
