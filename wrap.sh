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

  ICON=true
  if [ ! -f icon.icns ]; then
      echo "Icon not found!"
      ICON=false
  fi

  # copy files
  echo ""
  echo "Copying files..."
  echo ""
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/package.json
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/index-electron-wrap.js
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/icon-electron-wrap.icns

  # replace values
  sed -i "s/electron-wrap/$name/" package.json
  sed -i "s/WINDOW_WIDTH\ =\ null/WINDOW_WIDTH\ =\ $width/" index-electron-wrap.js
  sed -i "s/WINDOW_HEIGHT\ =\ null/WINDOW_HEIGHT\ =\ $height/" index-electron-wrap.js
  if $ICON ; then
    sed -i "s/icon-electron-wrap.icns/icon.icns/" package.json
  fi

  # install dependencies
  echo ""
  echo "Installing node modules..."
  echo ""
  npm i

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