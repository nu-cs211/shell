# vim:se ft=sh sw=4:

umask 077

# Returns whether $2 occurs in colon-delimited path $1.
_path_mem () {
    case :${1}: in
        (*:${2}:*) true  ;;
        (*)        false ;;
    esac
}

# Prints the result of prefixing to colon-delimited path $1 each
# subsequent argument that doesn't already occur in $1.
_path_pre () {
    local result="$1"; shift

    local segment
    for segment; do
        if ! _path_mem "$result" "$segment"; then
            result="$segment${result:+:}$result"
        fi
    done

    printf %s "$result"
}

# Given the name of an environment variable and a sequence of segments,
# updates the environment variable to add the segments not already
# present.
_exp_pre () {
    local var=$1; shift
    local val="$(eval printf '%s\\n' \$$var)"
    val="$(_path_pre "$val" "$@")"
    eval export "${var}=\"\${val}\""
}

export PUB211=/home/cs211/pub

: ${MANPATH:=/usr/local/share/man:/usr/local/man:/usr/X11R6/man:/usr/share/man:/usr/man}

_exp_pre PATH             $PUB211/rust/cargo/bin $PUB211/bin
_exp_pre MANPATH          $PUB211/man $PUB211/share/man
_exp_pre PKG_CONFIG_PATH  $PUB211/lib/pkgconfig $PUB211/pkgconfig

export SHELL211=${SHELL211:-fish}
export SHELL=$(which ${SHELL211})

export CC=${CC:-cc}
export CXX=${CXX:-c++}
export CPPFLAGS=${CPPFLAGS:--I$PUB211/include}

export LDFLAGS=-L$PUB211/lib${LDFLAGS:+ }$LDFLAGS
_exp_pre LD_LIBRARY_PATH        $PUB211/lib
_exp_pre LD_RUN_PATH            $PUB211/lib

# Suppress Make's default rules
export MAKEFLAGS=-r

# Enable some Address Sanitizer options
export ASAN_OPTIONS=${ASAN_OPTIONS:-symbolize=1,print_scariness=1}

# Improve Bat output format
export BAT_STYLE=${BAT_STYLE:-header,grid,snip}

# Use lynx as our web browser (for Fish help)
export BROWSER=${BROWSER:-lynx}

# Rust/Rustup configuration
export RUSTUP_HOME=${RUSTUP_HOME:-$PUB211/rust/rustup}
export RUSTUP_TOOLCHAIN=${RUSTUP_TOOLCHAIN:-stable}
