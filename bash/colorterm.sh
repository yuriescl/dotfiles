#!/bin/sh
function ssh {
    command tmux setw window-status-current-format '#[bg=colour22,fg=colour178,bold]#I#[bg=colour22,fg=colour255,bold] #W#[fg=colour50]#F'
    command tmux setw window-status-format '#[bg=colour17,fg=colour178]#I#[bg=colour17,fg=colour250,none] #W#[fg=colour244]#F'
    command ssh "$@"
    command tmux setw window-status-current-format '#[bg=colour237,fg=colour178,bold]#I#[bg=colour237,fg=colour255,bold] #W#[fg=colour50]#F'
    command tmux setw window-status-format '#[bg=colour234,fg=colour138,none]#I#[bg=colour234,fg=colour250,none] #W#[fg=colour244]#F'
}

function vim-tmux-new-window {
    tmux split-window -h -b -p 40 bash -c "cd $1 && export NVIM_LISTEN_ADDRESS=$2 && pwd; bash"
}
