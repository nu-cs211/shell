# vim:se ft=sh sw=4:

umask 077

PUB211=/home/cs211/pub
export PUB211

PATH=$PUB211/bin:$PUB211/rust/cargo/bin:$PATH
export PATH

: ${MANPATH:=/usr/local/share/man:/usr/local/man:/usr/X11R6/man:/usr/share/man:/usr/man}
MANPATH=$PUB211/share/man:$PUB211/man:$MANPATH
export MANPATH

PKG_CONFIG_PATH=$PUB211/pkgconfig:$PUB211/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH

: ${CC:=cc}
: ${CXX:=c++}
: ${CPPFLAGS:=-I$PUB211/include}

export CC
export CXX
export CPPFLAGS

LDFLAGS=-L$PUB211/lib${LDFLAGS:+ }$LDFLAGS
LD_LIBRARY_PATH=$PUB211/lib$LD_LIBRARY_PATH
LD_RUN_PATH=$PUB211/lib$LD_RUN_PATH

export LDFLAGS
export LD_LIBRARY_PATH
export LD_RUN_PATH

: ${ASAN_OPTIONS:=symbolize=1,print_scariness=1}
export ASAN_OPTIONS

: ${BROWSER:=lynx}
export BROWSER

: ${BAT_STYLE:=header,grip,snip}
export BAT_STYLE

: ${RUSTUP_TOOLCHAIN:=stable}
: ${RUSTUP_HOME:=$PUB211/rust/rustup}
export RUSTUP_TOOLCHAIN
export RUSTUP_HOME

# Don't open X11 emacs
if [ -z "${KEEP_DISPLAY-}" ]; then
    unset DISPLAY
fi
