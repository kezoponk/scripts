# Shell Scripts

Created some useful scripts for personal use from time to time and thought it wouldn't hurt to share <br><br>

### Betteraptupgrade.sh [ REQUIRES SU NOT SUDO ]

Write in the excludes.txt file the packages that you don't want to update <br>
A good way to do this is to run the script, then script will output all upgradeable packages into the upgradeables.txt <br>
Locate unwanted upgrades in upgradeables.txt and paste them into excludes.txt <br><br>

### Electronbuilder.sh

In terminal: <code> ./electronbuilder FULL-PATH-TO-HTDOCS </code> <br>
Simple script to generate an electron app, the general reason why I created this is not because it is hard to build, <br>
but because I think it is messy to create the index.js and package.json files for each program even though they are not very <br>
specific for each program <br><br>

### Fake-access-point

> 1. Run script first to define all variables and create an airbase-ng session
> 2. ./sslstrip.sh
> 3. ./ettercap.sh

<br>
Use with caution and respect others privacy <br>
This creates a wifi that you create with one usb adapter, <br>
and redirect to a real network with your other adapter/card/ethernet <br>

Why would you go through all this trouble? <br>
sslstrip removes the encryption of traffic generated by connected machines
