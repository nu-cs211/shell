# Setting Up `~cs211/pub`

## Install from source

 1. CMake
 2. Fish
 3. Mosh – depends on:
      - Google Protocol Buffers (full C++ version)
 4. clang-format (from Clang)
 5. lib211 (from `https://github.com/nu-cs211/lib211.git`)

## Install using Cargo

 1. gsc-client (clone `https://github.com/tov/gsc-client.git` and run
    `scripts/eecs-install.sh`)
 2. bat
 3. ripgrep

## Install binaries

 1. browsh (extract from RPM)

## Miscellany

 1. Run `scripts/install.sh` to:
      - link binaries from `bin211/` into `bin/`
      - link manual pages from `man211` into `man/`
      - create aliases for some system manuals (*e.g.,* make `cc.1`
        point to `gcc.1`)

 2. When `bat` is updated, need to put:
      - new `bat.1` in `$PUB211/man211/man1/`
      - new `bat.fish` `$PUB21/etc/fish/completions/`
    To build these files, run `cargo build` in `$PUB211/src/bat`; then
    look in `target/`
