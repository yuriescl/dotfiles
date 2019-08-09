alias 'docker_exec'='docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`"'

function docker_bash {
    local CONTAINER=$(docker ps | awk 'NR>1 {print $1 " " $NF}' | fzf | awk '{print $NF}')
    validate_fzf_choice "$CONTAINER" && \
        docker_exec -it "$CONTAINER" bash
}

alias 'db'='docker_bash'
