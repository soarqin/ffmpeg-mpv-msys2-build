download_file http://download.sourceforge.net/libpng/libpng-${LIBPNG_VERSION}.tar.xz
if [ "$result" = true ]; then return; fi
compile_with_configure libpng-${LIBPNG_VERSION} --enable-static --disable-shared
