#!/usr/bin/env bash
#***********************************************************************************************************************
# Name          : Docker Prerequisites
# Version       : 1.0
# Date          :
# Author        :
# Location      :
# Host          :
# User          :
# Description   :
#***********************************************************************************************************************

#Variale declration
HOME="."
mon=`date +'%Y%m'`
logs=$HOME"/log."$mon

main(){

log_write(){

        msg=$1
        echo -e "`date +%Y/%m/%d" "%T` ::$msg" >> $logs
}
install_docker(){

        sudo apt-get remove  -y docker docker-engine docker.io containerd runc > /dev/null 2>&1
        sudo apt-get update > /dev/null 2>&1
        sudo apt-get install -y \
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo apt-key fingerprint 0EBFCD88
        sudo add-apt-repository \
                "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) \
                stable"
        sudo apt-get update > /dev/null 2>&1
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null 2>&1
        sudo groupadd docker
        sudo usermod -aG docker $USER
        docker --version
        if [ "$?" -eq 0 ]
        then
                log_write "FUNCTION ${FUNCNAME[0]} ::docker installed successfully"
        else
                log_write "FUNCTION ${FUNCNAME[0]} ::docker installation failed"
        fi
}
}

#########Call Main Function############
main
docker --version
if [ $? -eq 0 ]
then
         log_write "FUNCTION ${FUNCNAME[0]} ::docker is already installed `docker --version`"
else
         log_write "FUNCTION ${FUNCNAME[0]} ::Function going to install docker"
         install_docker
fi
