download_file https://sourceforge.net/projects/lame/files/lame/3.99/lame-${LAME_VERSION}.tar.gz/download
if [ $result == true ]; then return; fi
patch_source lame-${LAME_VERSION} 111-LAME-000-xmmintrin.patch
compile_with_configure lame-${LAME_VERSION} --enable-static --disable-shared --disable-rpath --disable-frontend --enable-nasm
