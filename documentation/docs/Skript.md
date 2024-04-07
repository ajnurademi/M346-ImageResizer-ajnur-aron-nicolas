# M346 - Skript

## Skript-Dokumentation: img-reducer-script.sh

## Installation und Konfiguration von AWS CLI

Das Skript überprüft zunächst, ob die AWS CLI bereits installiert ist. Falls nicht, wird sie installiert. Anschliessend wird die Konfigurationsdatei für die AWS CLI erstellt, falls sie noch nicht existiert. Der Benutzer wird aufgefordert, seine AWS-Zugangsdaten einzugeben, und die eingegebenen Daten werden in der Konfigurationsdatei gespeichert.

``` js
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

```

### Bucket erstellen

In diesem Code wartet das Skript darauf, dass der Benutzer einen gültigen Bucket-Namen eingibt, und erstellt dann den Bucket, wenn der eingegebene Name nicht bereits verwendet wird.

```js
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

```

### Bucket erstellen für Komprimierte Bilder und Prozentzahl

Dieser Codeblock enthält zwei while-Schleifen, die den Benutzer zur Eingabe eines Bucket-Namens für komprimierte Bilder und eines Prozentsatzes für die Bildgrößenänderung auffordern. Hier ist eine Zusammenfassung:

```js
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

```

### Lambda-Funktion erstellen und konfigurieren

Das Skript erstellt eine Lambda-Funktion namens "imageConverter", falls sie noch nicht vorhanden ist. Dabei wird die Funktion für die Ausführung mit der Laufzeit Node.js 18.x konfiguriert. Es wird auch eine Berechtigung hinzugefügt, damit die Lambda-Funktion von S3-Events ausgelöst werden kann.

``` js
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


```

### Hochladen des Bildes

In diesem kurzen Abschnitt, werden die Variablen der Lambda-Funktion übergeben und das Bild wird in die das erste Bucket hochgeladen.

```js
# Passing the variables
aws lambda update-function-configuration --function-name imageConverter --environment "Variables={BUCKET_NAME_ORIGINAL=$BUCKETORIGINAL,BUCKET_NAME_COMPRESSED=$BUCKETCOMPRESSED, PERCENTAGE_RESIZE=$RESIZEPERCENTAGE}" --query "Environment"

# Uploading the image to the source bucket
aws s3 cp ImageTest.jpg s3://$BUCKETORIGINAL/ImageTest.jpg

sleep 5
```

### Herunterladen des verkleinerten Bildes

Das Bild wird auf dem Bucket hochgeladen

```js
echo "-----------------------------------------------------------------"
     echo "The image was uploaded :)"
echo "-----------------------------------------------------------------"
```

Das Skript bietet eine umfassende Automatisierungslösung für Bildverkleinerungsaufgaben und ermöglicht eine einfache Konfiguration und Verwendung von AWS-Diensten.

## Skript-Dokumentation: img-reducer-lamda.zip

```js

'use strict';

const AWS = require('aws-sdk');
const sharp = require('sharp');

exports.handler = async (event, context) => {
    // Creating an instance of the AWS S3 service
    const s3 = new AWS.S3();

    // Extracting the name of the original bucket from the S3 event
    const bucket = event.Records[0].s3.bucket.name;

    // Extracting the filename/key of the object triggering the event
    const key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));

    // percentage resize 
    let percentageResize = process.env.PERCENTAGE_RESIZE;

    try {
        // Retrieving the image data from the original bucket
        const data = await s3.getObject({ Bucket: bucket, Key: key }).promise();
        const image = sharp(data.Body);

        // Calculating the new size + metadata for image 
        const metadata = await image.metadata();
        let size = Math.round(metadata.width * percentageResize / 100);
        console.log(`Resizing ${key} to ${size}`);
        let resizedImage = await image.resize(size).toBuffer();

        // Uploading the resized image to the specified bucket
        await s3.putObject({
            Body: resizedImage,
            Bucket: s3.listObjects(process.env.BUCKET_NAME_COMPRESSED).params,
            Key: `resized-${key}`,
            ContentType: 'image/jpeg'
        }).promise();

        console.log(`Resized ${key} & uploaded to bucket`);

    } catch (err) {
        console.error(err);
    }
};

```
