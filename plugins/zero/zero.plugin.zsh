# usage: quickly go to root folder of git repository
#     pwd      # /my-repo/lib/subfolder
#     cdgit
#     pwd      # /my-repo
alias cdgit='git rev-parse 2>/dev/null && cd $(git rev-parse --show-toplevel)'

# refactor simpler aliases
alias l='ls'
alias l1='ls -1'
alias ll='ls -lha'
# since i often screw this up
alias sl=ls
# usage: follow the output of a file
#     TF my.log
alias TF='tail -f '
# usage: print size of sth on disk
#     sizeof *
alias sizeof='du -hs '

# usage: quick directory traversal
#     # all commands run in: /a/b/c/d
#     ..        # /a/b/c
#     ...       # /a/b
#     ....      # /a
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'


# grep helpers
# ipv6 regex by MichaelRushton,
# http://stackoverflow.com/questions/53497/regular-expression-that-matches-valid-ipv6-addresses
# '/
#(?>
  #(?>
    #([a-f0-9]{1,4})                                  ?1 = 0-f ... 0000-ffff (1-4 digit hex)
    #(?>:(?1)){7}                                          x:x:x:x:x:x:x:x   (all 8 fields)
    #|
    #(?!                                                   do not:
      #(?:.*[a-f0-9](?>:|$)){8,}                           any followed by hex 8 or more times
    #)                                                     ie: make sure there are no more than a total of 7 fields max if we use ::
    #((?1)(?>:(?1)){0,6})?                            ?2 = x ... x:x:x:x:x:x:x  (up to 7 fields)
    #::(?2)?                                               part::part?
  #)|
  #(?>
    #(?>
      #(?1)(?>:(?1)){5}:                                   x:x:x:x:x:x: (6 fields + colon)
      #|
      #(?!(?:.*[a-f0-9]:){6,})                             no more than 5 fields max
      #(?3)?                                               conditional prefix
      #::(?>((?1)(?>:(?1)){0,4}):)?                        :: + up to 4 fields followed by colon
    #)?                                                    conditionally (ie matches ipv4-in-ipv6 or just ipv4)
    #(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])      ?4 = 0-255
    #(?>\.(?4)){3}                                         0-255.0-255.0-255.0-255
  #)
#)/iD'                                                     case-insensitive + updated character behavior
# usage: find all IPv4 and IPv6 addresses in nmap_output.txt
#        grep_ip nmap_output.txt
alias grep_ip=' grep -iP "(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){8,})((?1)(?>:(?1)){0,6})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){6,})(?3)?::(?>((?1)(?>:(?1)){0,4}):)?)?(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))"'
# usage: find all IPv6 addresses in nmap_output.txt
#        grep_ip6 nmap_output.txt
alias grep_ip6='grep -iP "(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){8,})((?1)(?>:(?1)){0,6})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){6,})(?3)?::(?>((?1)(?>:(?1)){0,4}):)?)(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))"'
# usage: find all IPv4 addresses in nmap_output.txt
#        grep_ip4 nmap_output.txt
alias grep_ip4='grep -iP "(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?1)){3}"'


# conditional aliases
# usage: if they are installed, use advcp utilities (coreutils' cp and mv with progress bar)
#        cp -rv folder /remote/destination
#        mv -v folder /remote/destination
[ -f "/usr/bin/acp" ] && alias cp="/usr/bin/acp -g "
[ -f "/usr/bin/amv" ] && alias mv="/usr/bin/amv -g "

# some global aliases
# usage: pipe huge.txt (stdout) into less
#        cat huge.txt L
alias -g L=' | less '
# usage: pipe stdout+stderr results into less
#        ./stdout+stderr.sh LL
alias -g LL="2>&1 | less"
# usage: shorthand for writing grep
#        cat my.html G "<h3" G "id="
alias -g G=' | grep '
# usage: do not show any output (pipe stdout+stderr to /dev/null)
#        ./run.daemon NUL
alias -g NUL='> /dev/null 2>&1'
# usage: shorthand for sorting human-readable
#        du -hs * SH
alias -g SH=' | sort -h '
# usage: shorthand for counting lines
#        ls -1 LC
alias -g LC=' | wc -l '

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
