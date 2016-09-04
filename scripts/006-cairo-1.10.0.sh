#!/bin/sh
# cairo-1.12.18.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://cairographics.org/releases/cairo-1.12.18.tar.xz || { exit 1; }

## Unpack the source code.
rm -Rf cairo-1.12.18 && tar xfvJ cairo-1.12.18.tar.xz && cd cairo-1.12.18 || { exit 1; }

## Patch the source code.
cat ../../patches/cairo-1.12.18-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PS3DEV/host/ppu/include -DCAIRO_NO_MUTEX" \
LDFLAGS="-L$PS3DEV/host/ppu/lib -L$PSL1GHT/lib" \
PKG_CONFIG_PATH="$PS3DEV/host/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/host/ppu" --host="powerpc64-ps3-elf" --enable-fc="no" --enable-xlib="no" --enable-xcb="no" --disable-shared --disable-valgrind --enable-gobject="no" || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
