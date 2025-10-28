#!bin/bash

i="$(ip addr show" | grep "inet" | awk '{pring $2}' | cut -d "/" -f1)

echo "$i"
