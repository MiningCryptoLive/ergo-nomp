#!/bin/sh

# This is the EasyNOMP install script.
echo "EasyNOMP install script."
echo "Please do NOT run as root, run as the pool user!"

echo "Installing... Please wait!"

sleep 3


sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

sudo apt-get install -y sudo git nano wget curl ntp build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev git npm nodejs nodejs-legacy libminiupnpc-dev redis-server software-properties-common fail2ban 
sudo apt-get install libboost-all-dev libzmq3-dev libminiupnpc-dev
sudo apt-get install curl git build-essential libtool autotools-dev
sudo apt-get install automake pkg-config bsdmainutils python3
sudo apt-get install software-properties-common libssl-dev libevent-dev

git clone https://github.com/bitcoin/bitcoin.git
cd bitcoin
./autogen.sh
./configure
make
cd src
sudo install -sv bitcoind bitcoin-cli /usr/local/bin

wget http://download.oracle.com/berkeley-db/db-4.8.30.zip
unzip db-4.8.30.zip
cd db-4.8.30

sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' dbinc/atomic.h

cd bitcoin
./autogen.sh
./configure
make
cd src
sudo install -sv bitcoind bitcoin-cli /usr/local/bin/

sudo systemctl enable fail2ban
sudo systemctl start fail2ban

sudo systemctl enable redis-server
sudo systemctl start redis-server

sudo systemctl enable ntp
sudo systemctl start ntp

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

sleep 2

source ~/.bashrc

nvm install v8.1.4
nvm use v8.1.4
npm update -g

npm install -g pm2@latest
npm install -g npm@latest

cd ergonomp

npm install

npm update
npm audit fix


echo "Installation completed!"
echo "Please resume installation at the EasyNOMP Wiki: https://github.com/EasyX-Community/EasyNOMP/wiki"

exit 0
