#!/bin/bash
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo '[!] Ubuntu -----------------------------------------------------------------------------------------'

    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
    sudo apt-get clean -y

    sudo aptitude update -y
    sudo aptitude upgrade -y
    sudo aptitude clean -y
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo '[!] macOS ------------------------------------------------------------------------------------------'

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
fi

if [ -d "$HOME/updater" ]; then
    (
        echo '[!] updater ----------------------------------------------------------------------------------------'

        cd $HOME/updater && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dotfiles" ]; then
    (
        echo '[!] dotfiles ---------------------------------------------------------------------------------------'
    
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
        echo '[!] dotfiles_work ----------------------------------------------------------------------------------'
    
        cd $HOME/dotfiles_work && \
        git fetch --all && \
        git rebase
    )
    source  ~/.zsh_work
fi

if [ -d "$HOME/vim-ide" ]; then
    (
        echo '[!] vim-ide ----------------------------------------------------------------------------------------'
    
        $HOME/vim-ide && \
        git fetch --all && \
        git rebase
    )
    vim +PluginInstall +qa
fi

if [ -d "$HOME/zsh-syntax-highlighting" ]; then
    (
        echo '[!] zsh-syntax-highlighting ------------------------------------------------------------------------'
    
        cd $HOME/zsh-syntax-highlighting && \
        git fetch --all && \
        git rebase
    )
    source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -d "$HOME/dracula_zsh" ]; then
    (
        echo '[!] dracula_zsh ------------------------------------------------------------------------------------'
    
        cd $HOME/dracula_zsh && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dracula_iterm" ]; then
    (
        echo '[!] dracula_iterm ----------------------------------------------------------------------------------'
    
        cd $HOME/dracula_iterm && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dracula_terminal_app" ]; then
    (
        echo '[!] dracula_terminal_app ---------------------------------------------------------------------------'
    
        cd $HOME/dracula_terminal_app && \
        git fetch --all && \
        git rebase
    )
fi

echo '[!] pip upgrade ------------------------------------------------------------------------------------'
pip install --upgrade pip

echo '[!] pyenv update -----------------------------------------------------------------------------------'
pyenv update

pyenv activate jupyter
pip install --upgrade pip
pyenv deactivate

pyenv activate tools
pip install --upgrade pip
pyenv deactivate

echo '[!] asdf update ------------------------------------------------------------------------------------'
asdf update
asdf plugin-update --all
npm i -g npm

echo '[!] docker cleansing -------------------------------------------------------------------------------'
docker system prune -af
docker image prune -af
docker container prune -f
docker volume prune -f

echo '[!] omz update -------------------------------------------------------------------------------------'
omz update

echo '[!] rehash -----------------------------------------------------------------------------------------'
if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi
