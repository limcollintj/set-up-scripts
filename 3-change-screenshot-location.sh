#!/bin/bash

printf "\nChanging default screenshots location"

mkdir ~/Desktop/screenshots

defaults write com.apple.screencapture location ~/Desktop/screenshots

killall SystemUIServer
