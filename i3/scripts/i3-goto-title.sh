#!/bin/bash
# Goto window containing title (case insensitive)

i3-msg [title="(?i)^.*$1.*$"] focus
