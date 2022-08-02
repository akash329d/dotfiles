#!/bin/zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"


if [ ! -d $ZINIT_HOME ]; then
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


cat > ~/.zshrc <<- EOM
###### SECTION FOR DOTFILES ######

# P10K Instant Prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi

# Add zinit (https://github.com/zdharma-continuum/zinit)
source "${ZINIT_HOME}/zinit.zsh"

# Dotfiles
zinit snippet 'https://github.com/akash329d/dotfiles/raw/main/zshrc'
zinit snippet 'https://github.com/akash329d/dotfiles/raw/main/p10k'

autoload -Uz compinit
compinit

zinit cdreplay -q

###### DOTFILES END ######
EOM

echo "Dotfiles installation complete! Restart zsh to see changes!"