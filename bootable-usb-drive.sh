# Important: USB & disk partition must be fat32 for installing any linux
diskutil list
echo Full USB drive path:
read drive
echo Full path to image.iso:
read image

valid_disk=$('diskutil unmountDisk $drive')
drive_name=$('echo "$drive" | cut -d'/' -f2')

if [ "$valid_disk" == "Unmount of all volumes on $drive_name was successful" ]
then
  echo "Starting transfer, may take up to 2 hours"
  sudo dd if=$image of=$drive bs=8m
else
  echo "Invalid drive $drive_name"
fi

diskutil eject $drive
