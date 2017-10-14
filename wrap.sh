#!/bin/bash

# copy files
echo "Copying files..."

# replace name in package with current directory name
name=${PWD##*/}
sed -i '' "s/electron-wrap/$name/g" package.json

# install dependencies
npm i

