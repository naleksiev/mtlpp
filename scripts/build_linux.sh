#!/bin/bash -ex

cd "$(dirname "${BASH_SOURCE[0]}")"

build_linux()
{
    local ver=$1
    local output="../.build/linux_$ver"
    local cflags="-std=c++11 -c -m$ver"

    rm -Rf $output
    mkdir -p $output

    clang++ $cflags ../examples/00_init.cpp -o $output/00_init.o
    clang++ $cflags ../examples/01_clear.cpp -o $output/01_clear.o
    clang++ $cflags ../examples/02_triangle.cpp -o $output/02_triangle.o
    clang++ $cflags ../examples/03_compute.cpp -o $output/03_compute.o
}

#build_linux 32
build_linux 64

