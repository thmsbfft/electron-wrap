#!/bin/bash
if [ -e package.json ]
then
    echo "/!\ package.json already exists."
    echo "/!\ Installation aborted."
    exit
else
  # copy files
  echo ""
  echo "Copying files..."
  echo ""
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/package.json
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/index-16C4D9BE52A4EB6B78A31B8D8E3E4B69CABFF4E92AAC86211505391619DE87D2.js
  curl -O https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/icon-16C4D9BE52A4EB6B78A31B8D8E3E4B69CABFF4E92AAC86211505391619DE87D2.icns

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

  # cleanup
  rm package.json
  rm index-16C4D9BE52A4EB6B78A31B8D8E3E4B69CABFF4E92AAC86211505391619DE87D2.js
  rm icon-16C4D9BE52A4EB6B78A31B8D8E3E4B69CABFF4E92AAC86211505391619DE87D2.icns
fi