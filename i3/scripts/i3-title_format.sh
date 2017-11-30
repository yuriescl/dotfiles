#!/bin/bash

if [ -n "$1" ]; then
	answer=$(zenity --title="i3-msg title_format" --text "Title for the parent container" --entry)
else
	answer=$(zenity --title="i3-msg title_format" --text "Title" --entry)
fi
if [[ $? -eq 1 ]]; then
	answer="__canceled__"
fi
if [[ "$answer" != "__canceled__" ]]; then
	if [ -n "$answer" ]; then
		if [ -n "$1" ]; then
			i3-msg focus parent, title_format "$answer", focus child
		else
			i3-msg title_format "$answer"
		fi
	else
		if [ -n "$1" ]; then
			i3-msg focus parent, title_format %title, focus child
		else
			i3-msg title_format %title
		fi
	fi
fi
