# Read all upgradeable packages into file
rm src/upgradeables.txt
sudo apt list --upgradeable >> src/upgradeables.txt

# Get file line length and turn it into int
listlength=$(wc -l < src/upgradeables.txt)
listlength=$(($listlength - 0))

# Read input of amount to be upgraded
echo $listlength available updates
echo How many to upgrade:
read amount

# Get file line length
excludelength=$(wc -l < src/excludes.txt)

# Break when end of file reached
while [ $listlength -gt 1 ] && [ $amount -gt 0 ]
do
  # Revalue excluded variable to false
  excluded="false"

  # Read current file row
  package=$(awk -v linenum=$listlength 'NR == linenum {print; exit}' src/upgradeables.txt)
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
      echo $package excluded
      break;
    fi
    excludelengthtemp=$(($excludelengthtemp - 1))
  done

  # Subtract listlength to change file line position
  # Subtract amount to break upgrade loop when wished amount of packages have been upgraded
  listlength=$(($listlength - 1))
  amount=$(($amount - 1))

  if [ "$excluded" == "false" ]
  then
    apt-get install -y $package
  fi
  
  echo Cleaning
  # Clean cache between each upgrade
  apt-get -y clean
  apt-get -y autoclean
  apt-get -y autoremove
done
