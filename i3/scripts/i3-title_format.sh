#!/bin/bash

if [ -n "$1" ]; then
	i3-msg title_format "$1"
else
	i3-msg title_format %title
fi
