#!/bin/bash
if [ -e package.json ]
then
    echo "/!\ package.json already exists."
    exit
else
  # get parameters
  read -p "Project name: " name
  read -p "Window width: " width
  read -p "Window height: " height

  # copy files
  echo ""
  echo "Copying files..."
  echo ""
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/package.json
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/index-electron-wrap.js

  # replace values
  sed -i '' "s/name-electron-wrap/$name/" package.json
  sed -i '' "s/WINDOW_WIDTH\ =\ null/WINDOW_WIDTH\ =\ $width/" index-electron-wrap.js
  sed -i '' "s/WINDOW_HEIGHT\ =\ null/WINDOW_HEIGHT\ =\ $height/" index-electron-wrap.js
  
  # if there's an icon, use it 
  # otherwise, download a generic icon
  if [ -e icon.icns ]; then
      sed -i '' "s/icon-electron-wrap.icns/icon.icns/" package.json
  else
      echo "Icon not found!"
      curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/icon-electron-wrap.icns
  fi
  
  # install dependencies
  echo ""
  echo "Installing node modules..."
  echo ""
  npm install electron --save-dev
  npm install electron-packager --save-dev
  npm install express --save

  # package the folder
  npm run package

  # cleanup
  rm package.json
  rm package-lock.json
  rm -rf node_modules
  rm index-electron-wrap.js
  rm icon-electron-wrap.icns

  osascript -e 'display notification "Electron wrap is done." with title "Finished!"'
fi