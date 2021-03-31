#!/bin/sh

cd "$PUB211"
git pull --ff-only origin main || exit 1
git ls-files . | grep -v '^scripts/' | xargs chmod a+rX
scripts/install.sh
