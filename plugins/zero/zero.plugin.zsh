# quickly go to root folder of git repository
# eg: inside /my-repo/lib/subfolder
#     cdgit
#     now inside /my-repo
alias cdgit='git rev-parse 2>/dev/null && cd $(git rev-parse --show-toplevel)'

# refactor simpler aliases
alias l='ls'
alias ll='ls -lha'
alias sl=ls # since i often screw this up
# usage: TF my.log
alias TF='tail -f '

# quick directory traversal
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'

# some global aliases
# usage: cat huge.txt L
alias -g L=' | less '
# usage: ./stdout+stderr.sh LL
alias -g LL="2>&1 | less"
# usage: cat my.html G "<h3" G "id="
alias -g G=' | grep '
# usage: ./run.daemon NUL
alias -g NUL='> /dev/null 2>&1'
# usage: du -hs * SH
alias -g SH=' | sort -h '


# alter some zsh options

# problem: auto-completion of folders as if you were currently in '~/'
#          ~> annoying if you aren't there and are only interested in
#             your current folder
unsetopt cdablevarS

# problem: auto-correction for eg `mv source destination`
#          ~> asking me if i meant something existing (and dangerous in this constellation)
# also: i never really found any use for this
#       i heavily rely on tab'ing my way through, errors are very seldom and far less annoying
unsetopt correct_all

# history handling:
# problem:  commands from different shells are gathered in one history
#           if your run 100 commands in shell #1 you will have a hard time finding
#           the last command you typed in shell #2
# solution: add commands to shared history incrementally
#           but DON'T merge every shell's history during usage
#           ~> running shell has its own history context
#           ~> new shell can access all shell's commands up to this point
setopt inc_append_history
unsetopt share_history
