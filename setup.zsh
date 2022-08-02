#!/bin/zsh

if [[ -z $ZPLUG_HOME ]]; then
   export ZPLUG_HOME=~/.zplug
fi

if [ ! -d $ZPLUG_HOME ]; then
  git clone https://github.com/zplug/zplug.git $ZPLUG_HOME
fi

cat > ~/.zshrc <<- EOM
###### SECTION FOR DOTFILES ######
# Add zplug (https://github.com/zplug/zplug.git)
source ~/.zplug/init.zsh

# Dotfiles
zplug "akash329d/dotfiles", use:"{zshrc,p10k}"

# Need to zplug install and load twice to first load my zshrc.
# Then install all packages added by zshrc.
if ! zplug check --verbose; then
  zplug install
fi
zplug load
if ! zplug check --verbose; then
  zplug install
fi
zplug load
###### DOTFILES END ######
EOM
