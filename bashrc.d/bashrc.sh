export EDITOR=vim

stty -ixon # disable Ctrl-S

# avoid Ctrl-D spam exitting shells
set -o ignoreeof

alias sl='ls'
alias lr='ls -lathr'

alias t='tmux'
alias tl='tmux list-sessions'
alias ta='tmux a -t'

alias view='vim -M'

alias b64decode="python3 -c 'import base64, sys; print(base64.b64decode(sys.argv[1]).decode())'"
alias b64encode="python3 -c 'import base64, sys; print(base64.b64encode(sys.argv[1].encode()).decode())'"

function tlr { # tail the last modified file in current folder
    local FILE="$(ls -At | head -n 1)"
    echo "---- ${FILE}:"
    tail -n 30 -f "$FILE"
}

function vlr { # edit last modified file in current folder
    local FILE="$(ls -At | head -n 1)"
    vim "$FILE"
}

function c {
    while true; do
        ls -aF
        echo ''
        pwd
        CHOICE=$(ls -aF | awk '{ if ($1!="./") print $1}' | fzf --height=5 --reverse)
        if [ -z "$CHOICE" ]; then
            break
        fi
        if [ -f "$CHOICE" ]; then
            v "$CHOICE"
        else
            cd "$CHOICE"
        fi
    done
}
