#!/bin/bash
rm -f ~/updater.sh
rm -rf ~/updater

git clone https://github.com/fellipecastro/updater.git ~/updater

ln -s ~/updater/updater.sh ~/updater.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo -e '\nexport PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc
fi
