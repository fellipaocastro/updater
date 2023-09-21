#!/bin/bash
echo -e '\n---------------------------------------------------------------- [!] Processador\n'

lscpu | egrep 'Model name|Socket|Thread|NUMA|CPU\(s\)'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo -e '\n--------------------------------------------------------------------- [!] Ubuntu\n'

    lsb_release -a

    echo -e '\n'

    uname -r

    echo -e '\n'

    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
    sudo apt-get clean -y

    echo -e '\n'

    sudo aptitude update -y
    sudo aptitude upgrade -y
    sudo aptitude clean -y
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e '\n---------------------------------------------------------------------- [!] macOS\n'

    sw_vers

    echo -e '\n'

    sudo softwareupdate --schedule off
    sudo softwareupdate --verbose --install --all

    echo -e '\n'

    mas upgrade

    echo -e '\n'

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
        echo -e '\n-------------------------------------------------------------------- [!] updater\n'

        cd $HOME/updater && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dotfiles" ]; then
    (
        echo -e '\n------------------------------------------------------------------- [!] dotfiles\n'

        cd $HOME/dotfiles && \
        git stash && \
        git fetch --all && \
        git rebase && \
        git stash pop
    )
    source  ~/.zsh_aliases
    source  ~/.zsh_functions
    tmux start-server \; source-file ~/.tmux.conf
fi

if [ -d "$HOME/dotfiles_work" ]; then
    (
        echo -e '\n-------------------------------------------------------------- [!] dotfiles_work\n'

        cd $HOME/dotfiles_work && \
        git fetch --all && \
        git rebase
    )
    source  ~/.zsh_work
fi

if [ -d "$HOME/vim-ide" ]; then
    (
        echo -e '\n-------------------------------------------------------------------- [!] vim-ide\n'

        cd $HOME/vim-ide && \
        git fetch --all && \
        git rebase
    )
    vim +PluginInstall +qa
fi

if [ -d "$HOME/zsh-syntax-highlighting" ]; then
    (
        echo -e '\n---------------------------------------------------- [!] zsh-syntax-highlighting\n'

        cd $HOME/zsh-syntax-highlighting && \
        git fetch --all && \
        git rebase
    )
    source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -d "$HOME/dracula_zsh" ]; then
    (
        echo -e '\n---------------------------------------------------------------- [!] dracula_zsh\n'

        cd $HOME/dracula_zsh && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dracula_iterm" ]; then
    (
        echo -e '\n-------------------------------------------------------------- [!] dracula_iterm\n'

        cd $HOME/dracula_iterm && \
        git fetch --all && \
        git rebase
    )
fi

if [ -d "$HOME/dracula_terminal_app" ]; then
    (
        echo -e '\n------------------------------------------------------- [!] dracula_terminal_app\n'

        cd $HOME/dracula_terminal_app && \
        git fetch --all && \
        git rebase
    )
fi

echo -e '\n---------------------------------------------------------------- [!] pip upgrade\n'
pip install --upgrade pip

echo -e '\n--------------------------------------------------------------- [!] pyenv update\n'
pyenv update

echo -e '\n'

pyenv activate jupyter
pip install --upgrade pip
pyenv deactivate

echo -e '\n'

pyenv activate tools
pip install --upgrade pip
pyenv deactivate

echo -e '\n---------------------------------------------------------------- [!] asdf update\n'
asdf update
asdf plugin-update --all

echo -e '\n------------------------------------------------------------------------ [!] npm\n'
npm i -g npm

echo -e '\n----------------------------------------------------------- [!] docker cleansing\n'
docker system prune -af
docker image prune -af
docker container prune -f
docker volume prune -f

echo -e '\n----------------------------------------------------------------- [!] omz update\n'
omz update

echo -e '\n--------------------------------------------------------------------- [!] rehash\n'
if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi
