#!/usr/bin/env bash

set -e

# TODO: other platforms handling.

OS="linux"
EXE=""
GENIE="tools/$OS/premake5"$EXE
MAKE="make -j$(nproc) --no-print-directory"

OUT=dist
INCLUDE_OUT="$OUT/include/curl"
INFO_OUT="$OUT/README.md"

pushd() {
    command pushd "$@" &> /dev/null
}

popd() {
    command popd "$@" &> /dev/null
}

rm -rf   .build
rm -rf   dist
rm -rf   $INCLUDE_OUT
mkdir -p $INCLUDE_OUT

$GENIE clean
$GENIE gmake

pushd .build/$OS
$MAKE config=debug
$MAKE config=release
popd

cp curl/include/curl/*.h $INCLUDE_OUT
cp template.md           $INFO_OUT

git submodule >> $INFO_OUT
