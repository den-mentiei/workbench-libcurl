#!/usr/bin/env bash

set -e

# TODO: other platforms handling.
case "$(uname -s)" in
    Darwin)
	OS="darwin"
	TARGET_DIR="bgfx/.build/macosx/bin"
	PROJECTS_DIR=".build/projects/macosx"
	PROC=`sysctl -n hw.ncpu`
	;;
    Linux)
	OS="linux"
	PROJECTS_DIR=".build/projects/gmake-linux"
	PROC=`nproc`
	;;
    *)
	echo "Unknown OS, exiting."
	exit 1
esac

EXE=""
PREMAKE="tools/$OS/premake5"$EXE
MAKE="make -j$PROC --no-print-directory"

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

# TODO: Make it work -- not supported yet on macOS.
$PREMAKE clean
$PREMAKE gmake

pushd $PROJECTS_DIR
$MAKE config=debug
$MAKE config=release
popd

cp curl/include/curl/*.h $INCLUDE_OUT
cp template.md           $INFO_OUT

git submodule >> $INFO_OUT
