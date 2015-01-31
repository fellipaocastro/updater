for i in {1..2}
do
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
    sudo apt-get clean -y
    sudo pip install --upgrade setuptools
    sudo pip install --upgrade pip
    sudo pip3 install --upgrade pip
    sudo pip freeze | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
done
