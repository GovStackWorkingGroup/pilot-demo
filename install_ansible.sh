#! /usr/bin/bash
apt update
apt -y upgrade
apt -y install python3-pip
pip install ansible
pip install passlib
mkdir /etc/ansible
echo localhost > /etc/ansible/hosts
