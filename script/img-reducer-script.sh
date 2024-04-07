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

# Checking if aws CLI is installed
if command -v aws &> /dev/null
then
    echo "AWS CLI is already installed."
else
    echo "AWS CLI ist installing..."

    # Installing AWS CLI
    sudo apt-get update
    sudo apt-get install -y awscli

    # Checking if installation was successful
    if command -v aws &> /dev/null
    then
        echo "AWS CLI installed successfully."
    else
        echo "Error installing AWS CLI. Please check installation instructions for your system."
        exit 1
    fi
fi

CONFIGFILE=~/.aws/config

# Checking if AWS configuration file exists
if [ -f "$CONFIGFILE" ]; then
    echo "AWS configuration already exists."
else
    echo "AWS configuration does not exist. Creating configuration now."

    # Creating configuration
    aws configure
    echo "Session token with the variable aws_session_token= :"
    read userInput
    chmod --recursive 777 ~/.aws
    echo "$userInput" >> ~/.aws/credentials

    # Checking if configuration was created successfully
    if [ -f "$CONFIGFILE" ]; then
        echo "AWS configuration created successfully."
    else
        echo "Error creating AWS configuration."
        exit 1
    fi
fi

ARN=$(aws sts get-caller-identity --query "Account" --output text)

sed -i "s/ACCOUNT_ID/${ARN}/g" index-notification.json

BUCKETORIGINAL=""

BUCKETCOMPRESSED=""

RESIZEPERCENTAGE=0

# Creating the lambda function
while true; do

    # Asking for bucket name
    echo "Name of the bucket for original images:"
    # Storing in variable
    read BUCKETORIGINAL

    # Checking if bucket exists
    RESULT=$(aws s3api head-bucket --bucket $BUCKETORIGINAL 2>&1)

    echo $RESULT
    # Checking response
    if [[ $RESULT = *404* ]]
    then
        echo "Bucket $BUCKETORIGINAL is available"
        echo "-----------------------------------------------------------------"
        aws s3 mb s3://$BUCKETORIGINAL
        echo "-----------------------------------------------------------------"
        break
    else
        echo "Bucket $BUCKETORIGINAL is not available, please try again"
        echo "-----------------------------------------------------------------"
    fi
done

while true; do
    # Asking for bucket name
    echo "Name of the bucket for compressed images:"
    # Storing in variable
    read BUCKETCOMPRESSED

    # Checking if bucket exists
    RESULT=$(aws s3api head-bucket --bucket $BUCKETCOMPRESSED 2>&1)

    # Checking response
    if [[ $RESULT = *404* ]]
    then
        echo "Bucket $BUCKETCOMPRESSED is available"
        echo "-----------------------------------------------------------------"
        aws s3 mb s3://$BUCKETCOMPRESSED
        echo "-----------------------------------------------------------------"
        break
    else
        echo "Bucket $BUCKETCOMPRESSED is not available, please try again"
        echo "-----------------------------------------------------------------"
    fi
done

while true; do
    echo "Percentage for resizing the image:"
    read RESIZEPERCENTAGE

    if [[ $RESIZEPERCENTAGE =~ ^[0-9]+$ ]]; then
        echo "Percentage: $RESIZEPERCENTAGE%."
        break
    else
        echo "Error: Not valid percentage. (number without percent sign)"
    fi
done

# Checking if lambda function exists
existing_function=$(aws lambda get-function --function-name "imageConverter" 2>/dev/null)

if [ $? -eq 0 ]; then
    # If the function exists, delete it
    aws lambda delete-function --function-name imageConverter
    echo "Existing Lambda function deleted."
fi

# Creating the lambda function
aws lambda create-function --function-name imageConverter --runtime nodejs18.x --role arn:aws:iam::$ARN:role/LabRole --handler img-reducer-lamda.handler --zip-file fileb://./img-reducer-lamda.zip --memory-size 256

# Adding permission for S3 bucket and S3 trigger
aws lambda add-permission --function-name imageConverter --action "lambda:InvokeFunction" --principal s3.amazonaws.com --source-arn arn:aws:s3:::$BUCKETORIGINAL --statement-id "$BUCKETORIGINAL"

aws s3api put-bucket-notification-configuration --bucket "$BUCKETORIGINAL" --notification-configuration '{
    "LambdaFunctionConfigurations": [
        {
            "LambdaFunctionArn": "arn:aws:lambda:us-east-1:'$ARN':function:imageConverter",
            "Events": [
                "s3:ObjectCreated:Put"
            ]
        }
    ]
}'

# Passing the variables
aws lambda update-function-configuration --function-name imageConverter --environment "Variables={BUCKET_NAME_ORIGINAL=$BUCKETORIGINAL,BUCKET_NAME_COMPRESSED=$BUCKETCOMPRESSED, PERCENTAGE_RESIZE=$RESIZEPERCENTAGE}" --query "Environment"

# Uploading the image to the source bucket
aws s3 cp ImageTest.jpg s3://$BUCKETORIGINAL/ImageTest.jpg


sleep 5

echo "-----------------------------------------------------------------"
     echo "The image was uploaded :)"
echo "-----------------------------------------------------------------"