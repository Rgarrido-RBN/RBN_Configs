#!/bin/bash

set -e

CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
