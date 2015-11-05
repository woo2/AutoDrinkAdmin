#!/bin/bash

echo "test" > test

git pull
sleep 1

echo -e "Starting AutoDrinkAdmin GUI: \n"

git log --pretty=oneline -1 | fold -w 80 -s

echo "test" > test

python gui.py
