#!/bin/bash -e

. ../../path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build$dir_suffix
	exit 0
else
	exit 255
fi

[ -f configure ] || ./autogen.sh

mkdir -p _build$dir_suffix
cd _build$dir_suffix

../configure \
	--host=$ndk_triple \
	--enable-static --disable-shared \
	--disable-require-system-font-provider

make -j6
make DESTDIR="`pwd`/../../../prefix$dir_suffix" install
