#!/bin/bash
# Goto window containing mark (case sensitive)

i3-input -F '[con_mark="^.*%s.*$"] focus' -P 'Goto mark: '
