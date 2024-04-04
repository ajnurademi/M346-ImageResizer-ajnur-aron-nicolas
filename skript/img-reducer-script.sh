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

AWS_CONFIG_FILE=~/.aws/config

# Original image
ORIGINALBUCKET=""

# To save the edited image
RESIZEDIMAGEBUCKET=""

# To scale the image
RESICEPERCENTAGE=0

# Creating Lambda Function
while true; do

    # Request Bucket name 
    echo "Please enter the name of the bucket for the raw images"
    read ORIGINALBUCKET

  # Checking if the bucket name already exists
  RESULT=$(aws s3api head-bucket --bucket $ORIGINALBUCKET 2>&1)

	echo $RESULT
  # Check result
  if [[ $RESULT = *404* ]]
   then
    echo "Bucket $ORIGINALBUCKET is available"
    echo "-----------------------------"
    aws s3 mb s3://$ORIGINALBUCKET
    echo "-----------------------------"
    break
  else
    echo "Bucket $ORIGINALBUCKET is not available , please try another name"
    echo "-----------------------------"
  fi
done