#!/bin/bash
# Goto window containing title (case insensitive)

answer=$(zenity --title="i3 goto title" --text "Goto window by title" --entry)
if [ -n "$answer" ]; then
	i3-msg [title="(?i)^.*$answer.*$"] focus
fi
