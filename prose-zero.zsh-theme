if [ "x$OH_MY_ZSH_HG" = "x" ]; then
    OH_MY_ZSH_HG="hg"
fi

function owned_by {
    desired="$1"
    path="$2"
    [ -d "$path/$desired" ] && return 0
    [ "$(/usr/bin/realpath $path)" = "/" ] && return 127
    owned_by "../$path" "$desired"
}

function is_repo_git {
    git rev-parse 2>/dev/null
}

function is_repo_hg {
    owned_by ".hg" "."
}

function prompt_char {
    # prompt color (root/user)
    echo -n "%{%(#~$fg[red]~\033[38;05;075m)%}"
    
    # promp character for git (git rev-parse is nice and fast, so it's fine)
    is_repo_git && echo '±' && return
    # hg as command to test is too slow... do the pragmatic thing instead
    is_repo_hg && echo '☿' && return

    # prompt char for user (root/user)
    echo '%(#~#~∅)'
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

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function prompt_prefix {
  echo -n "%{\033[38;05;250m%}"
}

function repo {
    is_repo_git && echo "$(git_time_since_commit)$(git_prompt_info) "
    is_repo_hg && echo "$(hg_prompt_info)"
}

#PROMPT='
#%{%(#~$fg[red]~$fg[blue])%}%n%{$reset_color%} at %{$fg[yellow]%}$(box_name)%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
#$(virtualenv_info)%{%(#~$fg[red]~$fg[blue])%}$(prompt_char)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} ) '
PROMPT='$(repo)$(prompt_prefix)$(basename $(pwd)) $(virtualenv_info)$(prompt_char)%{$fg_bold[magenta]%}> '

# Colors for git
ZSH_THEME_GIT_PROMPT_PREFIX="%{\033[38;05;075m%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{\033[38;05;196m%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{\033[38;05;214m%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
# Colors for git stati
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{\033[38;05;075m%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_PREFIX="%{$reset_color%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SUFFIX=" "


local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
RPROMPT='${return_status}%(?,, %?)%{$reset_color%}'

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    if git rev-parse > /dev/null 2>&1; then
        echo -n "$ZSH_THEME_GIT_TIME_SINCE_COMMIT_PREFIX"
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2>/dev/null`
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

            if [ "$HOURS" -gt 24 ]; then
                echo -n "$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}"
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

