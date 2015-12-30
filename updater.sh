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
cd ~/gitconfig && git fetch && git rebase && cd -
cd ~/ubuntu-updater && git fetch && git rebase && cd -
cd ~/.vim-ide && git fetch && git rebase && cd -
vim +PluginInstall +qall
