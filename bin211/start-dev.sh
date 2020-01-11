#!/bin/sh

if ! [ -f $HOME/.zshrc ]; then
    echo '# This is a commment' > $HOME/.zshrc
fi

DEV211=1
export DEV211

exec scl enable devtoolset-8 zsh
