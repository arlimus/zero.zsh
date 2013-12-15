#!/usr/bin/env bash

DIR="/tmp/install.zero.zsh"

set -eo pipefail
set -x

rm -rf "$DIR"
git clone https://github.com/arlimus/zero.zsh.git "$DIR"

cd "$DIR"
./install.sh