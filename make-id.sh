#!/usr/bin/env bash

pushd() {
    command pushd "$@" &> /dev/null
}

popd() {
    command popd "$@" &> /dev/null
}

head8() {
    git rev-parse HEAD | cut -c 1-8
}

id() {
    pushd curl
    local CURL_HEAD=$(head8)
    popd

    pushd zlib
    local ZLIB_HEAD=$(head8)
    popd

    pushd mbedtls
    local MBEDTLS_HEAD=$(head8)
    popd

    echo $CURL_HEAD$ZLIB_HEAD$MBEDTLS_HEAD
}

parse_version() {
    if [ -z "$1" ] || [ -z "$2" ];
    then
	echo "error: Pass a define & file name."
	exit 1
    fi
    
    local VERSION=$(awk '/'$1'\s+\"([0-9A-Z\.\-]+)\"/{ print $3 }' $2 | cut -c 2- | rev | cut -c 2- | rev)
    echo $VERSION
}

CURL_VERSION=$(parse_version LIBCURL_VERSION curl/include/curl/curlver.h)
ZLIB_VERSION=$(parse_version ZLIB_VERSION zlib/zlib.h)
MBEDTLS_VERSION=$(parse_version MBEDTLS_VERSION_STRING mbedtls/include/mbedtls/version.h)

echo "$CURL_VERSION"
echo "$ZLIB_VERSION"
echo "$MBEDTLS_VERSION"
echo $(id)
