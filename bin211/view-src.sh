#!/bin/sh

set -e

quitmsg=' — q to quit'

usage () {
    echo "Usage: ${progname} SRC_FILES..."
}

create_tmpfile () {
    local pid; pid=$$
    tmpfile=
    trap 'rm -f "$tmpfile"' EXIT
    tmpfile=$(mktemp -t view-src.${pid}.XXXXXX)
    chmod 600 "$tmpfile"
}

colorize () {
    pygmentize -P style=${STYLE:-lovelace} "$@"
}

header_line () {
    printf '\e[1m»»»%s\e[0m\n' "$1"
}

header () {
    header_line
    header_line " $1"
    header_line
    echo
}

footer () {
    echo
}

eprintf () {
    printf >&2 "$@"
}

process_args () {
    progname=${0##*/}
    if [ "$(which 2>/dev/null "$progname")" != "$0" ]; then
        progname=$0
    fi

    if [ $# = 0 ]; then
        exec >&2
        echo "${progname}: error: no files given"
        usage
        return 1
    fi

    local result; result=0
    local filename
    for filename in "$@"; do
        if ! [ -r "$filename" ]; then
            exec >&2
            echo "${progname}: error: could not read file: $filename"
            result=2
        fi
    done

    return $result
}

main () {
    process_args "$@"

    eprintf 'processing... '

    create_tmpfile
    local filename
    for filename; do
        if [ $# -gt 1 ]; then
            header "$filename"
        fi

        colorize "$filename"

        if [ $# -gt 1 ]; then
            footer
        fi
    done >> "$tmpfile"

    eprintf 'done.\n'

    eval "$(resize)"
    line_count=$(wc -l < "$tmpfile")
    line_avail=$(expr ${LINES:-25} - 2)

    if [ $line_count -gt $line_avail ]; then
        less -R < "$tmpfile"
    else
        sed "s/$quitmsg//" "$tmpfile"
    fi
}

### GO!
main "$@"
