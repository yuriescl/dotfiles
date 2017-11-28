#!/bin/bash

if [ -n "$1" ]; then
	answer=$(zenity --title="i3 set mark" --text "Create Mark for the parent container" --entry)
else
	answer=$(zenity --title="i3 set mark" --text "Create Mark" --entry)
fi
if [ -n "$answer" ]; then
	if [ -n "$1" ]; then
		i3-msg focus parent, mark "$answer", focus child
	else
		i3-msg mark "$answer"
	fi
else
	if [ -n "$1" ]; then
		i3-msg focus parent, unmark, focus child
	else
		i3-msg unmark
	fi
fi
