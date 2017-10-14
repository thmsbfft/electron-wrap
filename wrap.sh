#!/bin/bash

# copy files
echo "Copying files..."
curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/package.json
curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/index.js

# replace name in package with current directory name
name=${PWD##*/}
sed -i '' "s/electron-wrap/$name/g" package.json

# install dependencies
npm i

# package the folder
npm run package