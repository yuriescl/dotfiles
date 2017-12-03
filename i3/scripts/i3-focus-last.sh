#!/usr/bin/env bash
last=

xprop -root -spy _NET_ACTIVE_WINDOW | while :
do
read line

[[ -z "$last" ]] || i3-msg "[id=$last] mark --add _last"
    last=$(echo "$line" | awk -F' ' '{printf $NF}')
done
