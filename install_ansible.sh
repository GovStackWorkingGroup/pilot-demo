#! /usr/bin/bash
apt update
apt -y upgrade
apt -y install python3-pip
pip install ansible
mkdir /etc/ansible
echo localhost > /etc/ansible/hosts
