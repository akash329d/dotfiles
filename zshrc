# Script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd )

source ~/.zplug/init.zsh

# Zsh Plugins
zi ice depth"1" # git clone depth
zi light romkatv/powerlevel10k
zi light zsh-users/zsh-autosuggestions
zi light agkozak/zsh-z
zi light Aloxaf/fzf-tab
zi light zsh-users/zsh-syntax-highlighting

# Binaries
zi ice from"gh-r" as"program"
zi light sharkdp/bat

zi ice from"gh-r" as"program"
zi light junegunn/fzf

# Bind ctrl/arrow keys
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Alias
alias la='ls -aF'

# vimrc
VIMRC_LOC=${SCRIPT_DIR}/vimrc
export VIMINIT="source ${VIMRC_LOC}"