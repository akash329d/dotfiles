 #!/bin/sh

# Powerlevel10k instant prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd )

source ${SCRIPT_DIR}/zplug/init.zsh

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Zsh Plugins
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions"
zplug "agkozak/zsh-z"
zplug "Aloxaf/fzf-tab"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Binaries
zplug "sharkdp/bat", as:command, from:gh-r, use:"*x86_64*musl*", rename-to:bat
zplug "junegunn/fzf", as:command, from:gh-r


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load

# Source p10k profile
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Bind ctrl/arrow keys
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Alias
alias la='ls -aF'