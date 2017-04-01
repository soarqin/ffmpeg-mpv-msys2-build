download_file https://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.5.tar.gz/download
cd $SRC_ROOT/lame-3.99.5
if [ ! -f configure.orig ]; then
    cp configure configure.orig
    patch -p0 < $PATCH_ROOT/111-LAME-000-xmmintrin.patch
fi
compile_with_configure lame-3.99.5 --enable-static --disable-shared --disable-rpath --disable-frontend --enable-nasm
