#!/bin/bash
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
    sudo apt-get clean -y
    
    sudo aptitude update -y
    sudo aptitude upgrade -y
    sudo aptitude clean -y
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew update
    brew upgrade
    brew cleanup
    brew prune
    brew doctor
    
    brew cask cleanup
    brew cask doctor
fi

sudo pip2 install -U pip setuptools virtualenv virtualenvwrapper flake8 ipdb httpie argparse thefuck
sudo pip3 install -U pip setuptools flake8 ipdb argparse

cd ~
gem update
gem cleanup
cd -

cd ~/updater
git fetch --all
git rebase
cd -

cd ~/dotfiles
git stash
git fetch --all
git rebase
git stash pop
source  ~/.zsh_aliases
source  ~/.zsh_functions
tmux source-file ~/.tmux.conf
cd -

cd ~/vim-ide
git fetch --all
git rebase
cd -
vim +PluginInstall +qa

cd ~/zsh-syntax-highlighting
git fetch --all
git rebase
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
cd -

if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi
