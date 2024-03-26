#!/bin/bash

################################################################################
# Skriptname:     img-reducer-script.sh
# Beschreibung:   Mit diesem Script können sie ein Bild, welches auf Ihrem Laptop gespeichert haben,
#                 mittels einer Pfad angabe auswählen. Dannach wird das Bild automatisch verkleinert und sie 
#                 können das verkleinerte Bild wieder herunterladen.  
# Autor:          Ajnur Herbel, Aron Herbel & Hicolas Haas
# Datum:          19. March 2024
# Version:        1.0
################################################################################

# Bucket-Namen definieren
demo_users_images_bucket="demo-users-images-bucket"
demo_user_thumbnails_bucket="demo-user-thumbnails-bucket"

# Bucket erstellen - Demo Users Images
aws s3 mb s3://$demo_users_images_bucket

# Bucket erstellen - Demo User Thumbnails
aws s3 mb s3://$demo_user_thumbnails_bucket

echo "Buckets wurden erfolgreich erstellt:"
echo "- $demo_users_images_bucket"
echo "- $demo_user_thumbnails_bucket"

# Funktion zum Hochladen eines Bildes
upload_image() {
    local image_path="$1"
    local image_name="$(basename "$image_path")"
    local destination="s3://$demo_users_images_bucket/$image_name"
    
    # Bild hochladen
    aws s3 cp "$image_path" "$destination"

    echo "Bild erfolgreich hochgeladen nach $destination"
}

# Benutzer nach Pfad zu einem PNG-Bild fragen
read -p "Geben Sie den Pfad zu einem PNG-Bild ein, das hochgeladen werden soll: " image_path

# Überprüfen, ob die Datei existiert und ein PNG-Bild ist
if [ -f "$image_path" ] && [[ "$image_path" == *.png ]]; then
    upload_image "$image_path"
else
    echo "Ungültige Datei oder Dateityp. Bitte geben Sie einen gültigen Pfad zu einer PNG-Datei ein."
fi

#







# Funktion zum Herunterladen eines verkleinerten Bildes
download_thumbnail() {
    local image_name="$1"
    local destination="./$image_name-thumbnail.png"
    local source="s3://$demo_user_thumbnails_bucket/$image_name"
    
    # Verkleinertes Bild herunterladen
    aws s3 cp "$source" "$destination"

    echo "Verkleinertes Bild erfolgreich heruntergeladen nach $destination"
}

# Verkleinertes Bild herunterladen
download_thumbnail "$image_name"


# Clean up
echo "Lösche die Buckets..."
aws s3 rb s3://$demo_users_images_bucket --force
aws s3 rb s3://$demo_user_thumbnails_bucket --force

echo "Buckets wurden erfolgreich gelöscht."

