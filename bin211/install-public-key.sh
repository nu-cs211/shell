#!/bin/sh

keyfile=authorized_keys

input="$(cat)"
key_itself=$(printf %s "$input" | sed -E '
    s/^[^[:space:]]+[[:space:]]+//
    s/[[:space:]]+[^[:space:]]+$//
    /[[:alnum:]\/+=]{20,}/! d
    q
')

if [ -z "$key_itself" ]; then
    printf>&2 \
        'This input does not look like an OpenSSH public key: ‘%s’\n' \
        "$input"
    exit 1
fi

mkdir -p "$HOME/.ssh"
cd "$HOME/.ssh"
touch "$keyfile"

chmod 700 .
chmod 600 "$keyfile"

if fgrep "$key_itself" "$keyfile" >/dev/null 2>&1; then
    echo "Key already installed; nothing to do."
else
    printf '%s\n' "$input" >> "$keyfile"
    echo "Key successfully installed to ${keyfile}."
fi
