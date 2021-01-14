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

link_manual () {
    local src_sect="$1" src_name="$2"
    local dst_sect="$3" dst_name="$4"

    if man -w $dst_sect $dst_name >/dev/null 2>&1; then
        return
    fi

    if ! local src="$(man -w $src_sect $src_name 2>/dev/null)"; then
        echo>&2 "Manual not found: $src_name.$src_sect"
        return
    fi

    echo "Linking manual $src_name.$src_sect -> $dst_name.$dst_sect"

    local dst_dir=man/man$dst_sect
    local dst=$dst_dir/$dst_name.$dst_sect

    mkdir -p "$dst_dir"
    ln -s "$src" "$dst"
}

cd "$PUB211"

link_tree bin211 bin
link_tree man211 man

link_manual 1 gcc 1 cc
link_manual 1 g++ 1 c++

exit $exit_code

