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
ZSH_THEME_PROMPT_CHAR_USER='∅'
ZSH_THEME_PROMPT_CHAR_GIT='±'
ZSH_THEME_PROMPT_CHAR_HG='☿'
ZSH_THEME_PROMPT_COLOR="\033[38;05;250m"
# Colors for git
ZSH_THEME_GIT_PROMPT_PREFIX="%{\033[38;05;075m%}"
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
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{\033[38;05;250m%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{\033[38;05;178m%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{\033[38;05;196m%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{\033[38;05;075m%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_PREFIX="%{$reset_color%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SUFFIX=" "

if [ "x$OH_MY_ZSH_HG" = "x" ]; then
    OH_MY_ZSH_HG="hg"
fi

function owned_by {
    desired="$1"
    path="$2"
    [ -d "$path/$desired" ] && return 0
    [ "$path" = "/" ] && return 127
    owned_by "$desired" "$(/usr/bin/dirname $path)"
}

function is_repo_git {
    git rev-parse 2>/dev/null
}

function is_repo_hg {
    owned_by ".hg" "$(pwd)"
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    $OH_MY_ZSH_HG prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function prompt_color {
  echo -n "%{$reset_color\033[38;05;250m%}"
}

# modified from oh-my-zsh due to rearranging dirty before ref-name 
function git_prompt_my_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function repo {
    is_repo_git && echo "$(git_time_since_commit)$(git_prompt_my_info)$(git_prompt_short_sha) "
    is_repo_hg && echo "$(hg_prompt_info)"
}

function prompt_char {
    # prompt color (root/user)
    echo -n "%{%(#~$fg[red]~\033[38;05;075m)%}"
    
    # promp character for git (git rev-parse is nice and fast, so it's fine)
    is_repo_git && echo "$ZSH_THEME_PROMPT_CHAR_GIT" && return
    # hg as command to test is too slow... do the pragmatic thing instead
    is_repo_hg && echo "$ZSH_THEME_PROMPT_CHAR_HG" && return

    # prompt char for user (root/user)
    echo "%(#~$ZSH_THEME_PROMPT_CHAR_ROOT~$ZSH_THEME_PROMPT_CHAR_USER)"
}

PROMPT='$(repo)$(prompt_color)$(virtualenv_info)$(prompt_char)%{$fg_bold[magenta]%}> '

local return_status="%{$fg[red]%}%(?..✘%? )"
RPROMPT='${return_status}$(prompt_color)%30<..<%~%<<%{$reset_color%}'

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    if git rev-parse > /dev/null 2>&1; then
        echo -n "$ZSH_THEME_GIT_TIME_SINCE_COMMIT_PREFIX"
        # we know we are in a git repo, let's see if there are commits
        last_commit=`git log --pretty=format:'%at' -1 2>/dev/null`

        # if there actually is a commit
        if [[ -n "$last_commit" ]]; then
            # Get the last commit.
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))

            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))

            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$MINUTES" -gt 10 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$HOURS" -gt 72 ]; then
                echo -n "$COLOR${DAYS}d%{$reset_color%}"
            elif [ "$HOURS" -gt 24 ]; then
                echo -n "$COLOR${DAYS}d${SUB_HOURS}h%{$reset_color%}"
            elif [ "$MINUTES" -gt 60 ]; then
                echo -n "$COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}"
            else
                echo -n "$COLOR${MINUTES}m%{$reset_color%}"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo -n "$COLOR~"
        fi
        echo "$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SUFFIX"
    fi
}

