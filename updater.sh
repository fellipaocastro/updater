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
    sudo softwareupdate --schedule off
    sudo softwareupdate --verbose --install --all

    brew update
    brew upgrade
    brew cleanup
    brew prune
    brew doctor

    brew tap caskroom/cask
    brew tap caskroom/versions
    brew tap homebrew/services

    brew cask cleanup
    brew cask doctor
fi

if [ -d "$HOME/updater" ]; then
    cd $HOME/updater
    git fetch --all
    git rebase
    cd -
fi

if [ -d "$HOME/dotfiles" ]; then
    cd $HOME/dotfiles
    git fetch --all
    git rebase
    cd -
    source  ~/.zsh_aliases
    source  ~/.zsh_functions
    tmux start-server \; source-file ~/.tmux.conf
fi

if [ -d "$HOME/dotfiles_work" ]; then
    cd $HOME/dotfiles_work
    git fetch --all
    git rebase
    cd -
    source  ~/.zsh_work
fi

if [ -d "$HOME/vim-ide" ]; then
    cd $HOME/vim-ide
    git fetch --all
    git rebase
    cd -
    vim +PluginInstall +qa
fi

if [ -d "$HOME/zsh-syntax-highlighting" ]; then
    cd $HOME/zsh-syntax-highlighting
    git fetch --all
    git rebase
    cd -
    source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -d "$HOME/dracula_zsh" ]; then
    cd $HOME/dracula_zsh
    git fetch --all
    git rebase
    cd -
fi

if [ -d "$HOME/dracula_iterm" ]; then
    cd $HOME/dracula_iterm
    git fetch --all
    git rebase
    cd -
fi

if [ -d "$HOME/dracula_terminal_app" ]; then
    cd $HOME/dracula_terminal_app
    git fetch --all
    git rebase
    cd -
fi

pip install --upgrade pip

pyenv activate jupyter3
pip install --upgrade pip
pyenv deactivate

pyenv activate ipython2
pip install --upgrade pip
pyenv deactivate

pyenv activate tools3
pip install --upgrade pip
pyenv deactivate

pyenv activate tools2
pip install --upgrade pip
pyenv deactivate

# if [[ "$OSTYPE" == "darwin"* ]]; then
    npm install -g npm
# fi

asdf plugin-update --all

upgrade_oh_my_zsh

if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi
