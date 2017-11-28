#!/bin/bash

answer=$(zenity --title="i3 goto mark" --text "Goto Mark" --entry)
if [ -n "$answer" ]; then
	i3-msg [con_mark="^.*$answer.*$"] focus
fi
