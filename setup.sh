#!/bin/zsh

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

source ~/.zplug/init.zsh

# Dotfiles
zplug "akash329d/dotfiles", use:"{zshrc,p10k}"

# Install my dotfiles
zplug load --verbose

# Install plugins if there are plugins that have not been installed
zplug install

# Then, source plugins and add commands to $PATH
zplug load