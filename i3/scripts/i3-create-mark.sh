#!/bin/bash
# if $1 is set, set mark for current window
# else unmark current window

if [ -n "$1"]; then
	i3-msg mark "$1"
else
	# unmark current window how?
fi
