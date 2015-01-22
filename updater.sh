for i in {1..2}
do
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get autoremove
    sudo apt-get clean
    pip install --upgrade setuptools
    pip install --upgrade pip
    pip3 install --upgrade pip
    pip freeze | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
done
