#!/bin/bash

# List all the ips in the given network prefix
# user /24 only

# Useage: bash IPList.bash 10.0.17
[ "$#" -lt 1 ] && echo "Usage: $0 <Prefix>" &&  exit 1

# Prefix is the first input taken
 prefix="$1"

# Verify input length
[ the_input -lt 5] && \
printf "Prefix legnth is too short\nPrefix example: 10.0.17\n" && \
exit 1


for i in $(seq 1 254)
do
        echo "$prefix.$i"
done

