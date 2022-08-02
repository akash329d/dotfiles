# Script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd )

# Zsh Plugins
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k
zinit light agkozak/zsh-z
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Binaries

zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# Bind ctrl/arrow keys
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Alias
alias la='ls -aF' # List All
alias dfu='zinit update akash329d/dotfiles; source ~/.zshrc' # Dotfile Update
alis cat='bat'

# vimrc
VIMRC_LOC=${SCRIPT_DIR}/vimrc
export VIMINIT="source ${VIMRC_LOC}"
