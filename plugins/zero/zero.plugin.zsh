# plugins for zero zsh

# desc: quickly go to root folder of git repository
# usage: cdgit
alias cdgit='git rev-parse 2>/dev/null && cd $(git rev-parse --show-toplevel)'

# desc: ignorant ssh commands: ssh while ignoring host key checking.
#       use these like you would use ssh, scp, and pssh. use with caution! (only recommended if you trust the network they reside in)
# usage: sshi name@destination
#        scpi file name@destination:
#        psshi -l name -h hosts date
alias sshi='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null'
alias scpi='scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null'
alias psshi='pssh -O StrictHostKeyChecking=no -O UserKnownHostsFile=/dev/null -O GlobalKnownHostsFile=/dev/null'

# colorful grep, even when piping
# see: http://stackoverflow.com/questions/2327191/preserve-colouring-after-piping-grep-to-grep
alias grep="grep --color=always"

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
#        also works in global style via `,g_ip`, `,g_ip4`, `,g_ip6`
# usage: grep_ip nmap_output.txt
#        grep_ip4 nmap_output.txt
#        grep_ip6 nmap_output.txt
#        nmap 192.168.0.0/24 ,g_ip4
alias grep_ip=' grep -iP "(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){8,})((?1)(?>:(?1)){0,6})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){6,})(?3)?::(?>((?1)(?>:(?1)){0,4}):)?)?(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))"'
alias grep_ip6='grep -iP "(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){8,})((?1)(?>:(?1)){0,6})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){6,})(?3)?::(?>((?1)(?>:(?1)){0,4}):)?)(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))"'
alias grep_ip4='grep -iP "(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?1)){3}"'
# global grep helpers
alias -g ,g_ip='  | grep_ip '
alias -g ,g_ip4=' | grep_ip4 '
alias -g ,g_ip6=' | grep_ip6 '


# conditional aliases

# desc:  if they are installed, use advcp utilities
#        (coreutils' cp and mv with progress bar)
# use: cp -rv a /to/b
#      mv -v a /to/b
[ -f "/usr/bin/acp" ] && alias cp='/usr/bin/acp -g '
[ -f "/usr/bin/amv" ] && alias mv='/usr/bin/amv -g '

# refactor simpler aliases
# desc: simple shorthands
# use: l
alias l='ls'
# use: l1
alias l1='ls -1'
# use: ll
alias ll='ls -lha'
alias TF='tail -f '
# since i often screw this up
# use: sl
alias sl=ls
alias sizeof='du -hs '

# alias for exa
# use: e
alias e='exa --long --header --all --inode --extended --group'
# use: et
alias et='exa --long --header --all --inode --extended --group --tree'
# use: eg
alias eg='exa --long --header --all --inode --extended --group --git'
# use: et
alias etg='exa --long --header --all --inode --extended --group --git --tree'

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


# misc global aliases
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

# desc: global aliases for `less`
# use: cat huge.txt ,l
alias -g ,l=' | less '
# use: ./stdout+stderr.sh ,la
alias -g ,la="2>&1 | less"

# desc: global aliases for `grep`
# use: cat my.html ,g "<h3" ,g "id="
alias -g ,g=' | grep '
# use: cat all.log ,gv ignore_me
alias -g ,gv=' | grep --invert-match '
# use: cat ALLCAPS ,gi noncaps
alias -g ,gi=' | grep --ignore-case '
# use: cat CAPS.log ,giv ignore
alias -g ,giv=' | grep --ignore-case --invert-match '
# use: cat my.html ,go "href=[^ ]*"
alias -g ,go=' | grep --only '

# desc: global aliases for `sort`
# use: ls -1 ,s
alias -g ,s=' | sort '
alias -g ,sort=' | sort '
# use: cat lines ,sr
alias -g ,sr=' | sort --reverse '
# use: du -hs * ,sh
alias -g ,sh=' | sort --human-numeric-sort '
# use: du -hs * ,shr
alias -g ,shr=' | sort --human-numeric-sort --reverse '

# desc: global aliases for `wc` (counting)
# use: ls -1 ,count
alias -g ,count=' | wc --lines '
# use: ls -1 ,cl
alias -g ,cl=' | wc --lines '
# use: cat essay.txt ,cw
alias -g ,cw=' | wc --words '
# use: cat my.bin ,cb
alias -g ,cb=' | wc --bytes '

# desc: other global aliases
# use: ./run.daemon ,nul
alias -g ,nul='> /dev/null 2>&1'

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


# add zsh commands for switching themes on the fly

# reload the current zsh config (and with it the theme)
function zsh_reload_theme {
  source "$HOME"/.zshrc
}

# load a zsh theme
# $1 = name of the theme
function zsh_load_theme {
  theme=$1
  if [ -n "$theme" ]; then
    sed 's/ZSH_THEME=.*/ZSH_THEME="'$theme'"/' -i "$HOME"/.zshrc
    zsh_reload_theme
  else
    echo "usage: zsh_load_theme <name>"
  fi
}

# load zero for light background
function light_theme {
  zsh_load_theme "zero-light"
}

# load zero for dark backgrounds
function dark_theme {
  zsh_load_theme "zero-dark"
}
