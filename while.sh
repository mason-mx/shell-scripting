#!/bin/bash
# set n to 1
n=1

# continue until $n equals 5
while [ $n -le 5 ]
do
    echo "welcome $n times."
    n=$(( n+1 )) # increments $n
done

file=/etc/resolv.conf
while IFS= read -r line
do
    echo $line
done < "$file"
