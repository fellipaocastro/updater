for i in {1..2}
do
    sudo apt-get update upgrade autoremove clean -y
    sudo pip install --upgrade setuptools pip
    sudo pip3 install --upgrade pip
    sudo pip freeze | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
    sudo pip3 freeze | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
done
