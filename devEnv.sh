#!/bin/bash

set -e

CONFIG_VIM_URL=https://raw.githubusercontent.com/Rgarrido-RBN/RBN_Configs/master/nvim/init.vim
CONFIG_ZSH_URL=https://raw.githubusercontent.com/Rgarrido-RBN/RBN_Configs/master/.zshrc

echo ">>>>>>>>>>>>>>>>> INSTALL PACKAGES"

sudo apt update
sudo apt install -y terminator \
    bat \
    cmake \
    build-essential \
    docker.io \
    ranger \
    xclip \
    python3-pip \
    
sudo apt-get update
sudo apt-get install the-silver-searcher -y

# for batcat binary
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Permissions for Docker | Launch Docker without sudo
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock

echo ">>>>>>>>>>>>>>>>>>> INSTALL GIT"
sudo apt install git -y
sudo apt install gitk -y
sudo apt install kdiff3 -y

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
git config --global alias.vi lg --all

echo ">>>>>>>>>>>>>>>>>>> INSTALL VIM"
sudo apt install vim -y
sudo apt install neovim -y
sudo apt install clang-12 --install-suggests
sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y
sudo apt install curl -y
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --user neovim
sudo apt-get install flex bison -y
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh

mkdir -p $HOME/.CECOcfg && cd $HOME/.CECOcfg

if [ -d $HOME/.config/nvim ];
then
    mkdir -p $HOME/.config/nvim
fi

if [ -z $HOME/.config/nvim/init.vim ];
then
    mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/initBCKP.vim
    curl $CONFIG_VIM_URL --output $HOME/.config/nvim/init.vim
else
    curl $CONFIG_VIM_URL --output $HOME/.config/nvim/init.vim
fi

echo ">>>>>>>>>>>>>>>>>>> INSTALL ZSH"

read -r -p "Do you want ZSH as your default shell? [y/n]: " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]];
then
    sudo apt-get install zsh -y
    chsh -s $(/usr/bin/zsh)
    curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
    mv $HOME/.zshrc $HOME/.zshrcBCK
    curl $CONFIG_ZSH_URL -o $HOME/.zshrc
    curl -L git.io/antigen > $HOME/antigen.zsh
fi

echo ">>>>>>>>>>>>>>>>>>> CONFIGURE GIT"

echo "Enter you git user Name: "
read gitName
echo "Enter you git user Mail: "
read gitMail

echo "git config --global user.name '$gitName'"
echo "git config --global user.mail '$gitMail'"

read -r -p "Do you want to generate ssh-key? [y/n]: " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]];
then
    ssh-keygen -t rsa -b 4096
    /bin/cat $HOME/.ssh/id_rsa.pub | xclip -sel clip
    echo ">>>>>>>>> ssh-key copied on clipboard"
    read 
    echo ">>>>>>>>>>>>> Press enter when ssh-key be added to your gitlab account"
    echo ">>>>>>>>>>>>> Ex: Gitlab->Preferences->ssh-key"
fi

echo ">>>>>>>>>>>>>>>>>>> CLONE REPOSITORIES"

if [ -d $HOME/Projects];
then 
    cd $HOME/Projects
else
    mkdir -p $HOME/Projects && cd $HOME/Projects
fi

git clone git@ssh-gitlab.cecotec.cloud:cecotec/firmware/superuniversaldummy.git --branch develop --recurse-submodules

finish () {
    echo "********* PRUDI ES UN PUTO MAQUINA ************"
}

trap finish EXIT

echo ">>>>>>>>>>>>>>>>>>> INSTALL VSCODE"

read -r -p "Do you want install vscode from snap? [y/n]: " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]];
then
    sudo snap install --classic code
fi

echo ">>>>>>>>>>>>>>>>>>> INSTALL SPOTIFY"

read -r -p "Do you want install spotify from snap? [y/n]: " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]];
then
    sudo snap install spotify
fi
