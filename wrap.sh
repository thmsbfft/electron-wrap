#!/bin/bash

# copy files
echo ""
echo "Copying files..."
echo ""
curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/package.json
curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/index-electron-wrap.js
curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/icon.icns

# replace name in package with current directory name
name=${PWD##*/}
sed -i '' "s/electron-wrap/$name/g" package.json

# install dependencies
echo ""
echo "Installing node modules..."
echo ""
npm i

# package the folder
npm run package