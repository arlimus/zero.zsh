#!/bin/sh

DST="$(readlink -f ~)"
OHMY="$DST/.oh-my-zsh"
[ ! -d "$OHMY" ] && echo "Could not find oh-my-zsh in '$OHMY'. Make sure you install oh-my-zsh before trying to install this theme and plugin." && exit 0

cp -rv -t "$OHMY" plugins themes
echo "installed zero zsh theme and plugin to '$DST'"

[ -z "$(grep plugins ~/.zshrc | grep zero)" ] && echo "please add zero to your plugins in ~/.zshrc to use it"
[ -z "$(grep ZSH_THEME ~/.zshrc | grep zero)" ] && echo "please set your ZSH_THEME to zero in ~/.zshrc to use it"
