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

RUST_TOOLS_TO_INSTALL="bat,exa,gitui,jless,zoxide,atuin" # Comma Delimited

if [ ! -f ~/.build_rust_tools ]
then
    # Use https://github.com/cargo-bins/cargo-binstall/ to install Rust CLI tools
    # XArgs and multiple atclones as temporary workaround until threading issues resolve with cargo-binstall
    zinit ice as"program" from"gh-r" mv"cargo-binstall* -> cbinstall" pick"bin/(${RUST_TOOLS_TO_INSTALL//,/|})" \
    atclone"./cbinstall --install-path ./bin --no-symlinks --no-confirm ${RUST_TOOLS_TO_INSTALL//,/ }" \
    atclone'./bin/zoxide init zsh --cmd cd > init.zsh' \
    run-atpull atpull"%atclone" src"init.zsh" nocompile'!'
    zinit light cargo-bins/cargo-binstall
else
    # Use Rust Annex if CBInstall doesn't have binaries. 
    zinit light zdharma-continuum/zinit-annex-rust

    zinit ice rustup cargo"${RUST_TOOLS_TO_INSTALL//,/;}" as"command" pick"bin/(${RUST_TOOLS_TO_INSTALL//,/|})" \
    atinit"./bin/zoxide init zsh --cmd cd > init.zsh" src"init.zsh"
    zinit light zdharma-continuum/null
fi

# Load atuin after installation
zinit load atuinsh/atuin

# Bind ctrl/arrow keys
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Alias
alias la='exa --icons -a' # List All
alias dfu='zinit self-update; zinit update --all; exec zsh' # Dotfile Update
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

# fzf ripgrep search
# Function to switch between Ripgrep mode and fzf filtering mode
# https://github.com/junegunn/fzf/blob/master/ADVANCED.md#using-fzf-as-interactive-ripgrep-launcher
fzf_rg_search() {
  rm -f /tmp/rg-fzf-{r,f}
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  local INITIAL_QUERY="${*:-}"
  fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ ripgrep ]] &&
        echo "rebind(change)+change-prompt(1. ripgrep> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
        echo "unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --prompt '1. ripgrep> ' \
      --delimiter : \
      --header 'CTRL-T: Switch between ripgrep/fzf' \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window ~8,+{2}-5 \
      --bind 'enter:become(code -g {1}:{2})'
}
alias rgf=fzf_rg_search