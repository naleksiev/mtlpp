#!/bin/bash -ex

cd "$(dirname "${BASH_SOURCE[0]}")"

build_mac()
{
    local ver=$1
    local output="../.build/macos_$ver"
    local objc_flags="-std=c++11 -x objective-c++ -mmacosx-version-min=$ver"
    local cpp_flags="-std=c++11 -mmacosx-version-min=$ver"
    local ld_flags="-framework Metal -framework CoreFoundation -fobjc-link-runtime"

    rm -Rf $output
    mkdir -p $output

    clang++ $objc_flags -c ../mtlpp.mm -o $output/mtlpp.o

    clang++ $cpp_flags $ld_flags ../examples/00_init.cpp $output/mtlpp.o -o $output/00_init
    clang++ $cpp_flags $ld_flags ../examples/01_clear.cpp $output/mtlpp.o -o $output/01_clear
    clang++ $cpp_flags $ld_flags ../examples/02_triangle.cpp $output/mtlpp.o -o $output/02_triangle
}

build_mac 10.9
build_mac 10.10
build_mac 10.11
build_mac 10.12

build_ios 7.0 armv7
build_ios 8.0 armv7
build_ios 9.0 armv7
build_ios 10.0 armv7

build_ios 7.0 armv7s
build_ios 8.0 armv7s
build_ios 9.0 armv7s
build_ios 10.0 armv7s

build_ios 7.0 arm64
build_ios 8.0 arm64
build_ios 9.0 arm64
build_ios 10.0 arm64

