# Get directory where this script lives (Sheldon clones it here)
DOTFILES_DIR="${0:A:h}"

# Tool init
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"

# Start atuin daemon in background zellij session if not running
if ! pgrep -qf "atuin daemon"; then
  zellij attach -c -b atuin-daemon &>/dev/null && zellij -s atuin-daemon run --direction down -- atuin daemon &>/dev/null
fi

# Key bindings
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Aliases
alias la='eza --icons -a'
alias cat='bat'
alias gui='gitui'
alias dfu='sheldon lock --update && exec zsh'

# Vim config
export VIMINIT="source ${DOTFILES_DIR}/vimrc"

# User customizations
[[ -f ~/.zuser ]] && source ~/.zuser

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
