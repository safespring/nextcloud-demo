#!/bin/bash
sudo apt install unzip
cd /tmp
wget https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip
unzip terraform_0.12.0_linux_amd64.zip
sudo cp ./terraform /usr/local/bin
cd -
