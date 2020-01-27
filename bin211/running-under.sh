#!/bin/sh

running_under () {
    parent_commands_of $$ | grep -q "$1"
}

parent_commands_of () {
    local pid; pid=$1

    while true; do
        pid=$(parent_pid $pid | tr -d ' ')

        case "$pid" in
            ''|0|1) return
        esac
        ps -o comm= $pid
    done
}

parent_pid () {
    ps -o ppid= "$1"
}

running_under "$1"
