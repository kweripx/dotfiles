# Package Update

sudo add-apt-repository universe
sudo apt-get update
sudo apt-get upgrade

# Install Essentials 

echo "\nInstalling Essentials...\n"

sudo apt-get install build-essential libssl-dev

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

sudo apt-get install zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

sudo apt-get install docker
sudo apt-get install docker-compose
sudo apt-get install neovim
sudo apt-get install neofetch
sudo apt-get install htop
sudo apt-get install gnome-tweaks
sudo apt-get install gnome-tweak-tool
sudo apt-get install telegram-desktop
sudo apt-get install snapd
sudo apt-get install fonts-firacode
sudo snap install code --classic
sudo snap install gotop
sudo snap install insomnia
sudo snap install intellij-idea-ultimate --classic
sudo snap install android-studio --classic
sudo snap install spotify

# Downloading Outside Package

wget https://github.com/vercel/hyper/releases/download/3.0.2/hyper_3.0.2_amd64.deb
sudo apt install ./hyper_3.0.2_amd64.deb

wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/microsoft-edge-dev_88.0.673.0-1_amd64.deb
sudo apt install ./microsoft-edge-dev_88.0.673.0-1_amd64.deb



# Some config files

mkdir ~/Documentos/Stuffs
mkdir ~/Documentos/Work
mkdir ~/Documentos/Extensions
mkdir ~/Documentos/Course
git config --global user.name 'kweripx'
git config --global user.email '48696356+kweripx@users.noreply.github.com'
cp .oh-my-zsh ~/
cp .zshrc ~/
ssh-keygen -t rsa -b 4096 -C "48696356+kweripx@users.noreply.github.com"
git clone git@github.com:kweripx/dotfiles.git ~/Documentos/Stuffs/dotfiles

# Steam and comunication apps

apt search steam
sudo apt install steam
sudo apt update
sudo apt install python3-pip
pip3 install protonup
source ~/.profile

# GameHub

apt search gamehub
sudo apt install com.github.tkashkin.gamehub

# Lutris

apt search lutris
sudo apt install lutris

# Discord

sudo apt install discord
sudo apt-cache policy discord
