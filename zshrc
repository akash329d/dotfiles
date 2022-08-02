# Script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd )

# Zsh Plugins
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions"
zplug "agkozak/zsh-z"
zplug "Aloxaf/fzf-tab"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Binaries
zplug "sharkdp/bat", as:command, from:gh-r, use:"*x86_64*musl*", rename-to:bat
zplug "junegunn/fzf", as:command, from:gh-r

# Bind ctrl/arrow keys
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Alias
alias la='ls -aF'

# vimrc
VIMRC_LOC=${SCRIPT_DIR}/vimrc
export VIMINIT="source ${VIMRC_LOC}"