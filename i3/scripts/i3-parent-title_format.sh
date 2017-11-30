#!/bin/bash

if [ -n "$1" ]; then
	i3-msg focus parent, title_format "$1", focus child
else
	i3-msg focus parent, title_format %title, focus child
fi
