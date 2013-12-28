# zero theme for zsh
# by Dominik Richter
#
# started using bits and pieces from:
# * prose zsh theme by Steve Losh
#   https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
# * dogenpunkt zsh theme by Matthew M. Nelson
#   shipped with oh-my-zsh

# Theme configuration
ZSH_THEME_PROMPT_CHAR_ROOT='#'
ZSH_THEME_PROMPT_CHAR_USER='$'
ZSH_THEME_PROMPT_CHAR_GIT='±'
ZSH_THEME_PROMPT_CHAR_HG='☿'
ZSH_THEME_PROMPT_COLOR="\033[38;05;238m"
ZSH_THEME_PROMPT_SHOW_HOSTNAME='1'
ZSH_THEME_PROMPT_CLASSIC_VIEW='1'
ZSH_THEME_PROMPT_ROOT="$fg[red]"
ZSH_THEME_PROMPT_USER="\033[38;05;027m"
# Repo stuff
ZSH_THEME_REPO_PROMPT_PREFIX=""
ZSH_THEME_REPO_PROMPT_SUFFIX=""
# Colors for git
ZSH_THEME_GIT_PROMPT_PREFIX="%{\033[38;05;027m%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{\033[38;05;208m%}" # "%{\033[38;05;196m%}*"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{\033[38;05;214m%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$ZSH_THEME_PROMPT_COLOR%}["
ZSH_THEME_GIT_PROMPT_SHA_AFTER="]"
# Colors for git stati
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}═"
# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{\033[38;05;238m%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{\033[38;05;178m%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{\033[38;05;196m%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{\033[38;05;027m%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_PREFIX="%{$reset_color%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SUFFIX=" "

source "$ZSH/themes/zero.zsh-theme.base"