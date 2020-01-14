#!/bin/sh
# vim: ts=4 noet

which scl >/dev/null 2>&1 && exit 0

fmt >&2 <<-EOF
	dev: error: The CS 211 dev environment isn’t available on
	$(hostname). Please try connecting to a different server.

	(A list of available login servers may be found at
	http://it.eecs.northwestern.edu/info/2015/11/03/info-labs.html.)

EOF

exit 1
