# vim: se ft=bash:

_scl_enable () {
    . /opt/rh/$1/enable &&
        export X_SCLS=$(scl enable $1 'echo $X_SCLS')
}

_try_scl_enable () {
    test -f /opt/rh/$1/enable &&
        _scl_enable $1
}

_scl_enable_first () {
    local pkg
    for pkg; do
        if _try_scl_enable $pkg; then
            return
        fi
    done
}
