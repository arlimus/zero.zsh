#!/usr/bin/env zsh
cp -r -t ~/.oh-my-zsh/ plugins themes
[ -z "$(grep plugins ~/.zshrc | grep zero)" ] && echo "add zero to your plugins in ~/.zshrc"
[ -z "$(grep ZSH_THEME ~/.zshrc | grep zero)" ] && echo "set your ZSH_THEME to zero in ~/.zshrc"
