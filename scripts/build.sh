#!/bin/bash -ex

rm -Rf .build
mkdir .build

build_mac()
{
    local ver=$1
    mkdir .build/macos_$ver

    clang++ -c -std=c++11 -x objective-c++ -mmacosx-version-min=$ver mtlpp.mm -o .build/macos_$ver/mtlpp.o -DMTLPP_CONFIG_USE_AVAILABILITY=0

    clang++ -std=c++11 -mmacosx-version-min=$ver examples/00_init.cpp .build/macos_$ver/mtlpp.o -o .build/macos_$ver/00_init -framework Metal -framework CoreFoundation -fobjc-link-runtime -DMTLPP_CONFIG_USE_AVAILABILITY=0
    clang++ -std=c++11 -mmacosx-version-min=$ver examples/01_clear.cpp .build/macos_$ver/mtlpp.o -o .build/macos_$ver/01_clear -framework Metal -framework CoreFoundation -fobjc-link-runtime -DMTLPP_CONFIG_USE_AVAILABILITY=0

    .build/macos_$ver/00_init
    .build/macos_$ver/01_clear
}

build_mac 10.9
build_mac 10.10
build_mac 10.11
build_mac 10.12
