#!/bin/bash

################################################################################
# Script Name:    img-reducer-script.sh
# Description:    With this script, you can select an image stored on your laptop
#                 using a path. Afterwards, the image will be automatically resized and 
#                 you can download the resized image again.
# Author:         Ajnur Ademi | Aron Herbel | Nicolas Haas
# Date:           26. March 2024
# Version:        1.3
################################################################################

# Check if aws CLI is installed
if command -v aws &> /dev/null
then
    echo "aws-cli is already installed"
else
    echo "aws-cli is installing ...."

    # Install AWS CLI
    sudo apt-get update
    sudo apt-get install -y awscli

    # Check if installation was successful
    if command -v aws &> /dev/null
    then
        echo "aws-cli installed successfully"
    else
        echo "Error by downloading aws-cli"
        exit 1
    fi
fi

