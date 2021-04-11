#!/bin/sh

find_gdb () {
    for gdb_path in $GDB211 /usr/local/bin/gdb /usr/bin/gdb; do
        if [ -x "$gdb_path" ]; then
            return
        fi
    done

    echo >&2 "Could not find GDB."
    exit 1
}

hide_my_python () {
    unset PYTHONHOME
}

has_xterm_color_emacs () {
    grep -sq xterm-color "$HOME/.emacs"
}

adjust_term_type () {
    if [ "$TERM" = dumb ] && has_xterm_color_emacs; then
        case "$INSIDE_EMACS" in
            *,comint)
                TERM=ansi
                export TERM
                ;;
        esac
    fi
}

set_asan_options () {
    ASAN_OPTIONS=detect_leaks=0,abort_on_error=1,$ASAN_OPTIONS

    if [ "$TERM" = dumb ]; then
        ASAN_OPTIONS=color=never,$ASAN_OPTIONS
    fi

    export ASAN_OPTIONS
}

find_gdb
hide_my_python
adjust_term_type
set_asan_options

exec "$gdb_path" "$@" 2>&1 |
    exec ubgrepv 'warning: Loadable section ".note.gnu.property" outside of ELF segments'
