# plugins for zero zsh

# refactor simpler aliases
# desc: misc shorthands
# use: sizeof *
alias l='ls'
alias l1='ls -1'
alias ll='ls -lha'
alias TF='tail -f '
# since i often screw this up
alias sl=ls
alias sizeof='du -hs '

# quick directory traversal
# use: ..
#      .....
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'

# desc: quickly go to root folder of git repository
# usage: cdgit
alias cdgit='git rev-parse 2>/dev/null && cd $(git rev-parse --show-toplevel)'


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
# desc:  grep all IPv4 and IPv6 addresses
# usage: grep_ip nmap_output.txt
#        grep_ip4 nmap_output.txt
#        grep_ip6 nmap_output.txt
alias grep_ip=' grep -iP "(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){8,})((?1)(?>:(?1)){0,6})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){6,})(?3)?::(?>((?1)(?>:(?1)){0,4}):)?)?(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))"'
alias grep_ip6='grep -iP "(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){8,})((?1)(?>:(?1)){0,6})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){6,})(?3)?::(?>((?1)(?>:(?1)){0,4}):)?)(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))"'
alias grep_ip4='grep -iP "(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?1)){3}"'


# conditional aliases

# desc:  if they are installed, use advcp utilities
#        (coreutils' cp and mv with progress bar)
# use: cp -rv a /to/b
#      mv -v a /to/b
[ -f "/usr/bin/acp" ] && alias cp="/usr/bin/acp -g "
[ -f "/usr/bin/amv" ] && alias mv="/usr/bin/amv -g "

# desc: misc global aliases
# about their style:
#   they all carry the ',[a-z]' style
#   an alternative is usually '[A-Z]' instead
#   i was also considering '.[a-z]' style
# finding:
#   [A-Z]-style: this will happen very seldomly, but it can conflict with input
#                since letters are replaced before anything else happens
#                eg: mkdir G H I J K L
#                 => mkdir H I J K
#   .[a-z]-style: very nice but suffers a similar problem, since hidden folders
#                 in linux use the very same syntax
#                 it's not as bad, however, since you can always use absolute
#                 paths
#   ,[a-z]-style: doesn't conflict with anything as far as i know
#                 it feels a bit strange at first, but you'll get used to it
# use: cat huge.txt ,l
alias -g ,l=' | less '
# use: ./stdout+stderr.sh ,la
alias -g ,la="2>&1 | less"
# use: cat my.html ,g "<h3" ,g "id="
alias -g ,g=' | grep '
# use: cat my.html ,g "<h3" ,g "id="
alias -g ,gi=' | grep -i '
# use: cat my.html ,go "href=[^ ]*"
alias -g ,go=' | grep --only '
# use: ./run.daemon ,nul
alias -g ,nul='> /dev/null 2>&1'
# use: ls -1 ,s
alias -g ,s=' | sort '
alias -g ,sort=' | sort '
# use: du -hs * ,sh
alias -g ,sh=' | sort -h '
# use: ls -1 ,count
alias -g ,count=' | wc -l '
# use: ls -1 ,cl
alias -g ,cl=' | wc -l '
# use: cat essay.txt ,cw
alias -g ,cw=' | wc -w '
# use: cat my.bin ,cb
alias -g ,cb=' | wc -c '

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