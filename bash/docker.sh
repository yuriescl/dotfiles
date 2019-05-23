# prevent visual column/line bugs in terminals
alias 'docker_exec'='docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`"'

# exec bash in a container (choose from list)
function docker_bash {
    local CONTAINER=$(docker ps | awk 'NR>1 {print $1 " " $NF}' | fzf | awk '{print $NF}')
    # see 'bashrc' for definition of validate_fzf_choice
    validate_fzf_choice "$CONTAINER" && \
        docker_exec -it "$CONTAINER" bash
}
