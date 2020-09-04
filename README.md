# Kezos Scripts

Created some useful scripts for personal use from time to time and thought it wouldn't hurt to share <br>

### Betteraptupgrade.sh [ REQUIRES SU NOT SUDO ]

Write in the excludes.txt file the packages that you don't want to update <br>
A good way to do this is to run the script, then script will output all upgradeable packages into the upgradeables.txt <br>
Locate unwanted upgrades in upgradeables.txt and paste them into excludes.txt <br><br>

### Electronbuilder.sh

In terminal: <code> ./electronbuilder FULL-PATH-TO-HTDOCS </code> <br>
Simple script to generate an electron app, the general reason why I created this is not because it is hard to build, <br>
but because I think it is messy to create the index.js and package.json files for each program even though they are not very <br>
specific for each program <br><br>

### Dictionary
Here very simple dictionary & flood attacks exist<br>
**Attack.py**:
Dictionary attack weak websites, uncomment in post_it function to customize password<br>
**Flood.py**:
Used on scam sites, specificaly the register page
