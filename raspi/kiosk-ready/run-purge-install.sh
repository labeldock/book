#!/bin/sh
echo "Clearing out unnecessary packages..."
sudo apt-get remove --purge wolfram-engine scratch nuscratch sonic-pi idle3 smartsim java-common minecraft-pi python-minecraftpi python3-minecraftpi libreoffice python3-thonny geany claws-mail bluej greenfoot
sudo apt-get autoremove

echo "Making sure everything is up to date..."
sudo apt-get update
sudo apt-get upgrade

echo "Installning necessary packages..."
sudo apt-get install unclutter chromium-browser -y