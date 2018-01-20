#!/bin/bash

set -e
git add .
if [ "$1" = "" ]
then
    git commit -m "added article."
else
    git commit -m "$1"
fi
git push -u origin master
exit 0
