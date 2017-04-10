LAME_VERSION=3.99.5
download_file https://sourceforge.net/projects/lame/files/lame/3.99/lame-${LAME_VERSION}.tar.gz/download
if [ $result == true ]; then return; fi
cd $SRC_ROOT/lame-${LAME_VERSION}
if [ ! -f configure.orig ]; then
    cp configure configure.orig
    patch -p0 < $PATCH_ROOT/111-LAME-000-xmmintrin.patch
fi
compile_with_configure lame-${LAME_VERSION} --enable-static --disable-shared --disable-rpath --disable-frontend --enable-nasm
