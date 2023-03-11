#!/bin/bash
branches=`git branch | grep -v \* | grep -v main`
echo About to delete the following branches:
echo $branches
read -p "Are you sure you wish to continue? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git branch -D $branches
fi
