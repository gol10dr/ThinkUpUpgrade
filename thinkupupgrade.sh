#!/bin/bash
# Ask user if they have backed up the Thinkup database first
echo "Before upgrading ThinkUp, have you backed up ThinkUp's database? (Y/n)"
read BACKED_UP
while [ -z $BACKED_UP ]
do 
echo "Please type 'Y' or 'n'. Backup is important. You've been warned!"
echo "Before upgrading ThinkUp, have you backed up ThinkUp's database? (Y/n)"
read BACKED_UP
done
if [ $BACKED_UP = "Y" ]; then
	# Backup old ThinkUp directory
	echo  "What build of Thinkup would you like to install? Enter version number.. (ie. 1.0.1)"
	read NEW_BUILD
	echo "What build of Thinkup is currently installed? Enter version number... (ie. 1.0)"
	read OLD_BUILD
	echo "Backing up Thinkup build " $OLD_BUILD"..."
	sudo cp -R /var/www/thinkup /var/www/thinkup-$OLD_BUILD
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
	# Change permissions on data directory
	echo "Updating permissions on ThinkUp's data directory..."
	sudo chmod -R 777 /var/www/thinkup/data/
	wait 
	echo "...Done"
	# Remove zip download
	echo "Removing zip..."
	sudo rm /var/www/thinkup_$NEW_BUILD.zip
	wait
	echo "...Done"
	echo "ThinkUp has been upgraded from "$OLD_BUILD" to "$NEW_BUILD" successfully!"
elif [ $BACKED_UP = "n" ]; then
	echo "Please make sure ThinkUp's database is backed up before upgrading."
	echo "You can do this manually or go to the 'Application' tab in ThinkUp's settings menu."
	echo "...Bye!"
else
	echo "You have entered an incorrect answer. Please answer by typing 'Y' or 'n' next time."
	echo "The script is exiting!"
	echo "...Bye!"
fi
