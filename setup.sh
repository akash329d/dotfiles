#!/bin/zsh

set -e

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

source ~/.zplug/init.zsh

# Dotfiles
zplug "akash329d/dotfiles", use:"{zshrc,p10k}"

# Need to zplug install and load twice to first load my dotfiles
# Then install all packages my dotfiles add.
zplug install
zplug load

# Update dotfiles repo
zplug update

zplug install
zplug load