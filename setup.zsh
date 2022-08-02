#!/bin/zsh

if [[ -z $ZPLUG_HOME ]]; then
   export ZPLUG_HOME=~/.zplug
fi

if [ ! -d $ZPLUG_HOME ]; then
  git clone --quiet https://github.com/zplug/zplug.git $ZPLUG_HOME
fi

cat > ~/.zshrc <<- EOM
###### SECTION FOR DOTFILES ######

# P10K Instant Prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi

# Add zplug (https://github.com/zplug/zplug.git)
source ~/.zplug/init.zsh

zplug_install () {
  if ! zplug check --verbose; then
    zplug install
  fi
  zplug load
}

# Dotfiles
zplug "akash329d/dotfiles", use:"{zshrc,p10k}"

# Need to zplug install and load twice to first load my zshrc.
# Then install all packages added by zshrc.
zplug_install
zplug_install

###### DOTFILES END ######
EOM

echo "Dotfiles installation complete! Restart zsh to see changes!"