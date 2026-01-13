#!/bin/zsh
set -e

TOOLS=(fzf bat eza gitui jless zoxide atuin ripgrep)

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for this session
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"  # macOS ARM
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"     # macOS Intel
  elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"  # Linux
  fi
fi

# Install Sheldon and CLI tools
echo "Installing tools via Homebrew..."
brew install sheldon $TOOLS[@]

# Create Sheldon config that pulls dotfiles remotely
mkdir -p ~/.config/sheldon
cat > ~/.config/sheldon/plugins.toml <<'EOM'
shell = "zsh"

# Powerlevel10k theme (must be before dotfiles so p10k.zsh works)
[plugins.powerlevel10k]
github = "romkatv/powerlevel10k"

[plugins.fzf-tab]
github = "Aloxaf/fzf-tab"

[plugins.zsh-autosuggestions]
github = "zsh-users/zsh-autosuggestions"
use = ["{{ name }}.zsh"]

[plugins.zsh-syntax-highlighting]
github = "zsh-users/zsh-syntax-highlighting"

[plugins.zsh-alias-finder]
github = "akash329d/zsh-alias-finder"

# Dotfiles - sources zshrc (tools, aliases) and p10k.zsh (theme config)
[plugins.dotfiles]
github = "akash329d/dotfiles"
use = ["zshrc", "p10k.zsh"]
EOM

# Lock/install plugins
sheldon lock

# Add to .zshrc if not present
if ! grep -q "SECTION FOR DOTFILES" ~/.zshrc 2>/dev/null; then
  cat >> ~/.zshrc <<'EOM'

###### SECTION FOR DOTFILES ######

# P10K Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Sheldon plugins
eval "$(sheldon source)"

###### DOTFILES END ######
EOM
  echo "Dotfiles installed! Restart zsh to see changes."
else
  echo "Dotfiles already configured."
fi
