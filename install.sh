#!/bin/sh

link_carefully () {
    local src; src="$1"; shift
    local dst; dst="$1"; shift

    if [ -e "$dst" ] && ! [ -L "$dst" ]; then
        echo >&2 "Refusing to overwrite ‘$dst’"
    else
        echo ln -sf "$src" "$dst"
        ln -sf "$src" "$dst"
    fi
}

link_tree () {
    local src; src="$1"; shift
    local dst; dst="$1"; shift
    local path
    local base

    if [ -d "$src" ]; then
        mkdir -p "$dst"
        ls "$src/" | while read path; do
            base=$(basename "$path")
            link_tree "$src/$base" "$dst/$base"
        done
    else
        echo ln -sf "$src" "$dst"
    fi
}

cd "$(dirname "$0")"
link_tree bin211 bin
link_tree man211 man
