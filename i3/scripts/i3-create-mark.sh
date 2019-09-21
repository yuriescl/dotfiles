#!/bin/bash
# if $1 is set, mark current window
# else unmark current window

if [ -n "$1" ]; then
	i3-msg mark "$1"
else
	i3-msg "[con_id=$(~/opt/scripts/i3/i3get)]" unmark
fi
