#!/bin/bash

if [ -z "$1" ]; then
	echo "Arg1 is empty... script exited"
elif [ "$1" = "TRUE"  -o  "$1" = "FALSE" ]; then
 	defaults write com.apple.finder AppleShowAllFiles $1
	killall Finder
	echo "AppleShowAllFiles is $1 and restarted Finder"
else
	echo "Incorrect value on arg1... script exited"
	exit
fi