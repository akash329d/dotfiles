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

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# Rust Annex 
# zinit light zdharma-continuum/zinit-annex-rust

# zinit ice rustup cargo'exa;gitui;zoxide;bat' as"command" pick"bin/(exa|gitui|bat)" \
# atload='eval "$(./bin/zoxide init zsh --cmd cd)"'
# zinit light zdharma-continuum/null

zinit ice as"program" from"gh-r" mv"cargo-binstall* -> cbinstall" pick"bin/(exa|bat)" \
atclone"cbinstall --install-path ./bin --no-symlinks --no-confirm exa gitui zoxide bat" \
atload='eval "$(./bin/zoxide init zsh --cmd cd)"'
zinit light cargo-bins/cargo-binstall

# Bind ctrl/arrow keys
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Alias
alias la='exa --icons -a' # List All
alias dfu='zinit self-update; zinit update; exec zsh' # Dotfile Update
alias dfr='zinit delete --all --yes; zinit cclear; exec zsh' # Dotfile Replace (Delete old plugins)
alias cat='bat'
alias gui='gitui'

# vimrc
VIMRC_LOC=${SCRIPT_DIR}/vimrc
export VIMINIT="source ${VIMRC_LOC}"

# zuser
if [ -f "$HOME/.zuser" ] ; then
    source $HOME/.zuser
fi
