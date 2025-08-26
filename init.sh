#!/bin/bash

# To install Linux system tools and data science tools

# Variables
PYTHON_VERSION=3.13
QUARTO_VERSION=1.7.33-linux-amd64

# Initial update and upgrade
apt update
apt upgrade -y

# Install system tools
apt install -y git curl

# Install and change to zsh
apt install -y zsh
chsh -s $(which zsh)

# Install oh-my-zh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autopair

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sed -i 's/plugins=(git)/plugins=(git zsh-autopair zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)' "$HOME/.zshrc"

# Install and configure  Starship
curl -sS https://starship.rs/install.sh | sh

echo 'eval "$(starship init zsh)"' >> $HOME/.zshrc

mkdir -p $HOME/.config && touch $HOME/.config/starship.toml
starship preset no-runtime-versions -o $HOME/.config/starship.toml

# System tools
apt install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

apt install -y tree

apt install -y build-essential

apt install vim
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mv $HOME/.vimrc $HOME/.vimrc_old
cp .vimrc $HOME/.vimrc

apt clean
apt autoremove

# uv and Python
curl -LsSf https://astral.sh/uv/install.sh | sh

uv python install ${PYTHON_VERSION}

# Install TeXLive
apt install -y texlive

# Install Quarto
curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.33/quarto-${QUARTO_VERSION}.deb
dpkg -i quarto-${QUARTO_VERSION}.deb
rm quarto-${QUARTO_VERSION}.deb
