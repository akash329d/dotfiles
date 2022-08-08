#!/bin/zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"


cat > ~/.zshrc <<- EOM
###### SECTION FOR DOTFILES ######

# P10K Instant Prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi

# Add zinit (https://github.com/zdharma-continuum/zinit)
source "${ZINIT_HOME}/zinit.zsh"

# Dotfiles
zinit ice pick"zshrc" src"p10k"
zinit light akash329d/dotfiles
zicompinit; zicdreplay

###### DOTFILES END ######
EOM

echo "Dotfiles installation complete! Restart zsh to see changes. Run dfu to get updates, dfr for reinstall."