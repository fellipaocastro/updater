for i in {1..2}
do
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get autoremove
    sudo apt-get clean
    sudo pip install --upgrade setuptools
    sudo pip install --upgrade pip
    sudo pip3 install --upgrade pip
    sudo pip freeze | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
done
