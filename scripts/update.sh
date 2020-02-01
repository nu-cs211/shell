#!/bin/sh

cd "$TOV_PUB"
git pull origin master
git ls-files . | grep -v '^scripts/' | xargs chmod a+rX
scripts/install.sh
