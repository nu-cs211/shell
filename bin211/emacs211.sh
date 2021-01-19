#!/bin/sh

case "${1-}" in
    (-w|--window-system)
        shift
        nw_flag=
        ;;
    (*)
        nw_flag=-nw
        ;;
esac

for emacs_path in $(whereis -b emacs); do
    case $emacs_path in
        (emacs:|*cs211/pub*)
            continue ;;
        (*)
            exec "$emacs_path" $nw_flag "$@" ;;
    esac
done

echo >&2 'Could not find Emacs.'
exit 1

