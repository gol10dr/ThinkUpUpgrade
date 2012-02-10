#!/bin/bash
# Backup old ThinkUp directory
echo  "What build of Thinkup would you like to install?"
read NEW_BUILD
echo "What build of Thinkup is currently installed?"
read OLD_BUILD
echo "Backing up Thinkup build " $OLD_BUILD"..."
sudo cp -R /var/www/thinkup /var/www/thinkup-b4-$OLD_BUILD
wait
# Download new zip to server
echo "Downloading Thinkup build" $NEW_BUILD"..."
sudo wget https://github.com/downloads/ginatrapani/ThinkUp/thinkup_$NEW_BUILD.zip --no-check-certificate
wait
echo "...Done"
# Unpack zip into www root
echo "Unpacking tarball..."
sudo unzip -o /var/www/thinkup_$NEW_BUILD.zip
wait
echo "...Done"
# Remove zip download
echo "Removing zip..."
sudo rm /var/www/thinkup_$NEW_BUILD.zip
wait
echo "...Done"
echo "ThinkUp has been upgraded from "$OLD_BUILD" to "$NEW_BUILD" successfully!"