 #!/bin/sh



source ~/.zplug/init.zsh

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Dotfiles
zplug "akash329d/dotfiles", at:dotfiles, use:"{zshrc,p10k}"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
  zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load