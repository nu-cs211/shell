#!/bin/sh

test -f $HOME/.zshrc ||
    echo "# Created by $0" > $HOME/.zshrc

DEV211=1 exec scl enable devtoolset-8 zsh
