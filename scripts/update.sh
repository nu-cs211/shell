#!/bin/sh

cd "$PUB211"
git pull origin master
git ls-files . | grep -v '^scripts/' | xargs chmod a+rX
scripts/install.sh
