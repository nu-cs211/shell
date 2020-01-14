#!/bin/sh

test -f $HOME/.zshrc ||
    echo "# Created automatically for CS 211" > $HOME/.zshrc

DEV211=1 RPS1=$RPS211 exec scl enable devtoolset-8 zsh
