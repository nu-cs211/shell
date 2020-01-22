#!/bin/sh

which_program () {
    local each
    for each in "$@"; do
        if which $each 2>/dev/null; then
            return
        fi
    done

    false
}

if ! shell=$(which_program zsh bash ksh tcsh sh); then
    echo>&2 'dev: can’t find a shell to start. Please ask for help.'
    exit 10
fi

test -f $HOME/.zshrc ||
    echo "# Created automatically for CS 211" > $HOME/.zshrc

if SCL=$(which scl 2>/dev/null); then
    DEV211=1 RPS1=$RPS211 exec "$SCL" enable devtoolset-8 $shell
else
    DEV211=1 exec $shell
fi

