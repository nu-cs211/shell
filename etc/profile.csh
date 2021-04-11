# vim:se ft=sh sw=4:

umask 077

setenv PUB211 /home/cs211/pub

set path = ($PUB211/bin $PUB211/rust/cargo/bin $path)

if (! $?MANPATH) setenv MANPATH /usr/local/share/man:/usr/local/man:/usr/X11R6/man:/usr/share/man:/usr/man
setenv MANPATH "$PUB211/share/man:$PUB211/man:$MANPATH"

if (! $?PKG_CONFIG_PATH) setenv PKG_CONFIG_PATH
setenv PKG_CONFIG_PATH "$PUB211/lib/pkgconfig:$PKG_CONFIG_PATH"

if (! $?SHELL211) setenv SHELL211 fish
setenv SHELL "$SHELL211"

if (! $?CC)        setenv CC cc
if (! $?CXX)       setenv CXX c++
if (! $?CPPFLAGS)  setenv CPPFLAGS "-I$PUB211/include"

if (! $?LDFLAGS)          setenv LDFLAGS
if (! $?LD_LIBRARY_PATH)  setenv LD_LIBRARY_PATH
if (! $?LD_RUN_PATH)      setenv LD_RUN_PATH

setenv LDFLAGS          "-L$PUB211/lib $LDFLAGS"
setenv LD_LIBRARY_PATH  "$PUB211/lib:$LD_LIBRARY_PATH"
setenv LD_RUN_PATH      "$PUB211/lib:$LD_RUN_PATH"

# Suppress Make's default rules
setenv MAKEFLAGS -r

if (! $?ASAN_OPTIONS)   setenv ASAN_OPTIONS  symbolize=1,print_scariness=1
if (! $?BROWSER)        setenv BROWSER       lynx
if (! $?BAT_STYLE)      setenv BAT_STYLE     header,grid,snip

if (! $?RUSTUP_TOOLCHAIN) setenv RUSTUP_TOOLCHAIN  stable
if (! $?RUSTUP_HOME)      setenv RUSTUP_HOME       "$PUB211/rust/rustup"
