#!/bin/sh

cd "$PUB211"
git pull origin main
git ls-files . | grep -v '^scripts/' | xargs chmod a+rX
scripts/install.sh
