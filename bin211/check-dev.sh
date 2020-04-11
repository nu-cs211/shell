#!/bin/sh
# vim: ts=4 noet

unavailable () {
    fmt >&2 <<-....EOF
		dev: error: The CS 211 dev environment isn’t available on
		$(hostname). Please try connecting to a different server.

		(A list of available login servers may be found at
		http://it.eecs.northwestern.edu/info/2015/11/03/info-labs.html.)
....EOF

exit 2
}

cc_version () {
    cc --version 2>/dev/null |
        head -1 |
        sed -E 's/.*\b([[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+)\b.*/\1/'
}

if [ "$DEV211" = 1 ]; then
    echo >&2 'dev: error: already loaded'
    exit 1
fi

case "$(hostname)" in
    murphy.*)
        unavailable
        ;;
esac

case "$(cc_version)" in
    8.*|9.*)
        exit 0
        ;;
esac

if ! which scl >/dev/null 2>&1; then
	unavailable
fi
