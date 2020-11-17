# vim:se ft=sh sw=4:

umask 077

setenv TOV_PUB /home/jesse/pub

set path = ($TOV_PUB/bin $TOV_PUB/rust/cargo/bin $path)

if (! $?MANPATH) setenv MANPATH /usr/local/share/man:/usr/local/man:/usr/X11R6/man:/usr/share/man:/usr/man
setenv MANPATH "$TOV_PUB/share/man:$TOV_PUB/man:$MANPATH"

if (! $?PKG_CONFIG_PATH) setenv PKG_CONFIG_PATH
setenv PKG_CONFIG_PATH "$TOV_PUB/lib/pkgconfig:$PKG_CONFIG_PATH"

setenv PYTHONHOME "$TOV_PUB"
unsetenv PYTHONPATH

if (! $?CC)        setenv CC cc
if (! $?CXX)       setenv CXX c++
if (! $?CPPFLAGS)  setenv CPPFLAGS "-I$TOV_PUB/include"

if (! $?LDFLAGS)          setenv LDFLAGS
if (! $?LD_LIBRARY_PATH)  setenv LD_LIBRARY_PATH
if (! $?LD_RUN_PATH)      setenv LD_RUN_PATH

setenv LDFLAGS          "-L$TOV_PUB/lib $LDFLAGS"
setenv LD_LIBRARY_PATH  "$TOV_PUB/lib:$LD_LIBRARY_PATH"
setenv LD_RUN_PATH      "$TOV_PUB/lib:$LD_RUN_PATH"

if (! $?ASAN_OPTIONS)   setenv ASAN_OPTIONS  symbolize=1,print_scariness=1
if (! $?BROWSER)        setenv BROWSER       w3m

if (! $?RUSTUP_TOOLCHAIN) setenv RUSTUP_TOOLCHAIN  stable
if (! $?RUSTUP_HOME)      setenv RUSTUP_HOME       "$TOV_PUB/rust/rustup"

# Don't open X11 emacs
if (! $?KEEP_DISPLAY)     unsetenv DISPLAY
