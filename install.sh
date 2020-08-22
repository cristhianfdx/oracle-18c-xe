# !/bin/bash
# Program to install Oracle Database services with docker
# Author: Cristhian Forero

echo "-------------------------------"
echo "Oracle 18c-XE DATABASE INSTALL"
echo "-------------------------------"

downloads_folder=~/Downloads
installer_file="oracle-database-xe-18c-1.0-1.x86_64.rpm"

if [ ! -d "~/docker-services" ]; then
    mkdir -p ~/docker-services/oracle/18c-xe
    mkdir -p ~/docker-services/oracle/tablespaces
    sudo apt install wget unzip -y
    wget https://www.dropbox.com/s/d1lcv1oaykzxxev/sqlcl.zip?dl=0 -O sqlcl.zip
    unzip sqlcl.zip
    mv sqlcl ~/docker-services/oracle/
    rm -rf sqlcl.zip
    cat aliases >> ~/.bashrc
fi

if [ ! -d $downloads_folder ]; then
    downloads_folder =~/Descargas
fi

if [ ! -f $PWD/18c-xe/files/$installer_file ]; then
    mv $downloads_folder/$installer_file $PWD/18c-xe/files/
fi

docker-compose up -d --build

docker-compose logs -f