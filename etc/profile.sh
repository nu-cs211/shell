# vim:se ft=sh sw=4:

umask 077

TOV_PUB=/home/jesse/pub
export TOV_PUB

PATH=$TOV_PUB/bin:$TOV_PUB/rust/cargo/bin:$PATH
export PATH

: ${MANPATH:=/usr/local/share/man:/usr/local/man:/usr/X11R6/man:/usr/share/man:/usr/man}
MANPATH=$TOV_PUB/share/man:$TOV_PUB/man:$MANPATH
export MANPATH

PKG_CONFIG_PATH=$TOV_PUB/pkgconfig:$TOV_PUB/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH

PYTHONHOME=$TOV_PUB
export PYTHONHOME
unset PYTHONPATH

: ${CC:=cc}
: ${CXX:=c++}
: ${CPPFLAGS:=-I$TOV_PUB/include}

export CC
export CXX
export CPPFLAGS

LDFLAGS=-L$TOV_PUB/lib${LDFLAGS:+ }$LDFLAGS
LD_LIBRARY_PATH=$TOV_PUB/lib$LD_LIBRARY_PATH
LD_RUN_PATH=$TOV_PUB/lib$LD_RUN_PATH

export LDFLAGS
export LD_LIBRARY_PATH
export LD_RUN_PATH

: ${ASAN_OPTIONS:=symbolize=1,print_scariness=1}
export ASAN_OPTIONS

: ${BROWSER:=w3m}
export BROWSER

: ${RUSTUP_TOOLCHAIN:=stable}
: ${RUSTUP_HOME:=$TOV_PUB/rust/rustup}
export RUSTUP_TOOLCHAIN
export RUSTUP_HOME

# Don't open X11 emacs
if [ -z "${KEEP_DISPLAY-}" ]; then
    unset DISPLAY
fi
