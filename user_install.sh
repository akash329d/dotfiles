#!/bin/bash

# Sometimes install.sh is called with sudo, to be run as root user (for headless usage, etc.). 
# This leads to issues with file permissions, etc. This script is called by the main script as
# a login user to deal with that.

USER=${SUDO_USER:-${USER}}
USER_HOME=$(eval echo ~$USER)
SCRIPT_DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )

backup () {
    if [ -e ${USER_HOME}/${1} ] && mv ${USER_HOME}/${1} ${USER_HOME}/${1}-backup-$(date +"%Y-%m-%d_%s"); then
        echo "~/${1} already exists! Moving to ~/${1}-backup-$(date +"%Y-%m-%d_%s")"
    fi
}

# Backup ~/.zshrc
backup ".zshrc"

# Backup ~/.zsh folder
backup ".zsh"

# Backup ~/.vimrc 
backup ".vimrc"

# Copy dotfiles
cp ${SCRIPT_DIR}/.zshrc ${USER_HOME}/.zshrc
cp ${SCRIPT_DIR}/.vimrc ${USER_HOME}/.vimrc
cp ${SCRIPT_DIR}/.p10k.zsh ${USER_HOME}/.p10k.zsh


# Setup plugins directory
mkdir -p ${USER_HOME}/.zsh
pushd ${USER_HOME}/.zsh > /dev/null

# Clone plugins
git clone --quiet --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git
git clone --quiet --depth=1 https://github.com/zsh-users/zsh-autosuggestions
git clone --quiet --depth=1 https://github.com/agkozak/zsh-z.git
git clone --quiet --depth 1 https://github.com/junegunn/fzf.git
git clone --quiet --depth=1 https://github.com/Aloxaf/fzf-tab

# Install fzf
./fzf/install --all --no-bash --no-fish &> /dev/null

popd > /dev/null