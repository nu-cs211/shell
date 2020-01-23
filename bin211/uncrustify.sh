#!/bin/sh

pub=$(dirname $0)/..
cfg=$pub/etc/uncrustify.cfg

exec uncrustify -c "$pub" "$@"
