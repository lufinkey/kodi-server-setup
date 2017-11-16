#!/bin/bash

# install packages with prompts
echo ""
echo "The next packages are going to have install prompts"
read -n 1 -s -p "Press any key to continue..."
echo ""
apt-get install $(cat "data/lists/prompted-packages.txt")

