#
# Git
#

function Qeval {
	# Run a command using eval. Arguments have its surrounding quotes removed.
	# Args:
	#  $1: command
	#  $2: argument
	i=$(sed -e 's/^"//' -e 's/"$//' <<<"$i") # remove surrounding quotes
	echo "$1 $(printf '%q' $i)"
	eval "$1 $(printf '%q' $i)"
}

alias 'Gs'='git status'
alias 'Gl'='git log'
alias 'Gb'='git branch'
# Exits with status 0 if inside a git repository
function Isgitrepo {
    git rev-parse --is-inside-work-tree 2>/dev/null 1>/dev/null
}
#function Gshow {
#    if Isgitrepo; then
#        local COMMIT=$(git log --pretty=oneline 2>/dev/null | fzf | awk '{ print $1}')
#        if [ -n "$COMMIT" ]; then
#            git show "$COMMIT"
#        fi
#    else
#        echo "not a git repo" && return 1
#    fi
#}
# Checkout branch (choose from list, ordered from most recent commit)
function Gc {
    if Isgitrepo; then
        local BRANCH=$(git for-each-ref --sort=-refname --format='%(refname:short)' refs/heads/ | head -n 100 | fzf)
        if [ -n "$BRANCH" ]; then
            echo "git checkout '$BRANCH'"
            git checkout "$BRANCH"
        fi
    else
        echo "not a git repo" && return 1
    fi
}
# Merge branch into current branch (choose fromi list, ordered from most recent commit)
function Gm {
    if Isgitrepo; then
        local BRANCH=$(git for-each-ref --sort=-refname --format='%(refname:short)' refs/heads/ | head -n 100 | fzf)
        if [ -n "$BRANCH" ]; then
            echo "git merge '$BRANCH'"
            git merge "$BRANCH"
        fi
    else
        echo "not a git repo" && return 1
    fi
}
# Push current branch (setting it as upstream)
function Gp {
    if Isgitrepo; then
        local BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
        if [ -n "$BRANCH" ]; then
            echo "git push -u origin  '$BRANCH'"
            git push -u origin  "$BRANCH"
        fi
    else
        echo "not a git repo" && return 1
    fi
}
# Stage file(s)
function Ga {
    if Isgitrepo; then
		local IFS=$'\n'
		local FILES=($(git status -s | fzf -m | awk '{out=$2; for(i=3;i<=NF;i++){out=out" "$i}; print out}'))
		for i in "${FILES[@]}"
		do
			Qeval "git add" "$i"
		done
    else
        echo "not a git repo" && return 1
    fi
}
# 'reset HEAD' file(s) ("unstage")
function Gr {
    if Isgitrepo; then
		local IFS=$'\n'
		local FILES=($(git status -s | fzf -m | awk '{out=$2; for(i=3;i<=NF;i++){out=out" "$i}; print out}'))
		for i in "${FILES[@]}"
		do
			Qeval "git reset HEAD" "$i"	
		done
    else
        echo "not a git repo" && return 1
    fi
}
# Revert changes to file(s) (git checkout -- <file>)
function Gx {
    if Isgitrepo; then
		local IFS=$'\n'
		local FILES=($(git status -s | fzf -m | awk '{out=$2; for(i=3;i<=NF;i++){out=out" "$i}; print out}'))
		for i in "${FILES[@]}"
		do
			Qeval "git checkout --" "$i"
		done
    else
        echo "not a git repo" && return 1
    fi
}
