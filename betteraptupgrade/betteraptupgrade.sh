# Read all upgradeable packages into file
rm src/upgradeables.txt
sudo apt list --upgradeable >> src/upgradeables.txt

# Get file line length and turn it into int
listlength=$(wc -l < src/upgradeables.txt)
listlength=$(($listlength - 0))

# Read input of amount to be upgraded
echo $listlength available updates
read -p "How many to upgrade: " amount

read -p "Clean between each upgrade? Y/n[Y] " clean
routers=${clean:-Y}

# Get file line length
excludelength=$(wc -l < src/excludes.txt)
row=1

# Break when end of file reached
while [ $listlength -gt $row ] && [ $amount -gt 0 ]
do
  # Revalue excluded variable to false
  excluded="false"

  # Read current file row
  package=$(awk -v linenum=$row 'NR == linenum {print; exit}' src/upgradeables.txt)
  package="$(echo "$package" | cut -d'/' -f1)"
  excludelengthtemp=$(($excludelength - 0))

  echo
  echo $amount remaining upgrades
  echo Current step: $package

  # Compare with all packages in excludes file
  while [ $excludelengthtemp -gt 0 ]
  do
    # Read current file row
    excludedpackage=$(awk -v linenum=$excludelengthtemp 'NR == linenum {print; exit}' src/upgradeables.txt)
    excludedpackage="$(echo "$excludedpackage" | cut -d'/' -f1)"
    if [ "$package" == "$excludedpackage" ]
    then
      # If excluded=true then apt install package won't execute
      excluded="true"
      echo -e "\n$package excluded\n"
      break;
    fi
    excludelengthtemp=$(($excludelengthtemp - 1))
  done

  # Move to next line (row + 1)
  # Subtract amount to break upgrade loop when wished amount of packages have been upgraded
  row=$(($row + 1))
  amount=$(($amount - 1))

  if [ "$excluded" == "false" ]
  then
    apt-get install -y $package
  fi

  # Clean cache between each upgrade
  if [ "$clean" != "n" ]
  then
    echo Cleaning
    apt-get -y clean
    apt-get -y autoclean
    apt-get -y autoremove
  fi
done
