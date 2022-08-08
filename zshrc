# Script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd )

# Zsh Plugins
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light akash329d/zsh-alias-finder

# Binaries

zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

zinit ice as"program" from"gh-r" \
atclone"./zoxide init zsh > init.zsh" \
atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice from"gh-r" as"program"
zinit light extrawurst/gitui

zinit ice from"gh-r" as"program" pick"bin/exa" \
atclone"cp completions/exa.zsh _exa" atpull"%atclone"
zinit light ogham/exa

# Bind ctrl/arrow keys
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Alias
alias la='exa --icons --git -a' # List All
alias dfu='zinit self-update; zinit update --parallel; source ~/.zshrc' # Dotfile Update
alias dfr='zinit cclear; zinit delete --all --yes; source ~/.zshrc' # Dotfile Replace (Delete old plugins)
alias cat='bat'
alias gui='gitui'

# vimrc
VIMRC_LOC=${SCRIPT_DIR}/vimrc
export VIMINIT="source ${VIMRC_LOC}"

# zuser
if [ -d "$HOME/.zuser" ] ; then
    source $HOME/.zuser
fi

