#!/bin/bash -ex

cd "$(dirname "${BASH_SOURCE[0]}")"

build_ios()
{
    local ver=$1
    local arch="$2"
    local output="../.build/ios_${ver}_${arch}"
    local sdk="--sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
    local objc_flags="-std=c++11 -x objective-c++ -miphoneos-version-min=$ver $sdk -arch $arch"
    local cpp_flags="-std=c++11 -miphoneos-version-min=$ver $sdk -arch $arch"
    local ld_flags="-framework Metal -framework CoreFoundation -fobjc-link-runtime"
    local clang="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++"

    rm -Rf $output
    mkdir -p $output

    $clang $objc_flags -c ../mtlpp.mm -o $output/mtlpp.o

    $clang $cpp_flags $ld_flags ../examples/00_init.cpp $output/mtlpp.o -o $output/00_init
    $clang $cpp_flags $ld_flags ../examples/01_clear.cpp $output/mtlpp.o -o $output/01_clear
    $clang $cpp_flags $ld_flags ../examples/02_triangle.cpp $output/mtlpp.o -o $output/02_triangle
}

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

