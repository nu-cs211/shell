#!/bin/sh
# vim:se sw=4:

preferred_shells="$1 $DEV_SHELL fish zsh bash ksh tcsh sh"

which_first () {
    local each
    for each in "$@"; do
        if PATH=$TOV_PUB/bin:$PATH which $each 2>/dev/null; then
            return
        fi
    done

    false
}

if ! SHELL=$(which_first $preferred_shells); then
    echo>&2 '211: can’t find a shell to start. Please ask for help.'
    exit 10
fi
export SHELL

DEV211=1
export DEV211

if SCL=$(which scl 2>/dev/null); then
    exec "$SCL" enable gcc-toolset-9 "
        . $TOV_PUB/etc/211_profile
        exec $SHELL -l
    "
else
    . $TOV_PUB/etc/211_profile
    exec $SHELL -l
fi
