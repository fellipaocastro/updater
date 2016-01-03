sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean -y

sudo aptitude update -y
sudo aptitude upgrade -y
sudo aptitude clean -y

sudo pip2 install --upgrade pip setuptools virtualenv virtualenvwrapper flake8 ipdb httpie argparse
sudo pip3 install --upgrade pip setuptools flake8 ipdb httpie argparse --upgrade

gem update
gem cleanup

cd ~/ubuntu-updater && git fetch --all && git rebase && cd -

cd ~/dotfiles && git stash && git fetch --all && git rebase && git pop
source  ~/.zsh_aliases
source  ~/.zsh_functions
tmux source-file ~/.tmux.conf
cd -

cd ~/vim-ide && git fetch --all && git rebase && cd -
vim +PluginInstall +qa

if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi
