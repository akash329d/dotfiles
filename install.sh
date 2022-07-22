#!/bin/bash

# Script to quickly setup terminal on MacOS/Ubuntu

set -e

# Get user home (in case they ran with sudo)
USER=${SUDO_USER:-${USER}}
SCRIPT_DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )

if command -v apt-get &> /dev/null; then
    sudo apt-get -qq update
    if ! sudo apt-get install bat; then
        # Install bat manually since it isn't in package lists for Ubuntu < 18
        curl -s -L https://github.com/sharkdp/bat/releases/download/v0.21.0/bat-musl_0.21.0_amd64.deb --output bat.deb
        sudo dpkg -i bat.deb
        rm bat.deb
    fi
fi

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null && (command -v bat &> /dev/null || command -v batcat &> /dev/null); then
    echo "zsh/git/wget/bat already installed!"
else
    if sudo apt install -y -qq zsh git wget || sudo brew install git zsh wget bat; then
        echo "Installed zsh/git/wget/bat"
    else
        echo "Could not successfully install zsh/git/wget/bat. Please rerun after installing!"
        exit
    fi
fi

# Call user_install.sh as user
sudo -u ${USER} -H ${SCRIPT_DIR}/user_install.sh


if sudo chsh -s $(which zsh) ${USER}; then
    echo 'Changed default shell to ZSH. Restart session!'
else
    echo 'Could not change default shell :('
fi