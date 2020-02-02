#!/bin/sh

# Everything should be public
umask 000

# Remember if an error happened
exit_code=0

link_carefully () {
    local src; src="$1"; shift
    local dst; dst="$1"; shift

    if [ -L "$dst" ]; then
        if [ "$(readlink "$dst")" = "$dots$src" ]; then
            return
        fi
        echo "Replacing $dst"
        rm -f "$dst"
    elif [ -e "$dst" ]; then
        echo >&2 "Refusing to overwrite $dst"
        exit_code=1
    else
        echo "Linking $src -> $dst"
        ln -s "$dots$src" "$dst"
    fi
}

link_tree () {
    local src; src="$1"; shift
    local dst; dst="$1"; shift
    local dots; dots="$1"; shift
    local path
    local base

    if [ -d "$src" ]; then
        mkdir -p "$dst"
        ls "$src/" | while read path; do
            base=$(basename "$path")
            link_tree "$src/$base" "$dst/$base" "../$dots"
        done
    else
        link_carefully "$src" "$dst" "$dots"
    fi
}

cd "$TOV_PUB"

link_tree bin211 bin
link_tree man211 man

exit $exit_code

