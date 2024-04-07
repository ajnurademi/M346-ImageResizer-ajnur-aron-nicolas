<<<<<<< HEAD
# M346 - Skript
=======
---
runme:
  id: 01HTNN62EEWHEPK7PNRHF9WARF
  version: v3
---

# M346 - Script documentation
>>>>>>> 26625414e88d1f8cdfd553fe3d6ab49f905f4cf0

## Codeblocks

Some `code` goes here.

## Plain codeblock

A plain codeblock:

<<<<<<< HEAD
=======
```ini {"id":"01HTNN62EEWHEPK7PNR8SHJGPN"}
Some code here
def myfunction()
// some comment

```

>>>>>>> 26625414e88d1f8cdfd553fe3d6ab49f905f4cf0
## Code for a specific language

Some more code with the `py` at the start:

```py {"id":"01HTNN62EEWHEPK7PNRA64GKN3"}
import tensorflow as tf
def whatever()

```

## With a title

```py {"id":"01HTNN62EEWHEPK7PNRCPZXRDT"}
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]

```

## With line numbers

```py {"id":"01HTNN62EEWHEPK7PNRCV7T1ZY"}
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]

```

## Highlighting lines

```py {"id":"01HTNN62EEWHEPK7PNRFFF1J14"}
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]

```

## Icons and Emojs

:smile:

:fontawesome-regular-face-laugh-wink:

:fontawesome-brands-twitter:{ .twitter }

:octicons-heart-fill-24:{ .heart }

# Skript-Dokumentation: img-reducer-script.sh

**Installation und Konfiguration von AWS CLI:**
Das Skript überprüft zunächst, ob die AWS CLI bereits installiert ist. Falls nicht, wird sie installiert. Anschliessend wird die Konfigurationsdatei für die AWS CLI erstellt, falls sie noch nicht existiert. Der Benutzer wird aufgefordert, seine AWS-Zugangsdaten einzugeben, und die eingegebenen Daten werden in der Konfigurationsdatei gespeichert.

```
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

AWS_CONFIG_FILE=~/.aws/config

# Checking if AWS configuration file exists
if [ -f "$AWS_CONFIG_FILE" ]; then
    echo "AWS configuration already exists."
else
    echo "AWS configuration does not exist. Creating configuration now."

    # Creating configuration
    aws configure
    echo "Enter the session token with the variable aws_session_token= :"
    read userInput
    chmod --recursive 777 ~/.aws
    echo "$userInput" >> ~/.aws/credentials

    # Checking if configuration was created successfully
    if [ -f "$AWS_CONFIG_FILE" ]; then
        echo "AWS configuration created successfully."
    else
        echo "Error creating AWS configuration."
        exit 1
    fi
fi

BUCKETSOURCE=""
BUCKETDESTINATION=""
RESIZEPERCENTAGE=0

ARN=$(aws sts get-caller-identity --query "Account" --output text)

sed -i "s/ACCOUNT_ID/${ARN}/g" index-notification.json

```

**Lambda-Funktion erstellen und konfigurieren:**
Das Skript erstellt eine Lambda-Funktion namens "imageConverter", falls sie noch nicht vorhanden ist. Dabei wird die Funktion für die Ausführung mit der Laufzeit Node.js 18.x konfiguriert. Es wird auch eine Berechtigung hinzugefügt, damit die Lambda-Funktion von S3-Events ausgelöst werden kann. Ausserdem werden Umgebungsvariablen für die Bucket-Namen und die Prozentsatz-Grössenänderung der Bilder festgelegt.

```
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

AWS_CONFIG_FILE=~/.aws/config

# Checking if AWS configuration file exists
if [ -f "$AWS_CONFIG_FILE" ]; then
    echo "AWS configuration already exists."
else
    echo "AWS configuration does not exist. Creating configuration now."

    # Creating configuration
    aws configure
    echo "Enter the session token with the variable aws_session_token= :"
    read userInput
    chmod --recursive 777 ~/.aws
    echo "$userInput" >> ~/.aws/credentials

    # Checking if configuration was created successfully
    if [ -f "$AWS_CONFIG_FILE" ]; then
        echo "AWS configuration created successfully."
    else
        echo "Error creating AWS configuration."
        exit 1
    fi
fi

BUCKETSOURCE=""
BUCKETDESTINATION=""
RESIZEPERCENTAGE=0

ARN=$(aws sts get-caller-identity --query "Account" --output text)

sed -i "s/ACCOUNT_ID/${ARN}/g" index-notification.json

```

**Bildverarbeitung in S3-Buckets:**
Der Benutzer wird aufgefordert, den Namen des Buckets für die Originalbilder und den Namen des Buckets für die komprimierten Bilder einzugeben. Zusätzlich wird der Benutzer nach dem Prozentsatz für die Größenänderung der Bilder gefragt. Das Skript lädt dann ein Testbild in den Quell-Bucket hoch und wartet auf die Verarbeitung durch die Lambda-Funktion. Schliesslich wird das verkleinerte Bild aus dem Ziel-Bucket heruntergeladen und lokal gespeichert.

Das Skript bietet eine umfassende Automatisierungslösung für Bildverkleinerungsaufgaben und ermöglicht eine einfache Konfiguration und Verwendung von AWS-Diensten.
