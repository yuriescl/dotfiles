#!/bin/bash
# Goto window containing mark (case sensitive)

i3-msg [con_mark="^.*$1.*$"] focus
