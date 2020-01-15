#!/bin/sh

test -f $HOME/.zshrc ||
    echo "# Created automatically for CS 211" > $HOME/.zshrc

if SCL=$(which scl 2>/dev/null); then
    DEV211=1 RPS1=$RPS211 exec "$SCL" enable devtoolset-8 zsh
else
    DEV211=1 exec zsh
fi

