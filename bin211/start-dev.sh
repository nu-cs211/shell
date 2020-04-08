#!/bin/sh
# vim:se sw=4:

. $TOV_PUB/etc/dev_profile

known_shells="$1 $DEV_SHELL fish zsh bash ksh tcsh sh"

which_first () {
    local each
    for each in "$@"; do
        if which $each 2>/dev/null; then
            return
        fi
    done

    false
}

if ! shell=$(which_first $known_shells); then
    echo>&2 'dev: can’t find a shell to start. Please ask for help.'
    exit 10
fi

case "$shell" in
    */zsh)
        if [ ! -f $HOME/.zshrc ]; then
            echo "# Created automatically for CS 211" > $HOME/.zshrc
        fi
        ;;
esac

if SCL=$(which scl 2>/dev/null); then
    DEV211=1 exec "$SCL" enable devtoolset-8 $shell
else
    DEV211=1 exec $shell
fi

