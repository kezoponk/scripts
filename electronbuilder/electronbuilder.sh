# Recommended
# height="600"
# width="1000"

# Settings
echo "Entered folder: "$1
echo "Name: "
read name
echo "Height: "
read height
echo "Width: "
read width
echo "Maximise window?[false]"
read maximise

if [ "$maximise" == "true" ]
then
  max="mainWindow.maximize"
fi

mkdir temp              # INIT
cp -a $1/. temp/htdocs  # Move selected folder to temp
cd temp
npm init

# Save
npm i electron --save-dev
npm i electron-packager --save-dev

# Edit package.json to fit electron
echo "Building package.json file"
old=$(awk 'NR==7 {$0="    \"start\": \"electron .\",\n    \"build\": \"electron-packager . '$name'\""} { print }' package.json)
rm package.json
printf "$old" >> package.json

# Electron settings and execution
echo "Generating index.js file"
echo "var app = require('electron').app
const { BrowserWindow } = require('electron')

app.on('ready', function() {
  var mainWindow = new BrowserWindow({
    width: $width,
    height: $height
  })
  $max
  mainWindow.loadURL('file://'+__dirname+'/htdocs/index.html')
})" >> index.js

echo "Done, building"
npm run build
