# go to root folder of git repository
alias cdgit='git rev-parse 2>/dev/null && cd $(git rev-parse --show-toplevel)'

# refactor simpler aliases
alias l='ls'
alias ll='ls -lha'
alias sl=ls # often screw this up

# quick directory traversal
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'

# some global aliases
alias -g L=' | less '
alias -g LL="2>&1 | less"
alias -g G=' | grep '
alias -g NUL="> /dev/null 2>&1"
alias TF='tail -f '

# unset nasty options...
# complete folders as if in home ~> annoying if not in home
unsetopt cdablevarS
# generally never really used it except for cases where it annoyed me
unsetopt correct_all

# history handling: add to shared history incrementally 
# but DON'T merge every shell's history during usage
# (really annoying for sb who has many shells open with different command categories...)
setopt inc_append_history
unsetopt share_history
