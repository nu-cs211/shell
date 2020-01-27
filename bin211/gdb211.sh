#!/bin/sh

find_gdb () {
    for path in $GDB211 /usr/local/bin/gdb /usr/bin/gdb; do
        if [ -x "$path" ]; then
            return
        fi
    done

    echo >&2 "Could not find GDB."
    exit 1
}

set_asan_options () {
    ASAN_OPTIONS=detect_leaks=0,abort_on_error=1,$ASAN_OPTIONS

    if [ -n "$EMACS" ]; then
        ASAN_OPTIONS=color=never,$ASAN_OPTIONS
    fi
}

find_gdb
set_asan_options
exec "$path" "$@"
