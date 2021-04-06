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

    mas upgrade

    brew update-reset
    brew update
    brew upgrade
    brew cleanup
    brew doctor

    brew tap homebrew/cask
    brew tap homebrew/cask-versions
    brew tap homebrew/services

    brew cask doctor
fi

if [ -d "$HOME/updater" ]; then
    (
        cd $HOME/updater && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dotfiles" ]; then
    (
        cd $HOME/dotfiles && \
        git fetch --all && \
        git rebase
    )
    source  ~/.zsh_aliases
    source  ~/.zsh_functions
    tmux start-server \; source-file ~/.tmux.conf
fi

if [ -d "$HOME/dotfiles_work" ]; then
    (
        cd $HOME/dotfiles_work && \
        git fetch --all && \
        git rebase
    )
    source  ~/.zsh_work
fi

if [ -d "$HOME/vim-ide" ]; then
    (
        $HOME/vim-ide && \
        git fetch --all && \
        git rebase
    )
    vim +PluginInstall +qa
fi

if [ -d "$HOME/zsh-syntax-highlighting" ]; then
    (
        cd $HOME/zsh-syntax-highlighting && \
        git fetch --all && \
        git rebase
    )
    source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -d "$HOME/dracula_zsh" ]; then
    (
        cd $HOME/dracula_zsh && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dracula_iterm" ]; then
    (
        cd $HOME/dracula_iterm && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dracula_terminal_app" ]; then
    (
        cd $HOME/dracula_terminal_app && \
        git fetch --all && \
        git rebase
    )
fi

pip install --upgrade pip

pyenv update

pyenv activate jupyter
pip install --upgrade pip
pyenv deactivate

pyenv activate tools
pip install --upgrade pip
pyenv deactivate

asdf update
asdf plugin-update --all
npm i -g npm

docker system prune -af
docker image prune -af
docker container prune -f
docker volume prune -f

omz update

if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi
