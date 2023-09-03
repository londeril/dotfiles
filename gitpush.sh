#!/bin/sh
# git commit script to automate the most common usecase 

# make sure we are in the right directory
cd ~/.dotfiles

# make sure we are at the latest version of main
git pull

# add everything since the last git commit
git add ./*

# ask the user for a sensible git commit
read -p "what are you commiting? " commitstatement
git commit -m "$commitstatement"

