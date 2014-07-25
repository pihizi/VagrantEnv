#!/bin/sh

echo "#############################################"
echo "#####              NOTE                 #####"
echo "##### Errors may occur, can be ignored! #####"
echo "#############################################"

# source.list
echo "\n"
echo "# Change sources.list to 163.com:"
sudo cp /vagrant/sources.list/163.com /etc/apt/sources.list

sudo apt-get clean
echo "\n"
echo "# apt-get update:"
sudo apt-get -y update
echo "\n"
echo "# apt-get upgrand:"
sudo apt-get -y dist-upgrade

echo "\n"
echo "# Install git:"
sudo apt-get -y install git

echo "\n"
echo "# Install cURL:"
sudo apt-get -y install curl

echo "\n"
echo "# Install NodeJS:"
sudo apt-get -y install nodejs

echo "\n"
echo "# Install VIM 7.4:"
sudo add-apt-repository ppa:fcwu-tw/ppa
sudo apt-get update
sudo apt-get install vim

echo "\n"
echo "Install SDCV:"
sudo apt-get install sdcv
git clone https://github.com/pihizi/sdcv-dict.git /home/vagrant/.stardict/dic

echo "\n"
echo "# .vimrc .bashrc .bash_profile:"
git clone https://github.com/pihizi/LDE.git /tmp/LDE
mv /tmp/LDE/conf/.vimrc /home/vagrant/.vimrc
mv /tmp/LDE/conf/.bashrc /home/vagrant/.bashrc
mv /tmp/LDE/conf/.bash_profile /home/vagrant/.bash_profile
rm -rf /home/vagrant/.vim && mv /tmp/LDE/conf/.vim /home/vagrant/.vim
rm -rf /tmp/LDE

