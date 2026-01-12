#!/bin/zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install zinit if not already present
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Add dotfiles block to .zshrc if not already present
if ! grep -q "SECTION FOR DOTFILES" ~/.zshrc 2>/dev/null; then
  cat >> ~/.zshrc <<- 'EOM'

###### SECTION FOR DOTFILES ######

# P10K Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add zinit (https://github.com/zdharma-continuum/zinit)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Dotfiles
zinit ice pick"zshrc" src"p10k"
zinit light akash329d/dotfiles
zicompinit; zicdreplay

###### DOTFILES END ######
EOM
  echo "Dotfiles installed! Restart zsh to see changes. Run dfu to get updates, dfr for reinstall."
else
  echo "Dotfiles already installed in .zshrc"
fi