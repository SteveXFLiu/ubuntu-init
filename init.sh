#!/bin/bash

# To install Linux system tools and data science tools

# Initial update and upgrade
apt update
apt upgrade -y

# Install system tools
apt install git curl

# Install and change to zsh
apt install zsh
chsh -s $(which zsh)

# Install oh-my-zh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sed -i 's/plugins=(git)/plugins=(git zsh-autopair zsh-autosuggestions zsh=syntax-highlighting fast-syntax-highlighting)' "~/.zshrc"

# Install and configure  Starship
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

mkdir -p ~/.config && touch ~/.config/starship.toml
starship preset no-runtime-versions -o ~/.config/starship.toml
