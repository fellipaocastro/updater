#!/bin/bash
rm ~/updater.sh
rm -rf ~/ubuntu-updater

git clone https://github.com/fellipecastro/ubuntu-updater.git ~/ubuntu-updater

ln -s ~/ubuntu-updater/updater.sh ~/updater.sh
