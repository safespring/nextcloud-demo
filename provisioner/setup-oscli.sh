#!/bin/bash
# Script that sets up a Python virtual environment and installs 
# OpenStack CLI clients to it

sudo apt-get install python-dev python-pip virtualenvwrapper build-essential

source /usr/share/virtualenvwrapper/virtualenvwrapper.sh 
mkdir -p /home/ubuntu/projects
mkdir -p /home/ubuntu/.virtualenvs

export WORKON_HOME="/home/ubuntu/.virtualenvs" 
export PROJECT_HOME="/home/ubuntu/.virtualenvs"

mkproject oscli
pip install --upgrade pip
pip install python-openstackclient

#workon oscli


