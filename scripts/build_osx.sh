#!/bin/bash -ex

cd "$(dirname "${BASH_SOURCE[0]}")"

build_mac()
{
    local ver=$1
    local output="../.build/macos_$ver"
    local objcflags="-std=c++11 -x objective-c++ -mmacosx-version-min=$ver"
    local cppflags="-std=c++11 -mmacosx-version-min=$ver"
    local ldflags="-framework Metal -framework CoreFoundation -fobjc-link-runtime"

    rm -Rf $output
    mkdir -p $output

    clang++ $objcflags -c ../mtlpp.mm -o $output/mtlpp.o

    clang++ $cppflags $ldflags ../examples/00_init.cpp $output/mtlpp.o -o $output/00_init
    clang++ $cppflags $ldflags ../examples/01_clear.cpp $output/mtlpp.o -o $output/01_clear
    clang++ $cppflags $ldflags ../examples/02_triangle.cpp $output/mtlpp.o -o $output/02_triangle
}

build_mac 10.9
build_mac 10.10
build_mac 10.11
build_mac 10.12

