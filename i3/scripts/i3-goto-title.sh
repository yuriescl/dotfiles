#!/bin/bash
# Goto window containing title (case insensitive)

i3-input -F '[title="(?i)^.*%s.*$"] focus' -P "Goto to title: "
