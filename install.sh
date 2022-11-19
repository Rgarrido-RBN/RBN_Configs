#!/bin/bash

set -e

CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ $1 == "clean"]
then
    rm -rf ~/.config/kittyBCKP ~/.config/nvimBCKP ~/.gitconfigBCKP 
    exit 1
fi

### KITTY TERMINAL
if [ -d ~/.config/kitty ]
then
    mv ~/.config/kitty ~/.config/kittyBCKP 
fi

ln -s ${CURRENT_PATH}/kitty/ ~/.config/kitty 

### NVIM CONFIG
if [ -d ~/.config/nvim ]
then
    mv ~/.config/nvim ~/.config/nvimBCKP
fi

ln -s ${CURRENT_PATH}/nvim/ ~/.config/nvim 

### GIT CONFIG

if [ -f ~/.gitconfig ]
then
    mv ~/.gitconfig ~/.gitconfigBCKP
fi

ln -s ${CURRENT_PATH}/gitconfig ~/.gitconfig 

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@  INSTALLATION COMPLETED  @@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "\n\n >>>>>>> If you want to remove backups run ./install clean\n\n"
