#!/bin/bash

echo "test" > test

git pull
sleep 1

figlet "Starting AutoDrinkAdmin GUI:"

git log --pretty=oneline -1 | fold -w 80 -s

echo "test" > test

python gui.py
