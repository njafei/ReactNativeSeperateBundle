#!/bin/sh

echo "\n\033[4m$(pwd)\033[0m"

_pwd="$(pwd)"


 react-native bundle --entry-file index.ios.js --platform ios --dev false --bundle-output ${_pwd}/main.jsbundle --assets-dest ${_pwd}
