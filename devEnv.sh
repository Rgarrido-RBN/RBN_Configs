#/bin/sh

set -e

echo ">>>>>>>>>>>>>>>>>>> INSTALL sublime-text"
wget https://download.sublimetext.com/sublime-text_build-3211_amd64.deb
sudo dpkg -i sublime-text_build-3211_amd64.deb

echo ">>>>>>>>>>>>>>>>>>> INSTALL GIT"
sudo apt install git -y
sudo apt install gitk -y
sudo apt install kdiff3 -y

echo ">>>>>>>>>>>>>>>>>>> INSTALL VIM"
sudo apt install vim -y
sudo apt install neovim -y
sudo apt install clang-12 --install-suggests
sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y
sudo apt install curl -y
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --user neovim
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh

echo ">>>>>>>>>>>>>>>>>>> INSTALL SPOTIFY"
sudo snap install spotify

echo ">>>>>>>>>>>>>>>>>>> INSTALL CHROME"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo ">>>>>>>>>>>>>>>>>>> INSTALL VSCODE"
sudo snap install --classic code

echo ">>>>>>>>>>>>>>>>>>> CONFIGURE GIT"
read -p ">>>>Enter your user name for git: " gitUser
read -p ">>>>Enter your user mail for git: " gitMail
git config --global user.name '$gitUser'
git config --global user.mail '$gitMail'

echo ">>>>>>>>>>>>>>>>>>> CLONE REPOSITORIES"

mkdir -p $HOME/Projects && cd $HOME/Projects

git clone https://github.com/Rgarrido-RBN/BLEMidiESP32.git --branch develop
git clone git@github.com:Rgarrido-RBN/RPiCustomKernel.git --branch develop
git clone git@github.com:Rgarrido-RBN/RBN_Configs.git 
git clone https://github.com/Rgarrido-RBN/esp-idf.git --branch develop

echo ">>>>>>>>>>>>>>>>>>> REMOVING INSTALLATION FILES"

rm -rf $HOME/Projects/*.deb 

echo ">>>>>>>>>>>>>>>>>>> CONFIGURING ENVIROMENT"

sudo ln -sfn $HOME/.RBNCfg/nvim/init.vim $HOME/.config/nvim/init.vim
sudo ln -sfn $HOME/.RBNCfg/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
sudo ln -sfn $HOME/.RBNCfg/.bashrc $HOME/.bashrc
