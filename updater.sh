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
    sudo softwareupdate --verbose --install --all

    brew update
    brew upgrade
    brew cleanup
    brew prune
    brew doctor

    brew cask cleanup
    brew cask doctor
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo pip2 install -U pip setuptools virtualenv virtualenvwrapper flake8 ipdb httpie argparse
    sudo pip3 install -U pip setuptools wheel flake8 ipdb argparse
elif [[ "$OSTYPE" == "darwin"* ]]; then
    pip2 install -U pip setuptools virtualenv virtualenvwrapper flake8 ipdb httpie argparse
    pip3 install -U pip setuptools wheel flake8 ipdb argparse
fi

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
cd -
source  ~/.zsh_aliases
source  ~/.zsh_functions
tmux start-server \; source-file ~/.tmux.conf

cd ~/dotfiles_work
git fetch --all
git rebase
cd -

cd ~/vim-ide
git fetch --all
git rebase
cd -
vim +PluginInstall +qa

cd ~/zsh-syntax-highlighting
git fetch --all
git rebase
cd -
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cd ~/dracula_zsh
git fetch --all
git rebase
cd -

if [[ "$OSTYPE" == "darwin"* ]]; then
    cd ~/dracula_iterm
    git fetch --all
    git rebase
    cd -

    cd ~/dracula_terminal_app
    git fetch --all
    git rebase
    cd -
fi

upgrade_oh_my_zsh

if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi
