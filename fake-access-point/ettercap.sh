source "./vars.txt"

# Listen to just created wifi
ettercap -p -u -T -q -i $at_interface
