#!/bin/sh

# read .zshrc to find path to oh-my-zsh
ZSHRC="$HOME/.zshrc"

[ ! -f "$ZSHRC" ] && echo "can't find '$ZSHRC', aborting" && exit 0

echo "-- loading your configuration file: '$ZSHRC'"
source "$ZSHRC" > /dev/null 2>&1
OHMY="$ZSH"
[ ! -d "$OHMY" ] && echo "ee Could not find oh-my-zsh in '$OHMY'. Make sure you install 'oh-my-zsh' before trying to install this theme and plugin." && exit 0

echo "-- copying files to oh-my-zsh in: '$OHMY'"
cp -r -t "$OHMY" plugins themes
echo "ok installed zero zsh successfully (theme: zero, plugins: zero)"

[ -z "$(grep plugins ~/.zshrc | grep zero)" ] && echo "   please add zero to your plugins in ~/.zshrc to use it"
[ -z "$(grep ZSH_THEME ~/.zshrc | grep zero)" ] && echo "   please set your ZSH_THEME to zero in ~/.zshrc to use it"
